//
//  LJInputEmojiPanelPageView.h
//  LJChatUI
//
//  Created by 刘俊杰 on 2016/11/29.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJInputEmojiPanelPageView : UIView

@property (nonatomic, copy) NSArray *emojiNames;

- (instancetype)initWithEmojiNames:(NSArray *)emojiNames;

@end
