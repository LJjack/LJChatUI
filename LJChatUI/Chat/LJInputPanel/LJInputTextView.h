//
//  LJInputTextView.h
//  LJChatUI
//
//  Created by 刘俊杰 on 2016/11/29.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface LJInputTextView : UITextView

@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@end
