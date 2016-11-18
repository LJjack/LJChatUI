//
//  LJMapController.h
//  LJChatUI
//
//  Created by 刘俊杰 on 2016/11/18.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>

@interface LJMapController : UIViewController

@property (nonatomic,assign) CLLocationCoordinate2D location;

@property (nonatomic, copy) NSString *locTitle;

@property (nonatomic, copy) NSString *locSubtitle;

@end
