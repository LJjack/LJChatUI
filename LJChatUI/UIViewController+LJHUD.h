//
//  UIViewController+LJHUD.h
//  BuJiong
//
//  Created by 刘俊杰 on 16/6/2.
//  Copyright © 2016年 BuJiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LJHUD)

- (void)lj_showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)lj_showHint:(NSString *)hint yOffset:(CGFloat)yOffset;

- (void)lj_showHint:(NSString *)hint completionBlock:(void(^)())completionBlock;
- (void)lj_showHint:(NSString *)hint afterDelay:(NSTimeInterval)delay completionBlock:(void(^)())completionBlock;

/**
 *  显示带文字的风火轮 message = nil 不显示文字
 *
 *  @param message 显示信息
 */
- (void)lj_beginHUDShowMessage:(NSString *)message;

/**
 *  隐藏带文字的风火轮
 */
- (void)lj_endHUDHideMessage;

/**
 *  在指定的视图上显示带文字的风火轮 message = nil 不显示文字
 *
 *  @param view    指定的视图
 *  @param message 显示信息
 */
- (void)lj_beginHudInView:(UIView *)view message:(NSString *)message;
/**
 *  在指定的视图上隐藏带文字的风火轮
 */
- (void)lj_endHudInView;

@end
