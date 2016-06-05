//
//  FNavViewController.m
//  FoodNav
//
//  Created by 张梦 on 16/6/3.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNavViewController.h"

@interface FNavViewController ()<MAMapViewDelegate, AMapSearchDelegate, AMapNaviDriveManagerDelegate>
@property (nonatomic, strong) AMapNaviHUDView *hudView;
@end

@implementation FNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [AMapServices sharedServices].apiKey = @"90a6b42e298d22c2ca28a5638adfbbfc";
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        [self.mapView setDelegate:self];
        [self.view addSubview:self.mapView];
    }
    if (self.driveManager == nil)
    {
        self.driveManager = [[AMapNaviDriveManager alloc] init];
        [self.driveManager setDelegate:self];
    }
    if (self.search == nil)
    {
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
    }
    [self.mapView setShowsUserLocation:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
