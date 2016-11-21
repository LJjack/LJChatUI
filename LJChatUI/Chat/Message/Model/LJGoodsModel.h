//
//  LJGoodsModel.h
//  BJHybrid
//
//  Created by 刘俊杰 on 16/10/25.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LJGoodsModelType) {
    LJGoodsModelTypeOrderMsg = 1,//订单消息
    LJGoodsModelTypeOrderInfo,//订单咨询
    LJGoodsModelTypeProduct,//商品信息
};

@interface LJGoodsModel : NSObject<NSCoding>

// --公用--
@property (nonatomic,   copy) NSString *userId;
@property (nonatomic,   copy) NSString *fromUserId;
@property (nonatomic,   copy) NSString *url;
@property (nonatomic, assign) LJGoodsModelType type;

// --订单消息--
@property (nonatomic,   copy) NSString *text;

// --商品信息--
@property (nonatomic,   copy) NSString *sellerId;
@property (nonatomic,   copy) NSString *goodsId;
@property (nonatomic,   copy) NSString *picture;
@property (nonatomic,   copy) NSString *goodsName;
@property (nonatomic,   copy) NSString *price;
@property (nonatomic,   copy) NSString *salesVolume;


// --订单咨询--

@property (nonatomic,   copy) NSString *orderNo;
@property (nonatomic,   copy) NSArray *pictures;
@property (nonatomic,   copy) NSString *orderCount;
@property (nonatomic,   copy) NSString *orderTotal;
@property (nonatomic,   copy) NSString *orderStatus;
@property (nonatomic,   copy) NSString *fee;

- (NSData *)modelToData;

@end
