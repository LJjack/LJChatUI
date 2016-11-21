//
//  LJSoundModel.h
//  LJChatView
//
//  Created by 刘俊杰 on 16/9/21.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJSoundModel : NSObject

/**
 *  语音文件的路径
 */
@property(nonatomic,retain) NSString *path;

/**
 *  存储语音数据
 */
@property(nonatomic, strong) NSData *data;

/**
 *  语音数据大小
 */
@property(nonatomic, assign) int dataSize;

/**
 *  语音长度（秒），发送消息时设置
 */
@property(nonatomic, assign) int second;

@end
