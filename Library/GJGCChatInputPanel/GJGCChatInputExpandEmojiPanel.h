//
//  GJGCChatInputExpandEmojiPanel.h
//  GJGroupChat
//
//  Created by ZYVincent on 14-10-28.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface GJGCChatInputExpandEmojiPanel : UIView

@property (nonatomic,strong)NSString *panelIdentifier;

- (void)reserved;

- (instancetype)initWithFrameForCommentBarStyle:(CGRect)frame;

@end
