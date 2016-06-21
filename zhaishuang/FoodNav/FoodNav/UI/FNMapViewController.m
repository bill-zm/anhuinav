//
//  FNMapViewController.m
//  FoodNav
//
//  Created by aa on 16/6/8.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "CAppService.h"
#import "FNHomeViewController.h"
#import "SVProgressHUD.h"
@interface FNMapViewController ()<MAMapViewDelegate>
{
    MAMapView *_mapView;
}
@end

@implementation FNMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地图";
    UIBarButtonItem *tmpbarButtonItem = [[UIBarButtonItem alloc] init];
    tmpbarButtonItem.title = NullString;
    self.navigationItem.backBarButtonItem = tmpbarButtonItem;
    [AMapServices sharedServices].apiKey = @"90a6b42e298d22c2ca28a5638adfbbfc";
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), Screen_Height-default_NavigationHeight_iOS7-tabBar_Height)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
    if(!self.isFirstPage){
    for(NSDictionary *model in self.dataArr){
        if([model.allKeys containsObject:@"longitude"] && [model.allKeys containsObject:@"latitude"]){
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake([model[@"latitude"] doubleValue], [model[@"longitude"] doubleValue]);
            pointAnnotation.title = model[@"graindepot_name"];
            pointAnnotation.subtitle = model[@"address"];
            [_mapView addAnnotation:pointAnnotation];
            _mapView.centerCoordinate =  CLLocationCoordinate2DMake([model[@"latitude"] doubleValue], [model[@"longitude"] doubleValue]);
        }
    }
    }
    else{
        self.navigationItem.rightBarButtonItem = [Common createNextBarItemWithLbs:@"切换" Block:^{
            FNHomeViewController *homeVc = [[FNHomeViewController alloc] initWithNibName:@"FNHomeViewController" bundle:nil];
            [self.navigationController pushViewController:homeVc animated:NO];
        }];
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    [[CAppService sharedInstance] getAllAddress_request:^(NSDictionary *model) {
        if([model.allKeys containsObject:@"data"]){
            if([model[@"data"] isKindOfClass:[NSArray class]]){
                self.dataArr = [NSMutableArray arrayWithArray:model[@"data"]];
                for(NSDictionary *model in self.dataArr){
                    if([model.allKeys containsObject:@"longitude"] && [model.allKeys containsObject:@"latitude"]){
                        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
                        pointAnnotation.coordinate = CLLocationCoordinate2DMake([model[@"latitude"] doubleValue], [model[@"longitude"] doubleValue]);
                        pointAnnotation.title = model[@"graindepot_name"];
                        pointAnnotation.subtitle = model[@"address"];
                        [_mapView addAnnotation:pointAnnotation];
                        _mapView.centerCoordinate =  CLLocationCoordinate2DMake([model[@"latitude"] doubleValue], [model[@"longitude"] doubleValue]);
                    }
                }
                [SVProgressHUD dismiss];
            }
            else{
                [SVProgressHUD dismiss];
            }
        }
    } failure:^(CAppServiceError *error) {
        [SVProgressHUD dismiss];
    }];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}
@end
