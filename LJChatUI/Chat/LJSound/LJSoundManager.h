//
//  LJSoundManager.h
//  LJChatView
//
//  Created by 刘俊杰 on 16/9/21.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LJSoundModel.h"
#import "LJSoundPlayer.h"
#import "LJSoundRecord.h"

@interface LJSoundManager : NSObject

@property (nonatomic, strong, readonly) LJSoundPlayer *soundPlayer;

@property (nonatomic, strong, readonly) LJSoundRecord *soundRecord;

+ (instancetype)sharedInstance;

/* 开始录音 */
- (void)startRecord;

/* 开始一个时间限制的录音 */
- (void)startRecordWithLimitDuration:(NSTimeInterval)limitSeconds;

/* 完成录音 */
- (void)finishRecord;

/* 取消录音 */
- (void)cancelCurrentRecord;

/* 播放一个音频文件 */
- (void)playSoundModel:(LJSoundModel *)soundModel;

/* 停止播放 */
- (void)stopPlayCurrentAudio;

/* 暂停播放 */
- (void)pausePlayCurrentAudio;

/* 继续当前播放 */
- (void)startPlayFromLastStopTimestamp;

@end
