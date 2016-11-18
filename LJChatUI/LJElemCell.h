//
//  LJElemCell.h
//  LJChatView
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBubbleContainerView.h"

@interface LJElemCell : UITableViewCell

@property (weak, readonly, nonatomic) LJBubbleContainerView *borderView;

@property (weak, readonly, nonatomic) UIImageView *iconView;

@property (assign, nonatomic) BOOL isSelfBubble;

- (void)bubbleContainerViewDidTap:(LJBubbleContainerView *)bubbleView;

@end
