//
//  LJElemCell.m
//  LJChatView
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import "LJElemCell.h"

#import "LJMessageStateBtn.h"

@interface LJElemCell ()<LJBubbleContainerViewDelegate>

@property (weak, nonatomic) IBOutlet LJBubbleContainerView *borderView;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (strong, nonatomic) LJMessageStateBtn *stateBtn;

@end

@implementation LJElemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.borderView.delegate = self;
    [self.contentView addSubview:self.stateBtn];
    NSLayoutAttribute stateAttribute;
    NSLayoutAttribute borderAttribute;
    CGFloat constant;
    if ([self.reuseIdentifier containsString:@"sender"]) {
        stateAttribute = NSLayoutAttributeRight;
        borderAttribute = NSLayoutAttributeLeft;
        constant = -5.0;
        self.borderView.hasReceiver = NO;
    } else {
        stateAttribute = NSLayoutAttributeLeft;
        borderAttribute = NSLayoutAttributeRight;
        constant = 5.0;
        self.borderView.hasReceiver = YES;
    }
    self.stateBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.stateBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.stateBtn
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:30]];
    [self.stateBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.stateBtn
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:30]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.stateBtn attribute:stateAttribute relatedBy:NSLayoutRelationEqual toItem:self.borderView attribute:borderAttribute multiplier:1.0 constant:constant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.stateBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
}

- (void)setMessage:(TIMMessage *)message {
    _message = message;
    self.elem = [message getElem:0];
    self.status = [message status];
}

- (void)setStatus:(TIMMessageStatus)status {
    _status = status;
    self.stateBtn.dataState = status;
}

#pragma mark - LJBubbleContainerViewDelegate

- (void)bubbleContainerViewDidTap:(LJBubbleContainerView *)bubbleView {
    if ([self.delegate respondsToSelector:@selector(elemCell:didTapBubbleIndexPath:)]) {
        [self.delegate elemCell:self didTapBubbleIndexPath:self.indexPath];
    }
}

- (LJMessageStateBtn *)stateBtn {
    if (!_stateBtn) {
        _stateBtn = [[LJMessageStateBtn alloc] init];
    }
    return _stateBtn;
}

@end
