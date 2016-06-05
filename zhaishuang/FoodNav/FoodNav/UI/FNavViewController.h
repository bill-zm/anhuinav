//
//  FNavViewController.h
//  FoodNav
//
//  Created by 张梦 on 16/6/3.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface FNavViewController : UIViewController
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) AMapNaviDriveManager *driveManager;

@end
