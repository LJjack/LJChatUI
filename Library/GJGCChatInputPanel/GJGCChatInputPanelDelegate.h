//
//  GJGCChatInputPanelDelegate.h
//  GJGroupChat
//
//  Created by ZYVincent on 14-10-28.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

@class GJGCChatInputPanel;

#import "LJSoundModel.h"

@protocol GJGCChatInputPanelDelegate <NSObject>

@optional

/**
 *  当选择扩展面板的时候会执行这个协议来通知动作类型
 *
 *  @param panel      GJGCChatInputPanel
 *  @param actionType GJGCChatInputMenuPanelActionType
 */
- (void)chatInputPanel:(GJGCChatInputPanel *)panel didChooseMenuAction:(GJGCChatInputMenuPanelActionType)actionType;

/**
 *  完成录音
 *
 *  @param panel  GJGCChatInputPanel
 */
- (void)chatInputPanel:(GJGCChatInputPanel *)panel didFinishRecord:(LJSoundModel *)soundModel;

/**
 *  发送文字消息
 *
 *  @param panel GJGCChatInputPanel
 *  @param text  文字
 */
- (void)chatInputPanel:(GJGCChatInputPanel *)panel sendTextMessage:(NSString *)text;

/**
 *  发送gif消息
 *
 *  @param panel    GJGCChatInputPanel
 *  @param gifCode  gifCode
 */
- (void)chatInputPanel:(GJGCChatInputPanel *)panel sendGIFMessage:(NSString *)gifCode;

/**
 *  根据会话类型显示扩展面板
 *  其他一些自定义用来配置的参数
 *  @param panel GJGCChatInputPanel
 *
 *  @return GJGCChatInputExpandMenuPanelConfigModel
 */
- (GJGCChatInputExpandMenuPanelConfigModel *)chatInputPanelRequiredCurrentConfigData:(GJGCChatInputPanel *)panel;

/**
 *  会话输入条具体触发哪种动作
 *
 *  @param panel GJGCChatInputPanel
 *  @param action GJGCChatInputBarActionType
 */
- (void)chatInputPanel:(GJGCChatInputPanel *)panel didChangeToInputBarAction:(GJGCChatInputBarActionType)action;

@end
