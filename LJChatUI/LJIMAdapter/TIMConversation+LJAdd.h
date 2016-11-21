//
//  TIMConversation+LJAdd.h
//  LJChatView
//
//  Created by 刘俊杰 on 16/9/22.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <ImSDK/ImSDK.h>
#import "LJIMConfigFile.h"

@interface TIMConversation (LJAdd)
/**
 *  最后一条消息
 */
@property (nonatomic, strong) TIMMessage *lj_lastMessage;

/**
 *  当前最顶端的消息
 */
@property (nonatomic, strong) TIMMessage *lj_TopMessage;

/**
 对方的昵称
 */
@property (nonatomic, copy) NSString *lj_otherName;

@property (nonatomic, copy) NSString *lj_otherFaceURL;

@end
