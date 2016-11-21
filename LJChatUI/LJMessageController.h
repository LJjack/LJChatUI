//
//  LJMessageController.h
//  LJChatView
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJMessagesModel.h"

@interface LJMessageController : UITableViewController

@property (nonatomic, strong) LJMessagesModel *msgModel;

@end
