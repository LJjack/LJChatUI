//
//  LJSoundPlayer.h
//  LJChatView
//
//  Created by 刘俊杰 on 16/9/21.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LJSoundModel, LJSoundPlayer;

@protocol LJSoundPlayerDelegate <NSObject>

@optional

- (void)soundPlayer:(LJSoundPlayer *)soundPlayer didFinishPlayAudio:(LJSoundModel *)audioFile;

- (void)soundPlayer:(LJSoundPlayer *)soundPlayer didOccusError:(NSError *)error;

@end

@interface LJSoundPlayer : NSObject

@property (nonatomic, readonly) BOOL isPlaying;

@property (nonatomic, weak) id<LJSoundPlayerDelegate> delegate;

- (void)playSoundModel:(LJSoundModel *)soundModel;

- (LJSoundModel *)getCurrentPlayingSoundModel;

- (NSInteger)currentPlaySoundModelDuration;

- (void)play;

- (void)stop;

- (void)pause;

@end
