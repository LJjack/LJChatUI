//
//  LJMessageTimestampFormatter.m
//  LJChatUI
//
//  Created by 刘俊杰 on 2016/11/21.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import "LJMessageTimestampFormatter.h"

@interface LJMessageTimestampFormatter ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation LJMessageTimestampFormatter

+ (instancetype)sharedFormatter {
    static LJMessageTimestampFormatter *_sharedFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFormatter = [[LJMessageTimestampFormatter alloc] init];
    });
    
    return _sharedFormatter;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[NSLocale currentLocale]];
        [_dateFormatter setDoesRelativeDateFormatting:YES];
        
        UIColor *color = [UIColor lightGrayColor];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        _dateTextAttributes = @{ NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                 NSForegroundColorAttributeName : color,
                                 NSParagraphStyleAttributeName : paragraphStyle };
        
        _timeTextAttributes = @{ NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                 NSForegroundColorAttributeName : color,
                                 NSParagraphStyleAttributeName : paragraphStyle };
    }
    return self;
}

#pragma mark - Formatter

- (NSString *)timestampForDate:(NSDate *)date {
    if (!date) return @"";
    
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [self.dateFormatter stringFromDate:date];
}

- (NSAttributedString *)attributedTimestampForDate:(NSDate *)date {
    if (!date) return nil;
    
    NSString *relativeDate = [self relativeDateForDate:date];
    NSString *time = [self timeForDate:date];
    
    NSMutableAttributedString *timestamp = [[NSMutableAttributedString alloc] initWithString:relativeDate
                                                                                  attributes:self.dateTextAttributes];
    
    [timestamp appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    
    [timestamp appendAttributedString:[[NSAttributedString alloc] initWithString:time
                                                                      attributes:self.timeTextAttributes]];
    
    return [[NSAttributedString alloc] initWithAttributedString:timestamp];
}

- (NSString *)timeForDate:(NSDate *)date {
    if (!date) return @"";
    
    [self.dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)relativeDateForDate:(NSDate *)date {
    if (!date) return @"";
    
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    return [self.dateFormatter stringFromDate:date];
}

@end
