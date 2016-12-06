//
//  UIImage+LJColor.h
//  BuJiong
//
//  Created by 刘俊杰 on 16/4/11.
//  Copyright © 2016年 BuJiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LJColor)
/**
 * 根据颜色创建和返回一个1X1尺寸的图片
 * @param color  颜色.
 */
+ (UIImage *)lj_imageWithColor:(UIColor *)color;
/**
 *  Create and return a pure color image with the given color and size.
 *  根据颜色和大小创建和返回一个图片
 *
 *  @param color 颜色.
 *  @param size  大小.
 *
 *  @return UIImage
 */
+ (UIImage *)lj_imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  根据颜色、大小和圆角创建和返回一个圆角图片。size 必须大于或等于 cornerRadius 的二倍.
 *
 *  @param color        颜色.
 *  @param size         尺寸大小.
 *  @param cornerRadius 圆角大小
 *
 *  @return UIImage
 */
+ (UIImage *)lj_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
@end
