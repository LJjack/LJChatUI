//
//  LJInputTextView.m
//  LJChatUI
//
//  Created by 刘俊杰 on 2016/11/29.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import "LJInputTextView.h"

@implementation LJInputTextView

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

@end
