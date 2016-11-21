//
//  LDRequestBuilder.h
//  platform
//
//  Created by bujiong on 16/6/30.
//  Copyright © 2016年 bujiong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LDRequest.h"

@class LDRequestBuilder;

typedef LDRequestBuilder *(^AddNotParam)();
typedef LDRequestBuilder *(^AddOneStringParam)(NSString *name);
typedef LDRequestBuilder *(^AddOneIntParam)(NSInteger num);
typedef LDRequestBuilder *(^AddOneArrayParam)(NSArray *array);
typedef LDRequestBuilder *(^AddKeyValue)(NSString *key, id value);

/**
 * 用来创建LDRequest对象
 */
@interface LDRequestBuilder : NSObject

@property (class, strong, readonly) LDRequestBuilder *createBuilder;

/**
 POST请求
 
 */
@property (nonatomic, copy, readonly) AddNotParam HTTPPOST;

/**
 GET请求
 */
@property (nonatomic, copy, readonly) AddNotParam HTTPGET;

/**
 添加签名
 */
@property (nonatomic, copy, readonly) AddNotParam HTTPSign;

/**
 请求上线文路径，即使端口后第一个参数路径
 */
@property (nonatomic, copy, readonly) AddOneStringParam path;

/**
 请求方法名，即使端口后第二个参数路径
 */
@property (nonatomic, copy, readonly) AddOneStringParam method;

/**
 添加参数，参数会被编码到url中。任何请求都可以携带参数。
 */
@property (nonatomic, copy, readonly) AddKeyValue URLParam;

/**
 添加内容，内容会被作为请求体的组成部分。
 */
@property (nonatomic, copy, readonly) AddKeyValue formParam;

/**
 添加上传多文件
 */
@property (nonatomic, copy, readonly) AddOneArrayParam uploadFiles;

/**
 设置超时时间, 不设置默认是30s
 */
@property (nonatomic, copy, readonly) AddOneIntParam timeout;

/**
 构建请求
 */
@property (nonatomic, strong, readonly) LDRequest *request;

- (LDRequest *)buildRequest;

@end
