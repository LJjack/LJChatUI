//
//  LJMessageStateBtn.m
//  LJChatView
//
//  Created by 刘俊杰 on 16/9/13.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import "LJMessageStateBtn.h"


@interface LJMessageStateBtn ()

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation LJMessageStateBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.indicatorView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.indicatorView.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

- (void)runingAnimating {
    self.hidden = NO;
    if (![self.indicatorView isAnimating]) {
        [self.indicatorView startAnimating];
    }
    [self setImage:nil forState:UIControlStateNormal];
}

- (BOOL)isAnimating {
    return [self.indicatorView isAnimating];
}

- (void)completedState {
    self.hidden =YES;
    [self.indicatorView stopAnimating];
    [self setImage:nil forState:UIControlStateNormal];
}

- (void)failedState {
    self.hidden = NO;
    if ([self.indicatorView isAnimating]) {
        [self.indicatorView stopAnimating];
    }
    [self setImage:[UIImage imageNamed:@"Sendfailed"] forState:UIControlStateNormal];
}

#pragma mark - Setters

- (void)setDataState:(TIMMessageStatus)dataState {
    _dataState = dataState;
    switch (dataState) {
        case TIM_MSG_STATUS_SENDING: {
            [self runingAnimating];
        } break;
        case TIM_MSG_STATUS_SEND_SUCC: {
            [self completedState];
        } break;
        case TIM_MSG_STATUS_SEND_FAIL: {//消息发送失败
            [self failedState];
        } break;
            
        default:
            break;
    }
}

#pragma mark - Getters

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.userInteractionEnabled = NO;
        _indicatorView.hidesWhenStopped = YES;
        
    }
    return _indicatorView;
}

@end
