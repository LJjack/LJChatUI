//
//  NSDictionary+LJURL.h
//  RJ-DIS-FileQuery
//
//  Created by 刘俊杰 on 16/1/4.
//  Copyright © 2016年 LJ. All rights reserved.
//
//  字典与URLString之间的转化
#import <Foundation/Foundation.h>

@interface NSDictionary (LJURL)
/**
 *  @brief 将url参数字符串转化成NSDictionary
 *
 *  @param param url参数字符串
 *
 *  @return NSDictionary
 */
+ (nonnull NSDictionary *)lj_dictionaryWithURLParam:(NSString * _Nonnull )param;
/**
 *  @brief 将NSDictionary转化成url参数字符串
 *
 *  @return url参数字符串
 */
- (nonnull NSString *)lj_toURLString;

@end
