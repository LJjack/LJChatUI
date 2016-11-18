//
//  UIView+LJMask.m
//  小橙
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import "UIView+LJMask.h"
#import <objc/runtime.h>

@implementation UIView (LJMask)

- (void)lj_maskViewWithImage:(UIImage *)image {
    [self lj_maskViewWithImage:image contentStretch:CGRectMake(0.2, 0.5, 0.1, 0.1)];
}

- (void)lj_maskViewWithImage:(UIImage *)image
              contentStretch:(CGRect)contentStretch {
    if (!image) return;
    if (self.layer.mask) {
        return;
    }
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    
    CALayer *layer = [CALayer layer];
    layer.shouldRasterize = YES;
    layer.rasterizationScale = image.scale;
    layer.contentsScale = image.scale;
    layer.contentsCenter = contentStretch;
    layer.contents = CFBridgingRelease(image.CGImage);
    layer.frame = self.bounds;
    self.layer.mask = layer;
}

- (void)lj_addMaskViewWithImage:(UIImage *)image {
    [self lj_addMaskViewWithImage:image contentStretch:CGRectMake(0.2, 0.5, 0.1, 0.1)];
}

- (void)lj_addMaskViewWithImage:(UIImage *)image
                 contentStretch:(CGRect)contentStretch {
    if (!image) return;
    if (self.lj_maskLayer) return;
    
    CALayer *layer = [CALayer layer];
    layer.hidden = YES;
    layer.shouldRasterize = YES;
    layer.rasterizationScale = image.scale;
    layer.contentsScale = image.scale;
    layer.contentsCenter = contentStretch;
    layer.contents = CFBridgingRelease(image.CGImage);
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
    self.lj_maskLayer = layer;
    
}

- (CALayer *)lj_maskLayer {
    return objc_getAssociatedObject(self, "kMaskAddMaskViewKey");
}

- (void)setLj_maskLayer:(CALayer *)lj_maskLayer {
    objc_setAssociatedObject(self, "kMaskAddMaskViewKey", lj_maskLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
