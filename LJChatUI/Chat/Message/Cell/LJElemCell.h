//
//  LJElemCell.h
//  LJChatView
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImSDK/ImSDK.h>

#import "LJBubbleContainerView.h"

@class LJElemCell;

@protocol LJElemCellDelegate <NSObject>

- (void)elemCell:(LJElemCell *)cell didTapBubbleIndexPath:(NSIndexPath *)indexPath;

@end

@interface LJElemCell : UITableViewCell

@property (nonatomic, readonly, weak) LJBubbleContainerView *borderView;

@property (nonatomic, readonly, weak) UIImageView *iconView;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic,   weak) id<LJElemCellDelegate> delegate;

@property (nonatomic, strong) TIMMessage *message;

@property (nonatomic, strong) TIMElem *elem;

@property (nonatomic, assign) TIMMessageStatus status;

- (void)bubbleContainerViewDidTap:(LJBubbleContainerView *)bubbleView;

@end
