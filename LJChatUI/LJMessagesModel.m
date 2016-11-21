//
//  LJMessagesModel.m
//  LJChatUI
//
//  Created by 刘俊杰 on 2016/11/21.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import "LJMessagesModel.h"

#import "LJIMManagerListener.h"

@interface LJMessagesModel ()

@property (nonatomic, strong) NSMutableDictionary *failMessages;

@property (nonatomic, strong) NSMutableArray *runMessages;//旧的消息还在运行状态

@end

@implementation LJMessagesModel

+ (instancetype)sharedInstance {
    return  [[LJMessagesModel alloc] init];
}

- (void)dealloc {
    [self addOrRemoveNotificationCenter:NO];
    [LJIMManagerListener sharedInstance].chattingConversation = nil;
}

- (instancetype)init {
    if (self = [super init]) {
        self.messages = [NSMutableArray array];
        [self addOrRemoveNotificationCenter:YES];
    }
    
    return self;
}

#pragma mark - 发送消息

#pragma mark 发送文字
- (void)sendTextMediaMessageWithText:(NSString *)text {
    NSAssert(text || text.length , @"文字不能为 nil 或长度为 0");
    
    TIMMessage *message = [[TIMMessage alloc] init];
    [self messageSetOfflinePushInfo:message];
    TIMTextElem *elem = [[TIMTextElem alloc] init];
    elem.text = text;
    [message addElem:elem];
    
    [self sendMessage:message];
}

#pragma mark 发送照片

- (void)sendPhotoMediaMessageWithImage:(nonnull id)image {
    if ([image isKindOfClass:[NSString class]]) {
        image = [UIImage imageWithContentsOfFile:image];
    }
    if (![image isKindOfClass:[UIImage class]]) {
        NSAssert(NO , @"image获得不了图片或image路径下获得不了图片");
    }
    
    
    TIMMessage *message = [[TIMMessage alloc] init];
    [self messageSetOfflinePushInfo:message];
    TIMImageElem *elem = [[TIMImageElem alloc] init];
    
    elem.path = [self createdUploadImagePathWith:image];
    [message addElem:elem];
    
    [self sendMessage:message];
}


#pragma mark 发送音频
- (void)sendSoundMediaMessageWithData:(nonnull NSData *)soundData second:(int)second {
    NSAssert(soundData || soundData.length , @"音频数据不能为 nil 或长度为 0");
    
    TIMMessage *message = [[TIMMessage alloc] init];
    [self messageSetOfflinePushInfo:message];
    TIMSoundElem *elem = [[TIMSoundElem alloc] init];
    elem.data = soundData;
    elem.second = second;
    [message addElem:elem];
    
    [self sendMessage:message];
}

#pragma mark 发送当前位置
- (void)sendLocationMediaMessageLatitude:(double)latitude
                               longitude:(double)longitude
                       completionHandler:(void (^)())completion{
    
    TIMMessage *message = [[TIMMessage alloc] init];
    [self messageSetOfflinePushInfo:message];
    TIMLocationElem *elem = [[TIMLocationElem alloc] init];
    elem.latitude = latitude;
    elem.longitude = longitude;
    [message addElem:elem];
    
    [self sendMessage:message];
}

#pragma mark 发送微视频
- (void)sendShortVideoMediaMessageWithVideoPath:(nonnull NSString *)videoPath
                                      showImage:(nonnull UIImage *)showImage {
    
    TIMMessage *message = [[TIMMessage alloc] init];
    [self messageSetOfflinePushInfo:message];
    TIMVideoElem *videoElem = [[TIMVideoElem alloc] init];
    TIMVideo* video = [[TIMVideo alloc] init];
    video.type = @"mp4";
    TIMSnapshot* snapshot = [[TIMSnapshot alloc] init];
    videoElem.video = video;
    videoElem.snapshot = snapshot;
    videoElem.videoPath = videoPath;
    videoElem.snapshotPath = [self createdUploadImagePathWith:showImage];
    [message addElem:videoElem];
    
    [self sendMessage:message];
}

#pragma mark 商品信息
- (void)sendGoodsMediaMessageWithModel:(LJGoodsModel *)model {
    model.type = LJGoodsModelTypeProduct;
    
    TIMMessage *message = [[TIMMessage alloc] init];
    [self messageSetOfflinePushInfo:message];
    TIMCustomElem *elem = [[TIMCustomElem alloc] init];
    elem.data = [model modelToData];
    [message addElem:elem];
    
    [self sendMessage:message];
}

