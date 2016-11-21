//
//  NSObject+LDProperty.h
//  platform
//
//  Created by bujiong on 16/7/3.
//  Copyright © 2016年 bujiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(LDProperty)

+ (void)ld_iterateProperty:(void (^)(NSString *name, NSString *typeName, BOOL *stop))block;

@end
