//
//  LJImageElemCell.m
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

@end
