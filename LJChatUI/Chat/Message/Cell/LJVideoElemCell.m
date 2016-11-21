//
//  LJVideoElemCell.m
//  LJChatTest
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import "LJVideoElemCell.h"

@implementation LJVideoElemCell

- (void)setElem:(TIMVideoElem *)elem {
    [super setElem:elem];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *nsTmpDir = NSTemporaryDirectory();

    TIMSnapshot * snapshot = elem.snapshot;
    if (!(snapshot.uuid && snapshot.uuid.length)) {
        NSLog(@"小视频截图UUID为空");
        return;
    }


    NSString *imagePath = [NSString stringWithFormat:@"%@/snapshot_image_%@", nsTmpDir, snapshot.uuid];
    BOOL isDirectory;

    if ([fileManager fileExistsAtPath:imagePath isDirectory:&isDirectory]
        && isDirectory == NO) {
        NSData *data = [fileManager contentsAtPath:imagePath];
        if (data) {
            
        }
    } else {
        [snapshot getImage:imagePath succ:^{
            NSData *data = [fileManager contentsAtPath:imagePath];
            if (data) {
                
            } else {
                
                NSLog(@"下载的小视频截图是空的");
            }

        } fail:^(int code, NSString *err) {
            
            NSLog(@"下载小视频截图失败");
        }];
    }

    TIMVideo *video = elem.video;
    if (!(video.uuid && video.uuid.length)) {
        NSLog(@"小视频UUID为空");
        return;
    }

    NSString *videoPath = [NSString stringWithFormat:@"%@video_%@.mp4", nsTmpDir, video.uuid];

    if ([fileManager fileExistsAtPath:videoPath isDirectory:nil]) {
        
    } else {
        [video getVideo:videoPath succ:^{
            
        } fail:^(int code, NSString *err) {
            NSLog(@"下载视频失败, %@",err);
        }];
    }
}

@end
