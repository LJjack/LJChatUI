//
//  LJSoundElemCell.h
//  LJChatTest
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import "LJElemCell.h"

@interface LJSoundElemCell : LJElemCell

@property (nonatomic, assign) BOOL isPlaying;

- (void)startPlaySound;

- (void)stopPlaySound;

@end
