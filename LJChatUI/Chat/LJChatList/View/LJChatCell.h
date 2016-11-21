//
//  LJChatCell.h
//  LJChatView
//
//  Created by 刘俊杰 on 16/9/18.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TIMConversation;

@interface LJChatCell : UITableViewCell

@property (nonatomic, strong) TIMConversation *model;

@end
