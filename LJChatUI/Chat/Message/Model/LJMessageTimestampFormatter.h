//
//  LJMessageTimestampFormatter.h
//  LJChatUI
//
//  Created by 刘俊杰 on 2016/11/21.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJMessageTimestampFormatter : NSObject


@property (strong, nonatomic, readonly) NSDateFormatter *dateFormatter;

@property (copy, nonatomic) NSDictionary *dateTextAttributes;

@property (copy, nonatomic) NSDictionary *timeTextAttributes;

+ (instancetype)sharedFormatter;

- (NSString *)timestampForDate:(NSDate *)date;

- (NSAttributedString *)attributedTimestampForDate:(NSDate *)date;

- (NSString *)timeForDate:(NSDate *)date;

- (NSString *)relativeDateForDate:(NSDate *)date;

@end
