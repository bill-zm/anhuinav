//
//  FNLoginViewController.m
//  FoodNav
//
//  Created by aa on 16/6/3.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNLoginViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "FNLoginViewController+Navigation.h"
@interface FNLoginViewController ()<MAMapViewDelegate>
{
    MAMapView *_mapView;
}
@end

@implementation FNLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置用户Key
//    [AMapNaviServices sharedServices].apiKey =@"90a6b42e298d22c2ca28a5638adfbbfc";
//    [AMapServices sharedServices].apiKey = @"90a6b42e298d22c2ca28a5638adfbbfc";
//    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
//    _mapView.delegate = self;
//    [self.view addSubview:_mapView];
//     _mapView.showsUserLocation = YES;
//    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
//    
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
//    pointAnnotation.title = @"方恒国际";
//    pointAnnotation.subtitle = @"阜通东大街6号";
//    
//    [_mapView addAnnotation:pointAnnotation];
//    
//    MAPointAnnotation *pointAnnotation1 = [[MAPointAnnotation alloc] init];
//    pointAnnotation1.coordinate = CLLocationCoordinate2DMake(38.989631, 117.481018);
//    pointAnnotation1.title = @"方恒国际";
//    pointAnnotation1.subtitle = @"阜通东大街6号";
//    
//    [_mapView addAnnotation:pointAnnotation1];
//
//    MAPointAnnotation *pointAnnotation2 = [[MAPointAnnotation alloc] init];
//    pointAnnotation2.coordinate = CLLocationCoordinate2DMake(37.989631, 115.481018);
//    pointAnnotation2.title = @"方恒国际";
//    pointAnnotation2.subtitle = @"阜通东大街6号";
//    
//    [_mapView addAnnotation:pointAnnotation2];
//
//    MAPointAnnotation *pointAnnotation3 = [[MAPointAnnotation alloc] init];
//    pointAnnotation3.coordinate = CLLocationCoordinate2DMake(36.989631, 114.481018);
//    pointAnnotation3.title = @"方恒国际";
//    pointAnnotation3.subtitle = @"阜通东大街6号";
//    
//    [_mapView addAnnotation:pointAnnotation3];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self setupViews];
//    [self presentViewController:self.leveyTabBarController
//                       animated:NO
//                     completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
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
- (IBAction)btnClick:(id)sender {
    [self setupViews];
    [self presentViewController:self.leveyTabBarController
                       animated:NO
                     completion:nil];
}
@end
