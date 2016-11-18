//
//  LJShowImageController.h
//  BJShop
//
//  Created by 刘俊杰 on 16/11/2.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJShowImageController : UIViewController

@property (strong, nonatomic) UIImage *image;

+ (instancetype)showImageControllerWithImage:(UIImage *)image;

+ (instancetype)showImageControllerWithFile:(NSString *)imgPath;

@end
