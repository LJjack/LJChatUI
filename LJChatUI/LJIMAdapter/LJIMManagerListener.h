//
//  LJIMManagerListener.h
//  LJChatView
//
//  Created by 刘俊杰 on 16/9/18.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ImSDK/ImSDK.h>
#import "TIMConversation+LJAdd.h"

@interface LJIMManagerListener : NSObject<TIMConnListener, TIMMessageListener, TIMUserStatusListener>

@property (nonatomic, strong) NSMutableArray<TIMConversation *> *conversationList;

/**
 正在聊天的会话
 */
@property (nonatomic, strong) TIMConversation *chattingConversation;

/**
 判断在线情况
 */
@property (nonatomic, assign) BOOL isConnectSucceed;

/**
 所有未读消息的个数
 */
@property (nonatomic, assign) NSUInteger allUnreadMessageNum;


+ (instancetype)sharedInstance;

/**
 *  获取会话（TIMConversation*）列表
 *
 *  @return 会话列表
 */
-(NSArray*)getConversationList;

/**
 *  获取会话
 *
 *  @param type 会话类型，TIM_C2C 表示单聊 TIM_GROUP 表示群聊
 *  @param receiver C2C 为对方用户 identifier， GROUP 为群组Id
 *
 *  @return 会话对象
 */
-(TIMConversation*)getConversation:(TIMConversationType)type receiver:(NSString *)receiver;

/**
 *  打开新的会话
 */
- (void)openNewConversation;


/**
 *  移除指定位置的会话
 *
 *  @param index 位置
 *
 *  @return BOOL
 */
- (BOOL)removeConversationListAtIndex:(NSUInteger)index;

/**
 *  移除所有的会话
 */
- (void)removeAllConversationList;

@end
