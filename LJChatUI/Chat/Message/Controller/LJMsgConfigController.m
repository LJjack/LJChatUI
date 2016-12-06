//
//  LJMsgConfigController.m
//  BJShop
//
//  Created by 刘俊杰 on 16/11/4.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import "LJMsgConfigController.h"

#import "UIView+GJCFViewFrameUitil.h"
#import "GJGCChatInputPanel.h"

#import <TZImagePickerController/TZImagePickerController.h>
#import <TZImagePickerController/TZImageManager.h>
#import <AVFoundation/AVFoundation.h>

#import "LJRecordVideoView.h"
#import "LJLocationManager.h"

#import "UIImage+LJVideo.h"
#import "UIViewController+LJHUD.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface LJMsgConfigController ()<GJGCChatInputPanelDelegate, TZImagePickerControllerDelegate, LJRecordVideoViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, LJMessagesModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) GJGCChatInputPanel *inputPanel;

@property (nonatomic, strong) LJSoundModel *currentRecordFile;

@end

@implementation LJMsgConfigController

- (void)dealloc {
    [self.inputPanel removeObserver:self forKeyPath:@"frame"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.msgModel.delegate = self;
    [self configureMessagesInputPanel];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self scrollToBottomAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//========================   输入键盘工具 开始  ================================

- (void)configureMessagesInputPanel {
    CGFloat originY = 0;
    /* 输入面板 */
    self.inputPanel = [[GJGCChatInputPanel alloc] initWithPanelDelegate:self];
    self.inputPanel.frame = (CGRect){0,kScreenHeight - self.inputPanel.inputBarHeight-originY,kScreenWidth,self.inputPanel.inputBarHeight+216};
    
    __weak typeof(self) weakSelf = self;
    [self.inputPanel configInputPanelKeyboardFrameChange:^(GJGCChatInputPanel *panel,CGRect keyboardBeginFrame, CGRect keyboardEndFrame, NSTimeInterval duration,BOOL isPanelReserve) {
        /* 不要影响其他不带输入面板的系统视图对话 */
        if (panel.hidden) {
            return ;
        }
        
        [UIView animateWithDuration:duration animations:^{
            weakSelf.tableView.gjcf_height = kScreenHeight - weakSelf.inputPanel.inputBarHeight - originY - keyboardEndFrame.size.height;
            if (keyboardEndFrame.origin.y == kScreenHeight) {
                if (isPanelReserve) {
                    weakSelf.inputPanel.gjcf_top = kScreenHeight - weakSelf.inputPanel.inputBarHeight  - originY;
                    weakSelf.tableView.gjcf_height = kScreenHeight - weakSelf.inputPanel.inputBarHeight - originY;
                } else {
                    weakSelf.inputPanel.gjcf_top = kScreenHeight - 216 - weakSelf.inputPanel.inputBarHeight - originY;
                    weakSelf.tableView.gjcf_height = kScreenHeight - weakSelf.inputPanel.inputBarHeight - originY - 216;
                }
            } else {
                weakSelf.inputPanel.gjcf_top = weakSelf.tableView.gjcf_bottom;
            }
        }];
        
        [weakSelf.tableView scrollRectToVisible:CGRectMake(0, weakSelf.tableView.contentSize.height - weakSelf.tableView.bounds.size.height, weakSelf.tableView.gjcf_width, weakSelf.tableView.gjcf_height) animated:NO];
//        [weakSelf scrollToBottomAnimated:NO];
    }];
    
    [self.inputPanel configInputPanelRecordStateChange:^(GJGCChatInputPanel *panel, BOOL isRecording) {
        if (isRecording) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.tableView.userInteractionEnabled = NO;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.tableView.userInteractionEnabled = YES;
            });
        }
    }];
    
    [self.inputPanel configInputPanelInputTextViewHeightChangedBlock:^(GJGCChatInputPanel *panel, CGFloat changeDelta) {
        panel.gjcf_top = panel.gjcf_top - changeDelta;
        
        panel.gjcf_height = panel.gjcf_height + changeDelta;
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.tableView.gjcf_height = weakSelf.tableView.gjcf_height - changeDelta;
        }];
        [weakSelf.tableView scrollRectToVisible:CGRectMake(0, weakSelf.tableView.contentSize.height - weakSelf.tableView.bounds.size.height, weakSelf.tableView.gjcf_width, weakSelf.tableView.gjcf_height) animated:NO];
