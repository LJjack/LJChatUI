//
//  LJTextElemCell.m
//  LJChatView
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import "LJTextElemCell.h"
#import "NSAttributedString+LJEmoji.h"

@interface LJTextElemCell ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageView;

@end

@implementation LJTextElemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.borderView.bubbleImageView = self.bubbleImageView;
}

- (void)setText:(NSAttributedString *)text {
    _text = text;
    _textView.attributedText = text;
}

- (void)setElem:(TIMTextElem *)elem {
    [super setElem:elem];
    NSDictionary *attributes = @{
                                 NSFontAttributeName : self.textView.font?:[UIFont systemFontOfSize:16.],
             NSForegroundColorAttributeName:[UIColor blackColor]
             };
    _textView.attributedText = [NSAttributedString lj_formateContent:elem.text attributes:attributes];
    
}

@end