#pragma mark 订单咨询
- (void)sendOrderInfoMediaMessageWithModel:(LJGoodsModel *)model {
    model.type = LJGoodsModelTypeOrderInfo;
    
    TIMMessage *message = [[TIMMessage alloc] init];
    [self messageSetOfflinePushInfo:message];
    TIMCustomElem *elem = [[TIMCustomElem alloc] init];
    elem.data = [model modelToData];
    [message addElem:elem];
    
    [self sendMessage:message];
}

#pragma mark - 接受消息

- (void)reveiceMessage:(TIMMessage *)message isAtTop:(BOOL)isAtTop {
    if (isAtTop) {
        [self.messages insertObject:message atIndex:0];
    } else {
        [self.messages addObject:message];
    }
    
}



// 接受商品
- (void)reveiceGoods:(TIMCustomElem *)elem
            senderId:(NSString *)senderId
         displayName:(NSString *)displayName
                date:(NSDate *)date
            outgoing:(BOOL)outgoing
             isAtTop:(BOOL)isAtTop
               state:(NSUInteger)state {
//    LJGoodsModel *model = [LJGoodsModel yy_modelWithJSON:elem.data];
//    JSQMediaItem *item;
//    if (model.type == LJGoodsModelTypeOrderMsg) {
//        item = [[LJOrderMediaItem alloc] initWithModel:nil];
//        
//    } else {
//        item = [[LJGoodsMediaItem alloc] initWithModel:nil];
//    }
//    item.appliesMediaViewMaskAsOutgoing = outgoing;
//    JSQMessage *jsqMessage = [[JSQMessage alloc] initWithSenderId:senderId
//                                                senderDisplayName:displayName
//                                                             date:date
//                                                            media:item];
//    jsqMessage.dataState = state;
//    if (isAtTop) {
//        [self.messages insertObject:jsqMessage atIndex:0];
//    } else {
//        [self.messages addObject:jsqMessage];
//    }
//    NSUInteger index = [self.messages indexOfObject:jsqMessage];
//    [self willReveiceMessageItemAtIndex:index];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (model.type == LJGoodsModelTypeOrderMsg) {
//            [(LJOrderMediaItem *)item setModel:model];
//            
//        } else {
//            [(LJGoodsMediaItem *)item setModel:model];
//        }
//        
//        [self didReveiceFinishMessageItemAtIndex:index];
//    });
    
}

#pragma mark - 重新发送

- (void)reSendAtIndex:(NSUInteger)index {
//    TIMMessage * message = self.failMessages[@(index)];
//    
//    if (message && index < self.messages.count) {
//        JSQMessage *jsqMessage = self.messages[index];
//        [self.messages removeObjectAtIndex:index];
//        [self.messages addObject:jsqMessage];
//        
//        [jsqMessage setDataState:NSUIntegerRuning];
//        [self sendMessage:message];
//    }
}

#pragma mark - 删除

// 删除指定位置的消息
- (void)removeAtIndex:(NSUInteger)index {
//    NSUInteger totalCount = self.messages.count;
//    
//    [self.chatingConversation getLocalMessage:(int)totalCount last:nil succ:^(NSArray *msgs) {
//        NSInteger num = totalCount - index - 1;
//        if (num > -1 && num < msgs.count) {
//            TIMMessage *message = msgs[num];
//            [message remove];
//            [message delFromStorage];
//        }
//        
//        
//        
//    } fail:^(int code, NSString *msg) {
//        
//    }];
//    if (index < self.messages.count) {
//        [self.messages removeObjectAtIndex:index];
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:LJIMNotificationCenterUpdataChatUI object:nil];
    
}

#pragma mark- 加载更多数据

- (void)loadMoreMessageData:(void(^)())succ fail:(void(^)(int code, NSString *msg))fail {
//    TIMMessage *topMessage = self.chatingConversation.lj_TopMessage;
//    NSLog(@"=== %@",topMessage);
//    if (topMessage) {
//        [self.chatingConversation getMessage:20 last:self.chatingConversation.lj_TopMessage succ:^(NSArray *msgs) {
//            NSLog(@"加载更多数据 %lu",(unsigned long)msgs.count);
//            [self handleReveicedOldMessage:msgs];
//            if (succ) succ();
//            
//        } fail:^(int code, NSString *msg) {
//            NSLog(@"== %d   msg=%@",code,msg);
//            if (fail) fail(code, msg);
//        }];
//    } else {
//        if (succ) succ();
//    }
    
}

