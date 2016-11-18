//
//  LJSoundElemCell.m
//  LJChatTest
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import "LJSoundElemCell.h"

@interface LJSoundElemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *playImageView;

@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageView;

@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@property (weak, nonatomic) IBOutlet UIImageView *unreadImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleWidth;

@end

@implementation LJSoundElemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.borderView.bubbleImageView = self.bubbleImageView;
    self.playImageView.animationDuration = 1;
}

- (void)setIsSelfBubble:(BOOL)isSelfBubble {
    [super setIsSelfBubble:isSelfBubble];
    if (isSelfBubble) {
        self.playImageView.animationImages = @[[UIImage imageNamed:@"SenderVoiceNodePlaying001"],
                                               [UIImage imageNamed:@"SenderVoiceNodePlaying002"],
                                               [UIImage imageNamed:@"SenderVoiceNodePlaying003"]];
    } else {
        self.playImageView.animationImages = @[[UIImage imageNamed:@"ReceiverVoiceNodePlaying001"],
                                               [UIImage imageNamed:@"ReceiverVoiceNodePlaying002"],
                                               [UIImage imageNamed:@"ReceiverVoiceNodePlaying003"]];
    }
}

- (void)bubbleContainerViewDidTap:(LJBubbleContainerView *)bubbleView {
    if ([self.playImageView isAnimating]) {
        [self.playImageView stopAnimating];
    } else {
        [self.playImageView startAnimating];
    }
}

@end