//        [weakSelf scrollToBottomAnimated:NO];
    }];
    
    /* 动作变化 */
    [self.inputPanel setActionChangeBlock:^(GJGCChatInputBar *inputBar, GJGCChatInputBarActionType toActionType) {
        [weakSelf inputBar:inputBar changeToAction:toActionType];
    }];
    [self.view addSubview:self.inputPanel];
    
    /* 观察输入面板变化 */
    [self.inputPanel addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - 恢复输入面板到初始状态

- (void)reserveChatInputPanelState {
    /* 收起输入键盘 */
    [UIView animateWithDuration:0.26 animations:^{
        if (self.inputPanel.isFullState) {
            CGFloat originY = 0;
            self.inputPanel.gjcf_top = kScreenHeight - self.inputPanel.inputBarHeight - originY;
            self.tableView.transform = CGAffineTransformIdentity;
            [self.inputPanel reserveState];
        }
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.inputPanel isInputTextFirstResponse]) {
        [self.inputPanel inputBarRegsionFirstResponse];
    }
    [self reserveChatInputPanelState];
}

#pragma mark - 属性变化观察
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"] && object == self.inputPanel) {
        CGRect newFrame = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue];
        CGFloat originY = 0;
        //50.f 高度是输入条在底部的时候显示的高度，在录音状态下就是50
        if (newFrame.origin.y < kScreenHeight - 50.f - originY) {
            self.inputPanel.isFullState = YES;
        }else{
            self.inputPanel.isFullState = NO;
        }
    }
}

#pragma mark - 输入动作变化

- (void)inputBar:(GJGCChatInputBar *)inputBar changeToAction:(GJGCChatInputBarActionType)actionType {
    CGFloat originY = 0;
    
    switch (actionType) {
        case GJGCChatInputBarActionTypeRecordAudio: {
            if (self.inputPanel.isFullState) {
                [UIView animateWithDuration:0.26 animations:^{
                    self.inputPanel.gjcf_top = kScreenHeight - self.inputPanel.inputBarHeight - originY;
                    self.tableView.gjcf_height = kScreenHeight - self.inputPanel.inputBarHeight - originY;
                    
                }];
                
                [self.tableView scrollRectToVisible:CGRectMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height, self.tableView.gjcf_width, self.tableView.gjcf_height) animated:NO];
//                [self scrollToBottomAnimated:NO];
            }
        } break;
        case GJGCChatInputBarActionTypeChooseEmoji:
        case GJGCChatInputBarActionTypeExpandPanel: {
            if (!self.inputPanel.isFullState) {
                [UIView animateWithDuration:0.26 animations:^{
                    self.inputPanel.gjcf_top = kScreenHeight - self.inputPanel.inputBarHeight - 216 - originY;
                    self.tableView.gjcf_height = kScreenHeight - self.inputPanel.inputBarHeight - 216 - originY;
                }];
                
                [self.tableView scrollRectToVisible:CGRectMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height, self.tableView.gjcf_width, self.tableView.gjcf_height) animated:NO];
//                [self scrollToBottomAnimated:NO];
            }
        } break;
        default:
            break;
    }
}

#pragma mark - GJGCChatInputPanelDelegate

- (void)chatInputPanel:(GJGCChatInputPanel *)panel sendTextMessage:(NSString *)text {
    [self.msgModel sendTextMediaMessageWithText:text];
}

- (void)chatInputPanel:(GJGCChatInputPanel *)panel didFinishRecord:(LJSoundModel *)soundModel {
    self.currentRecordFile = soundModel;
    [self.msgModel sendSoundMediaMessageWithData:soundModel.data second:soundModel.second];
}

- (void)chatInputPanel:(GJGCChatInputPanel *)panel didChooseMenuAction:(GJGCChatInputMenuPanelActionType)actionType {
    switch (actionType) {
        case GJGCChatInputMenuPanelActionTypePhotoLibrary: {
            [self openNativePhotoLibrary];
        } break;
        case GJGCChatInputMenuPanelActionTypeCamera: {
            [self shootCamera];
        } break;
        case GJGCChatInputMenuPanelActionTypeSmallVideo: {
            [self shootSmallVideo];
        } break;
        case GJGCChatInputMenuPanelActionTypeLocation: {
            [self obtainCurrentLocation];
        } break;
        default:
            break;
    }
}

#pragma mark - 输入框工具

//打开本地图片和视频
- (void)openNativePhotoLibrary {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
    //四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = YES;
    
    // 1.如果你需要将拍照按钮放在外面，不要传这个参数
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

//拍摄图片
- (void)shootCamera {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        // 无权限 做一个友好的提示
        NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
        if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
        NSString *message = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"中允许%@访问相机",appName];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
#pragma clang diagnostic pop
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = sourceType;
            imagePickerController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}
