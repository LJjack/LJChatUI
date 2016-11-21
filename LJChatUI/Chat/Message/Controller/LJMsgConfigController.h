//
//  LJMsgConfigController.h
//  BJShop
//
//  Created by 刘俊杰 on 16/11/4.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJMessagesModel.h"

@interface LJMsgConfigController : UIViewController

@property (nonatomic, strong) LJMessagesModel *msgModel;

@property (weak, nonatomic, readonly) UITableView *tableView;

/**
 恢复输入面板到初始状态
 
 */
- (void)reserveChatInputPanelState;

@end
