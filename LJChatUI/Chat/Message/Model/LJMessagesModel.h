//
//  LJMessagesModel.h
//  LJChatUI
//
//  Created by 刘俊杰 on 2016/11/21.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ImSDK/ImSDK.h>

#import "LJGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LJMessagesModel;

@protocol LJMessagesModelDelegate <NSObject>

@required

/**
 *  消息发送中
 */
- (void)messagesModel:(LJMessagesModel *)messagesModel sendRunningRowAtIndex:(NSUInteger)index;

/**
 *  消息发送完成
 */
- (void)messagesModel:(LJMessagesModel *)messagesModel didSendFinishRowAtIndex:(NSUInteger)index;

/**
 *  消息发送失败
 */

- (void)messagesModel:(LJMessagesModel *)messagesModel didSendFailRowAtIndex:(NSUInteger)index;

/**
 *  完成接受消息
 */
- (void)messagesModel:(LJMessagesModel *)messagesModel didReveiceFinishRowAtIndex:(NSUInteger)index;

@end

@interface LJMessagesModel : NSObject

/**
 当前会话
 */
@property (nonatomic, strong) TIMConversation *chatingConversation;

@property (nonatomic, strong) NSMutableArray<TIMMessage *> *messages;
//
@property (nonatomic, weak) id<LJMessagesModelDelegate> delegate;

@property (nonatomic, copy) NSString *otherName;


+ (instancetype)sharedInstance;

#pragma mark - 发送消息

- (void)sendTextMediaMessageWithText:(NSString *)text;

- (void)sendSoundMediaMessageWithData:(nonnull NSData *)soundData
                               second:(int)second ;

- (void)sendPhotoMediaMessageWithImage:(nonnull id)image;

- (void)sendLocationMediaMessageLatitude:(double)latitude
                               longitude:(double)longitude
                       completionHandler:(void (^)())completion;

- (void)sendShortVideoMediaMessageWithVideoPath:(nonnull NSString *)videoPath
                                      showImage:(nonnull UIImage *)showImage;

- (void)sendGoodsMediaMessageWithModel:(LJGoodsModel *)model;

- (void)sendOrderInfoMediaMessageWithModel:(LJGoodsModel *)model;

#pragma mark - 接受消息
/**
 *  接受消息
 *
 *  @param message 消息
 *  @param isAtTop 是否是新消息，是在数组0位置添加，还是在数组最后追加
 */
- (void)reveiceMessage:(TIMMessage *)message isAtTop:(BOOL)isAtTop ;

#pragma mark - 重新发送

- (void)reSendAtIndex:(NSUInteger)index;

#pragma mark - 删除

- (void)removeAtIndex:(NSUInteger)index;

#pragma mark- 加载更多数据

- (void)loadMoreMessageData:(void(^)())succ fail:(void(^)(int code, NSString *msg))fail;

#pragma mark - 获取自己的userId

- (NSString *)handleGetSelfUserId;

@end

NS_ASSUME_NONNULL_END
