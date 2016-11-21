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

- (void)setMessage:(TIMMessage *)message {
    _message = message;
//    NSLog(@"昵称= %@",[[message GetSenderProfile] nickname]);
//    
//    NSString *senderId = [message sender];
//    TIMUserProfile *user = [message GetSenderProfile];
//    displayName = user.nickname.length?user.nickname:senderId;
    
    self.elem = [message getElem:0];
    
//    int elemCount = [message elemCount];
//    for (int i = 0 ; i < elemCount; i ++) {
//        TIMElem *elem = [message getElem:i];
//        if ([elem isKindOfClass:[TIMTextElem class]]) {
//           
//            
//        } else if ([elem isKindOfClass:[TIMImageElem class]]) {
//           
//            
//        } else if ([elem isKindOfClass:[TIMLocationElem class]]) {
//            
//        } else if ([elem isKindOfClass:[TIMSoundElem class]]) {
//            
//        } else if ([elem isKindOfClass:[TIMVideoElem class]]) {
//           
//        } else if ([elem isKindOfClass:[TIMCustomElem class]]) {
//            
//        }
//        
//    }
}

#pragma mark - LJBubbleContainerViewDelegate

- (void)bubbleContainerViewDidTap:(LJBubbleContainerView *)bubbleView {
    if ([self.delegate respondsToSelector:@selector(elemCell:didTapBubbleIndexPath:)]) {
        [self.delegate elemCell:self didTapBubbleIndexPath:self.indexPath];
    }
}

@end
