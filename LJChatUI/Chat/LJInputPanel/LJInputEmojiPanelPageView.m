//
//  LJInputEmojiPanelPageView.m
//  LJChatUI
//
//  Created by 刘俊杰 on 2016/11/29.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import "LJInputEmojiPanelPageView.h"
#import <Masonry/Masonry.h>

@interface LJInputEmojiPanelPageView ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *emojiViews;

@end

@implementation LJInputEmojiPanelPageView

- (instancetype)initWithEmojiNames:(NSArray *)emojiNames {
    if (self = [super init]) {
        self.emojiNames = emojiNames;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.emojiViews || !self.emojiViews.count) return;
    
    NSInteger rowCount = 3;
    NSInteger cloumnCount = 7;
    CGFloat emojiWidth = 29;
    CGFloat emojiMarginX = ([UIScreen mainScreen].bounds.size.width - cloumnCount * emojiWidth)/(cloumnCount + 1);
    CGFloat emojiMarginY = (self.bounds.size.height - rowCount * emojiWidth)/(rowCount + 1);
    [self.emojiViews enumerateObjectsUsingBlock:^(UIButton * _Nonnull emojiView, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger rowIndex = idx/cloumnCount;
        NSInteger cloumnIndex = idx%cloumnCount;
        emojiView.frame = CGRectMake((cloumnIndex+1)*emojiMarginX + cloumnIndex*emojiWidth, (rowIndex+1)*emojiMarginY + rowIndex*emojiWidth, emojiWidth, emojiWidth);
    }];
}

- (void)setupUI {
    self.emojiViews = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        for (int j = 0; j < 7; j ++) {
            
        }
    }
    
    for (int i = 0; i < 21; i++) {
        UIButton *emojiButton = [[UIButton alloc]init];
        emojiButton.tag = i;
        NSDictionary *emojiItem = self.emojiNames[i];
        NSString *emojiName = [NSString stringWithFormat:@"%@",[emojiItem.allValues firstObject]];
        UIImage *emojiImage = [UIImage imageNamed:emojiName];
        if (emojiImage) {
            [emojiButton setImage:emojiImage forState:UIControlStateNormal];
        }
        [emojiButton addTarget:self action:@selector(clickEmojiButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:emojiButton];
        [self.emojiViews addObject:emojiButton];
    }
    
}

- (void)clickEmojiButton:(UIButton *)sender {
//    NSInteger index = emojiButton.tag - GJGCChatInputExpandEmojiPanelPageItemSubIconTag;
//    
//    if (index == self.emojiNamesArray.count - 1) {
//        
//        NSString *formateNoti = [GJGCChatInputConst panelNoti:GJGCChatInputExpandEmojiPanelChooseDeleteNoti formateWithIdentifier:self.panelIdentifier];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:formateNoti object:nil userInfo:nil];
//        return;
//    }
//    
//    if (index != self.emojiNamesArray.count - 1) {
//        
//        NSDictionary *item = [self.emojiNamesArray objectAtIndex:index];
//        NSString *emoji = [[item allKeys]firstObject];
//        
//        NSString *formateNoti = [GJGCChatInputConst panelNoti:GJGCChatInputExpandEmojiPanelChooseEmojiNoti formateWithIdentifier:self.panelIdentifier];
//        [[NSNotificationCenter defaultCenter] postNotificationName:formateNoti object:emoji userInfo:nil];
//    }
}

- (void)setEmojiNames:(NSArray *)emojiNames {
    _emojiNames = emojiNames;
    [self setupUI];
}


@end