//拍小视频
- (void)shootSmallVideo {
    // 隐藏键盘
    [self reserveChatInputPanelState];
    
    if ([[AVCaptureDevice class] respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus videoStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (videoStatus == 	AVAuthorizationStatusRestricted || videoStatus == AVAuthorizationStatusDenied) {
            // 没有权限
            [self lj_showHint:@"您没有打开相机权限"];
            return;
        }
        
        AVAuthorizationStatus audioStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        if (audioStatus == 	AVAuthorizationStatusRestricted || audioStatus == AVAuthorizationStatusDenied) {
            // 没有权限
            [self lj_showHint:@"您没有打开麦克风权限"];
            return;
        }
        __weak typeof(self) weakSelf = self;
        if (videoStatus == AVAuthorizationStatusNotDetermined) {
            //请求相机权限
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if(granted) {
                    AVAuthorizationStatus audio = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
                    if (audio == AVAuthorizationStatusNotDetermined) {
                        //请求麦克风权限
                        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted){
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (granted) {
                                    [weakSelf addRecordVideoView];
                                }
                            });
                        }];
                    } else {//这里一定是有麦克风权限了
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf addRecordVideoView];
                        });
                    }
                }
                
            }];
        } else {//这里一定是有相机权限了
            if (audioStatus == AVAuthorizationStatusNotDetermined) {
                //请求麦克风权限
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (granted) {
                            [weakSelf addRecordVideoView];
                        }
                    });
                }];
            } else {//这里一定是有麦克风权限了
                [weakSelf addRecordVideoView];
            }
        }
    }
}

//获取当前位置
- (void)obtainCurrentLocation {
    LJLocationManager *manager = [LJLocationManager sharedManager];
    
    [self.msgModel sendLocationMediaMessageLatitude:manager.latitude longitude:manager.longitude completionHandler:^{
//        [self.tableView reloadData];
    }];
}

- (void)addRecordVideoView {
    CGFloat selfWidth  = self.view.bounds.size.width;
    CGFloat selfHeight = self.view.bounds.size.height;
    LJRecordVideoView *videoView = [[LJRecordVideoView alloc] initWithFrame:CGRectMake(0, selfHeight/3, selfWidth, selfHeight * 2/3)];
    videoView.delegate = self;
    [self.view addSubview:videoView];
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    for (UIImage *image in photos) {
        [self.msgModel sendPhotoMediaMessageWithImage:image];
    }
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    // 打开这段代码发送视频
    __weak typeof(self) weakSelf = self;
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
        NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        //导出完成，在这里写上传代码，通过路径或者通过NSData上传
        [weakSelf.msgModel sendShortVideoMediaMessageWithVideoPath:outputPath showImage:coverImage];
        
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.msgModel sendPhotoMediaMessageWithImage:image];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - LJRecordVideoViewDelegate

- (void)recordVideoViewTouchUpDone:(NSString *)savePath {
    NSError *err = nil;
    NSData* data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:savePath] options:NSDataReadingMappedIfSafe error:&err];
    //文件最大不超过28MB
    if(data.length < 28 * 1024 * 1024) {
        UIImage *showImage = [UIImage lj_imageVideoCaptureVideoPath:savePath];
        //UISaveVideoAtPathToSavedPhotosAlbum(savePath, nil, nil, nil);
        [self.msgModel sendShortVideoMediaMessageWithVideoPath:savePath showImage:showImage];
        
        NSLog(@"==== %@", savePath);
    } else {
        [self lj_showHint:@"发送的文件过大"];
        NSLog(@"发送的文件过大");
    }
}

//========================   输入键盘工具 结束  ================================

#pragma mark - LJMessagesModelDelegate

- (void)messagesModel:(LJMessagesModel *)messagesModel sendRunningRowAtIndex:(NSUInteger)index {
    [self finishSendingMessage];
}

- (void)messagesModel:(LJMessagesModel *)messagesModel didSendFinishRowAtIndex:(NSUInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    LJElemCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.status = TIM_MSG_STATUS_SEND_SUCC;
}

- (void)messagesModel:(LJMessagesModel *)messagesModel didSendFailRowAtIndex:(NSUInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    LJElemCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.status = TIM_MSG_STATUS_SEND_FAIL;
}

- (void)messagesModel:(LJMessagesModel *)messagesModel didReveiceFinishRowAtIndex:(NSUInteger)index {
    [self finishReceivingMessage];
}

#pragma mark - 公开方法

- (void)finishSendingMessage {
    [self finishSendingMessageAnimated:YES];
}

- (void)finishSendingMessageAnimated:(BOOL)animated {
    [self tableViewInsertRowAtLastIndexPath];
    [self scrollToBottomAnimated:animated];
}

- (void)finishReceivingMessage {
    [self finishReceivingMessageAnimated:YES];
}

- (void)finishReceivingMessageAnimated:(BOOL)animated {
    [self tableViewInsertRowAtLastIndexPath];
    [self scrollToBottomAnimated:animated];
}

- (void)tableViewInsertRowAtLastIndexPath {
    [self.tableView beginUpdates];
    NSIndexPath *lastCell = [NSIndexPath indexPathForRow:self.msgModel.messages.count -1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[lastCell] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
}

- (void)scrollToBottomAnimated:(BOOL)animated {
    NSUInteger rows = [self.tableView numberOfRowsInSection:0];
    if (!rows) return;
    
    NSIndexPath *lastCell = [NSIndexPath indexPathForRow:rows - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastCell
                          atScrollPosition:UITableViewScrollPositionBottom
                                  animated:animated];
}

@end
