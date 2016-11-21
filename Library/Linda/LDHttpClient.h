//
//  LDHttpClient.h
//  platform
//
//  Created by bujiong on 16/7/2.
//  Copyright © 2016年 bujiong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LDRequestBuilder.h"

typedef void (^LDCompletionBlock)(NSData *data, NSUInteger status, NSError *error);

@interface LDHttpClient : NSObject

+ (instancetype)sharedClient;


/**
 发送请求

 @param request 请求
 @param block   回调

 @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)sendRequest:(LDRequest *)request
              block:(LDCompletionBlock)block;


/**
 发送文件，仅支持单文件发送

 @param fileData 文件数据
 @param block    回调
 */
- (void)sendFileData:(NSData *)fileData block:(LDCompletionBlock)block;

@end
