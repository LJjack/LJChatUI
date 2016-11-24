//
//  UIView+LJMask.h
//  小橙
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LJMask)

/**
 根据指定的图片给视图修改蒙版，默认拉伸区域CGRectMake(0.2, 0.6, 0.1, 0.1)

 @param image 图片
 */
- (void)lj_maskViewWithImage:(UIImage *)image;


/**
 根据指定的图片给视图修改蒙版

 @param image 图片
 @param contentStretch 拉伸区域
 */
- (void)lj_maskViewWithImage:(UIImage *)image
              contentStretch:(CGRect)contentStretch;

@property (nonatomic, strong) CALayer *lj_maskLayer;//视图添加图片蒙版

/**
 视图添加图片蒙版，默认拉伸区域CGRectMake(0.2, 0.6, 0.1, 0.1)
 
 @param image 图片
 */
- (void)lj_addMaskViewWithImage:(UIImage *)image;

/**
 视图添加图片蒙版
 
 @param image 图片
 @param contentStretch 拉伸区域
 */
- (void)lj_addMaskViewWithImage:(UIImage *)image
                 contentStretch:(CGRect)contentStretch;

@end
