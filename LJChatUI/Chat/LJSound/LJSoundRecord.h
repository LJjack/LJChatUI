//
//  LJSoundRecord.h
//  LJChatView
//
//  Created by 刘俊杰 on 16/9/21.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LJSoundModel, LJSoundRecord;

@protocol LJSoundRecordDelegate <NSObject>

@optional

- (void)soundRecord:(LJSoundRecord *)soundRecord finishRecord:(LJSoundModel*)soundModel;

- (void)soundRecord:(LJSoundRecord *)soundRecord soundMeter:(NSTimeInterval)soundMeter;

- (void)soundRecord:(LJSoundRecord *)soundRecord didFaildByMinRecordDuration:(NSTimeInterval)minDuration;

- (void)soundRecordDidCancel:(LJSoundRecord*)soundRecord;

- (void)soundRecord:(LJSoundRecord *)soundRecord limitDurationProgress:(NSTimeInterval)progress;

- (void)soundRecord:(LJSoundRecord *)soundRecord didOccusError:(NSError *)error;

@end

@interface LJSoundRecord : NSObject

@property (nonatomic, readonly) BOOL isRecording;

@property (nonatomic, readonly) NSTimeInterval soundMouter;

@property (nonatomic, assign) NSTimeInterval limitRecordDuration;

/* 最小有小时间,默认1秒 */
@property (nonatomic, assign) NSTimeInterval minEffectDuration;

@property (nonatomic, weak) id<LJSoundRecordDelegate> delegate;

/* 获取当前录制音频文件*/
- (LJSoundModel*)getCurrentRecordSoundModel;

- (void)startRecord;

- (void)finishRecord;

- (void)cancelRecord;

@end
