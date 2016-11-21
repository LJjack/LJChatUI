//
//  LJBubbleContainerView.m
//  LJChatTest
//
//  Created by 刘俊杰 on 2016/11/18.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import "LJBubbleContainerView.h"
#import <objc/runtime.h>
#import "UIView+LJMask.h"

@implementation LJBubbleContainerView

- (void)dealloc {
    [self addOrRemoveNotificationCenter:NO];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //1.长按手势
        UILongPressGestureRecognizer *longPGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPRG:)];
        longPGR.minimumPressDuration = 0.8f;
        [self addGestureRecognizer:longPGR];
        //2.点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapRG:)];
        [self addGestureRecognizer:tap];
        
        UIMenuItem *copyMenuItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyElem:)];
        UIMenuItem *forwordMenuItem = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(forwordElem:)];
        UIMenuItem *deleteMenuItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteElem:)];
        [[UIMenuController sharedMenuController] setMenuItems: @[copyMenuItem,forwordMenuItem,deleteMenuItem]];
        [[UIMenuController sharedMenuController] update];
        
        [self addOrRemoveNotificationCenter:YES];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (!self.bubbleImageView) {
        if (self.hasReceiver) {
            [self lj_maskViewWithImage:[UIImage imageNamed:@"ReceiverNode"]];
            [self lj_addMaskViewWithImage:[UIImage imageNamed:@"ReceiverImageNodeMask"]];
        } else {
            [self lj_maskViewWithImage:[UIImage imageNamed:@"SenderNode"]];
            [self lj_addMaskViewWithImage:[UIImage imageNamed:@"SenderImageNodeMask"]];
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(copyElem:) || action == @selector(forwordElem:) || action == @selector(deleteElem:)) {
        return YES;
    }
    return NO;
}

- (void)handleLongPRG:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        UIMenuController *menuC = [UIMenuController sharedMenuController];
        [menuC setTargetRect:self.bounds inView:self];
        [menuC setMenuVisible:YES animated:YES];
        if (self.bubbleImageView) {
            self.bubbleImageView.highlighted = YES;
            objc_setAssociatedObject(menuC, "UIMenuControllerAddBubbleImageViewKey", self.bubbleImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        } else {
            self.lj_maskLayer.hidden = NO;
            objc_setAssociatedObject(menuC, "UIMenuControllerAddMaskViewKey", self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}

- (void)handleTapRG:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(bubbleContainerViewDidTap:)]) {
        [self.delegate bubbleContainerViewDidTap:self];
    }
}

//复制消息
- (void)copyElem:(id)sender {
    
}

//转发消息
- (void)forwordElem:(id)sender {
    
}

//删除消息
- (void)deleteElem:(id)sender {
    
}

#pragma mark - 通知中心

- (void)addOrRemoveNotificationCenter:(BOOL)isAdd {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    if (isAdd) {
        [defaultCenter addObserver:self selector:@selector(handelWillHideMenuNotification:) name:UIMenuControllerWillHideMenuNotification object:nil];
    } else {
        [defaultCenter removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
    }
}

- (void)handelWillHideMenuNotification:(NSNotification *)info {
    UIMenuController *menuC = info.object;
    UIImageView *imageView =  objc_getAssociatedObject(menuC, "UIMenuControllerAddBubbleImageViewKey");
    if (imageView) {
        imageView.highlighted = NO;
        objc_removeAssociatedObjects(menuC);
    } else {
        LJBubbleContainerView *view = objc_getAssociatedObject(menuC, "UIMenuControllerAddMaskViewKey");
        if (view) {
            view.lj_maskLayer.hidden = YES;
            objc_removeAssociatedObjects(menuC);
        }
    }
}

@end
