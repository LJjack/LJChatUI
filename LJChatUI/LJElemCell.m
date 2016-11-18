//
//  LJElemCell.m
//  LJChatView
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import "LJElemCell.h"

@interface LJElemCell ()<LJBubbleContainerViewDelegate>

@property (weak, nonatomic) IBOutlet LJBubbleContainerView *borderView;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation LJElemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.borderView.delegate = self;
}

- (void)setIsSelfBubble:(BOOL)isSelfBubble {
    _isSelfBubble = isSelfBubble;
    self.borderView.hasReceiver = !isSelfBubble;
}

#pragma mark - LJBubbleContainerViewDelegate

- (void)bubbleContainerViewDidTap:(LJBubbleContainerView *)bubbleView { }

@end
