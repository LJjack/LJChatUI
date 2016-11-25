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
    if ([self.reuseIdentifier isEqualToString:@"senderSoundElemCell"]) {
        self.playImageView.animationImages = @[[UIImage imageNamed:@"SenderVoiceNodePlaying001"],
                                               [UIImage imageNamed:@"SenderVoiceNodePlaying002"],
                                               [UIImage imageNamed:@"SenderVoiceNodePlaying003"]];
    } else {
        self.playImageView.animationImages = @[[UIImage imageNamed:@"ReceiverVoiceNodePlaying001"],
                                               [UIImage imageNamed:@"ReceiverVoiceNodePlaying002"],
                                               [UIImage imageNamed:@"ReceiverVoiceNodePlaying003"]];
    }
    
}

- (void)startPlaySound {
    [self.playImageView startAnimating];
}

- (void)stopPlaySound {
    [self.playImageView stopAnimating];
}

- (BOOL)isPlaying {
    return [self.playImageView isAnimating];
}

- (void)setElem:(TIMSoundElem *)elem {
    [super setElem:elem];
    self.secondLabel.text = [NSString stringWithFormat:@"%d",elem.second];
    [elem getSound:^(NSData *data) {
        
        
    } fail:^(int code, NSString *msg) {
        
        NSLog(@"下载音频失败, %@",msg);
    }];
}


@end
