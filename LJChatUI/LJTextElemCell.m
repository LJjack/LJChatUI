//
//  LJTextElemCell.m
//  LJChatView
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import "LJTextElemCell.h"

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
    
    NSAttributedString *aString = [[NSAttributedString alloc] initWithString:elem.text];
    _textView.attributedText = aString;
}

@end