#pragma mark - 获取自己的userId

- (NSString *)handleGetSelfUserId {
    return [self.chatingConversation getSelfIdentifier];
}

#pragma mark - Private Methods

- (void)sendMessage:(TIMMessage*)message {
    

    
    [self.chatingConversation sendMessage:message succ:^{
        
        
        NSLog(@"发送 成功");
    } fail:^(int code, NSString *msg) {
        
        NSLog(@"发送 失败 msg = %@",msg);
        
    }];
    
    self.chatingConversation.lj_lastMessage = message;
    [[NSNotificationCenter defaultCenter] postNotificationName:LJIMNotificationCenterUpdataChatUI object:nil];
}

//创建上传图片路径
- (NSString *)createdUploadImagePathWith:(UIImage *)image {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *nsTmpDIr = NSTemporaryDirectory();
    NSString *filePath = [NSString stringWithFormat:@"%@uploadFile%3.f", nsTmpDIr, [NSDate timeIntervalSinceReferenceDate]];
    BOOL isDirectory = NO;
    NSError *err = nil;
    
    // 当前sdk仅支持文件路径上传图片，将图片存在本地
    if ([fileManager fileExistsAtPath:filePath isDirectory:&isDirectory]) {
        if (![fileManager removeItemAtPath:nsTmpDIr error:&err]) {
            NSLog(@"Upload Image Failed: same upload filename: %@", err);
            return nil;
        }
    }
    if (![fileManager createFileAtPath:filePath contents:UIImageJPEGRepresentation(image, 0.75) attributes:nil]) {
        NSLog(@"Upload Image Failed: fail to create uploadfile: %@", err);
        return nil;
    }
    return filePath;
}


//配置推送发送者
- (void)messageSetOfflinePushInfo:(TIMMessage *)message {
    TIMOfflinePushInfo *info = [[TIMOfflinePushInfo alloc] init];
    info.ext = [NSString stringWithFormat:@"{\"fromUserId\":\"%@\"}",[self handleGetSelfUserId]];
    [message setOfflinePushInfo:info];
}

#pragma mark - Setters

- (void)setChatingConversation:(TIMConversation *)chatingConversation {
    _chatingConversation = chatingConversation;
    
    
    NSString *receiver = [chatingConversation getReceiver];
    self.otherName = receiver;
    
    [[TIMFriendshipManager sharedInstance] GetFriendsProfile:@[receiver] succ:^(NSArray *friends) {
        TIMUserProfile *friend = [friends firstObject];
        if (friend.nickname.length) {
            self.otherName = [receiver isEqualToString:@"10000"] ? @"订单消息" :friend.nickname;
        }
       
        
    } fail:^(int code, NSString *msg) {
        
    }];
    
    NSArray<TIMMessage *> *msgs =  [chatingConversation getLastMsgs:20];
    [self handleReveicedOldMessage:msgs];
}

- (void)handleReveicedOldMessage:(NSArray<TIMMessage *> *)msgs {
    
    [msgs enumerateObjectsUsingBlock:^(TIMMessage * _Nonnull message, NSUInteger idx, BOOL * _Nonnull stop) {
        TIMMessageStatus status = [message status];
        if (status == TIM_MSG_STATUS_SENDING) {
            [self.runMessages addObject:@(idx)];
        }
        if (status == TIM_MSG_STATUS_HAS_DELETED) { // 过滤消息被删除
            [message delFromStorage];
        } else {
            self.chatingConversation.lj_TopMessage = message;
            [self reveiceMessage:message isAtTop:YES];
            if (status == TIM_MSG_STATUS_SEND_FAIL) { //记录消息发送失败
                self.failMessages[@(idx)] =  message;
            }
            
        }
    }];
}

- (void)addOrRemoveNotificationCenter:(BOOL)isAdd {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    if (isAdd) {
        [defaultCenter addObserver:self selector:@selector(hanleReveiceNewMessage:) name:LJIMNotificationCenterReveicedNewMessage object:nil];
    } else {
        [defaultCenter removeObserver:self name:LJIMNotificationCenterReveicedNewMessage object:nil];
    }
}

- (void)hanleReveiceNewMessage:(NSNotification *)info {
    TIMMessage *newMessage = (TIMMessage *)info.object;
    [self reveiceMessage:newMessage isAtTop:NO];
}

@end
