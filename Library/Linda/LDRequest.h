//
//  LDRequest.h
//  platform
//
//  Created by bujiong on 16/6/30.
//  Copyright © 2016年 bujiong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 业务请求对象
 */
@interface LDRequest : NSObject

#pragma mark - 请求配置URL

//网络请求基地址
@property(nonatomic, copy, readonly) NSString *baseAddress;


// 调用服务端api对应的路径
@property(nonatomic, copy) NSString *contextPath;

// api对应方法名
@property(nonatomic, copy) NSString *methodName;

// url参数
@property(nonatomic, copy) NSString *urlParam;

// post、put请求的数据
@property(nonatomic, copy) NSString *formParam;

// 超时设置
@property(nonatomic, assign) NSInteger timeout;

// http方法名
@property(nonatomic, copy) NSString *httpMethod;

/** 是否签名 */
@property (nonatomic, assign) BOOL isSignature;

#pragma mark - 请求设置

// 唯一标识一个请求
@property(nonatomic, assign) NSInteger requestId;

/** 模型的Class String 必须赋值 */
@property(nonatomic, copy) NSString *modelClassString;

// 模型的Class
@property (nonatomic, weak, readonly) Class modelClass;

/** 上传文件数组，数组内包含上传文件的文件名 */
@property(nonatomic, copy) NSArray<NSString *> *uploadFileArray;

@property (nonatomic, strong, readonly) NSURLRequest *request;

@property (nonatomic, strong, readonly) NSURLRequest *fileRequest;
@end
