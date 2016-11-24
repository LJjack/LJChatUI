//
//  NSAttributedString+LJEmoji.h
//  LJChatUI
//
//  Created by 刘俊杰 on 2016/11/22.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (LJEmoji)

+ (NSAttributedString *)lj_formateContent:(NSString *)comment
                               attributes:(NSDictionary *)attributes;

@end
