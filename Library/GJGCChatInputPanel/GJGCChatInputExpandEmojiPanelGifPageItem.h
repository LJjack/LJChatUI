//
//  GJGCChatInputExpandEmojiPanelGifPageItem.h
//  GJGroupChat
//
//  Created by ZYVincent on 15/6/3.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJGCChatInputExpandEmojiPanelGifPageItem : UIView

@property (nonatomic,strong)NSString *panelIdentifier;

@property (nonatomic,weak)UIView *panelView;

- (instancetype)initWithFrame:(CGRect)frame withEmojiNameArray:(NSArray *)emojiArray;

//- (void)reserve;

@end
