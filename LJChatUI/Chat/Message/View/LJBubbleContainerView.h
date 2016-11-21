//
//  LJBubbleContainerView.h
//  LJChatTest
//
//  Created by 刘俊杰 on 2016/11/18.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJBubbleContainerView;

@protocol LJBubbleContainerViewDelegate <NSObject>

- (void)bubbleContainerViewDidTap:(LJBubbleContainerView *)bubbleView;

@end

@interface LJBubbleContainerView : UIView

@property (nonatomic, assign) BOOL hasReceiver;

@property (nonatomic, weak) UIImageView *bubbleImageView;

@property (nonatomic, weak) id<LJBubbleContainerViewDelegate> delegate;

@end
