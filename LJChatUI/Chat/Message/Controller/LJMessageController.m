//
//  LJMessageController.m
//  LJChatView
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import "LJMessageController.h"
#import "LJShowImageController.h"
#import "LJMapController.h"

#import "LJElemCellHeader.h"

@interface LJMessageController ()<UITableViewDataSource, UITableViewDelegate,LJElemCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LJMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.msgModel.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TIMMessage *message = self.msgModel.messages[indexPath.row];
    TIMElem *elem = [message getElem:0];
    
    static NSArray *array;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[@"senderTextElemCell"    ,@"receiverTextElemCell",
                  @"senderImageElemCell"   ,@"receiverImageElemCell",
                  @"senderSoundElemCell"   ,@"receiverSoundElemCell",
                  @"senderLocationElemCell",@"receiverLocationElemCell",
                  @"senderVideoElemCell"   ,@"receiverVideoElemCell"];
    });
    BOOL isSelf = message.isSelf;
    NSInteger num = isSelf?0:1;
    if ([elem isKindOfClass:[TIMTextElem class]]) {
        num += 0;
    } else if ([elem isKindOfClass:[TIMImageElem class]]) {
        num += 2;
        
    } else if ([elem isKindOfClass:[TIMSoundElem class]]) {
        num += 4;
    } else if ([elem isKindOfClass:[TIMLocationElem class]]) {
        num += 6;
    } else if ([elem isKindOfClass:[TIMVideoElem class]]) {
        num += 8;
    }
    
    NSString *identifier = array[num];
    LJElemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                           forIndexPath:indexPath];
    cell.delegate = self;
    cell.isSelfBubble = isSelf;
    cell.message = message;
    
    return cell;
}

#pragma mark - LJElemCellDelegate

- (void)elemCell:(LJElemCell *)cell didTapBubbleIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[LJImageElemCell class]]) {
        LJImageElemCell *imageCell = (LJImageElemCell *)cell;
        LJShowImageController *showC = [LJShowImageController showImageControllerWithFile:imageCell.imageName];
        
        showC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        showC.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:showC animated:YES completion:nil];
        
    } else if ([cell isKindOfClass:[LJLocationElemCell class]]) {
//        LJLocationElemCell *locationCell = (LJLocationElemCell *)cell;
        
    } else if ([cell isKindOfClass:[LJSoundElemCell class]]) {
        LJSoundElemCell *soundCell = (LJSoundElemCell *)cell;
        if (soundCell.isPlaying) {
            [soundCell stopPlaySound];
        } else {
            [soundCell startPlaySound];
        }
    } else if ([cell isKindOfClass:[LJVideoElemCell class]]) {
//        LJVideoElemCell *soundCell = (LJVideoElemCell *)cell;
        
    }
}

@end
