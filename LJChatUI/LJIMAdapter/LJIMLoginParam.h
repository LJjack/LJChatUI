//
//  LJIMLoginParam.h
//  LJChatView
//
//  Created by 刘俊杰 on 16/9/18.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LJIMLoginParam : NSObject

/**
 用户名
 */
@property(nonatomic, copy) NSString *userID;

/**
 鉴权Token
 */
@property(nonatomic, copy) NSString *userToken; 

+ (instancetype)loginParamWithUserID:(NSString *)userID userToken:(NSString *)userToken;

- (instancetype)initWithUserID:(NSString *)userID userToken:(NSString *)userToken;

@end
