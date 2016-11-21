//
//  LJIMManager.h
//  LJChatView
//
//  Created by 刘俊杰 on 16/9/18.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LJIMConfigFile.h"

#import "LJIMManagerListener.h"
#import "LJIMLoginParam.h"


@interface LJIMManager : NSObject


@property (nonatomic, strong) TIMConversation *conversation;

+ (instancetype)sharedInstance;

//登录
- (void)loginIM:(LJIMLoginParam *)param succ:(void(^)())succ fail:(void(^)(NSInteger code, NSString * msg))fail;

//退出登录
- (void)logoutIM:(void(^)())succ fail:(void(^)(NSInteger code, NSString * msg))fail;

@end
