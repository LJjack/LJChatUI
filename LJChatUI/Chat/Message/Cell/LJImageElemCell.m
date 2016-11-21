//
//  LJelemCell.m
//  LJChatTest
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import "LJImageElemCell.h"

@interface LJImageElemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@end

@implementation LJImageElemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.showImageView.image = [UIImage imageNamed:imageName];
}

- (void)setElem:(TIMImageElem *)elem {
    [super setElem:elem];
    
    if (elem && elem.imageList && elem.imageList.count) {
        for (TIMImage *imageModel in elem.imageList) {
            if (imageModel.type == TIM_IMAGE_TYPE_ORIGIN) {
                if (!(imageModel.uuid && imageModel.uuid.length > 0)) {
                    break;
                }

                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSString *nsTmpDir = NSTemporaryDirectory();
                NSString *imagePath = [NSString stringWithFormat:@"%@/image_%@", nsTmpDir, imageModel.uuid];
                BOOL isDirectory;

                if ([fileManager fileExistsAtPath:imagePath isDirectory:&isDirectory]
                    && isDirectory == NO) {
                    NSData *data = [fileManager contentsAtPath:imagePath];
                    if (data) {
                        self.showImageView.image = [UIImage imageWithData:data];
                    }
                } else {
                    [imageModel getImage:imagePath succ:^{
                        NSData *data = [fileManager contentsAtPath:imagePath];
                        if (data) {
                        } else {
                            self.showImageView.image = [UIImage imageWithData:data];
                            NSLog(@"下载的图片是空的");
                        }

                    } fail:^(int code, NSString *err) {
                        
                        NSLog(@"下载原图失败");
                    }];
                }
                break;
            }
        }
    } else {//运行状态
        

        //展示发送的图片
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *imagePath = elem.path;
        BOOL isDirectory;

        if ([fileManager fileExistsAtPath:imagePath isDirectory:&isDirectory]
            && isDirectory == NO) {
            NSData *data = [fileManager contentsAtPath:imagePath];
            if (data) {
                self.showImageView.image = [UIImage imageWithData:data];
            }
        }
        
    }
}

@end
