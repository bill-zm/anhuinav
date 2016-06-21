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
#import "CAppService.h"
#import "SVProgressHUD.h"
#import "NSString+MD5Addition.h"
#import "FNMapViewController.h"
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
    WeakSelf;
    setViewCorner(self.loginBtn, 5);
    setViewCorner(self.userView, 5);
    setViewCorner(self.pawView, 5);
    self.userNumber.text = UserDefaultsGet(UserDefaultKey_UserName);
    self.userPassword.text = UserDefaultsGet(UserDefaultKey_Password);
    [[CAppService sharedInstance] isLogin_request:^(NSDictionary *model) {
        if([model.allKeys containsObject:@"data"]){
            if([model[@"data"] integerValue] == 0){
                    [wself setupViews];
                    [wself presentViewController:self.leveyTabBarController
                                       animated:NO
                                     completion:nil];
            }
        }
    } failure:^(CAppServiceError *error) {
        
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.userNumber.text = UserDefaultsGet(UserDefaultKey_UserName);
    self.userPassword.text = UserDefaultsGet(UserDefaultKey_Password);
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
- (IBAction)btnClick:(id)sender {
    // 接口: login
    if([Common isEmptyString:self.userNumber.text]){
        [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
        return;
    }
    if([Common isEmptyString:self.userPassword.text]){
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    WeakSelf;
//    * 登录接口
//    * msg 值含义
//    * 00001  登录成功
//    * 00002 用户名为空
//    * 00003 密码为空
//    * 00004 用户不存在
//    * 00005 密码错误
    [[CAppService sharedInstance] appLogin_request:self.userNumber.text password:[self.userPassword.text stringFromMD5] success:^(NSDictionary *model) {
        if([model.allKeys containsObject:@"data"]){
            user_id = model[@"data"];
        }
        if([model.allKeys containsObject:@"msg"]){
            if([model[@"msg"] isEqualToString:@"00001"]){
                UserDefaultsSave(wself.userNumber.text, UserDefaultKey_UserName);
                UserDefaultsSave(wself.userPassword.text, UserDefaultKey_Password);
                [[CAppService sharedInstance] pstDeveiceInfo_request:^(NSDictionary *model) {
                } failure:^(CAppServiceError *error) {
                }];
                [wself setupViews];
                [wself presentViewController:wself.leveyTabBarController
                                    animated:NO
                                  completion:nil];
            }
            else if([model[@"msg"] isEqualToString:@"00002"]){
                [SVProgressHUD showErrorWithStatus:@"用户名为空"];
            }
            else if([model[@"msg"] isEqualToString:@"00003"]){
                [SVProgressHUD showErrorWithStatus:@"密码为空"];
            }
            else if([model[@"msg"] isEqualToString:@"00004"]){
                [SVProgressHUD showErrorWithStatus:@"用户不存在"];
            }
            else if([model[@"msg"] isEqualToString:@"00005"]){
                [SVProgressHUD showErrorWithStatus:@"密码错误"];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        }
    } failure:^(CAppServiceError *error) {
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.userNumber resignFirstResponder];
    [self.userPassword resignFirstResponder];
}
//-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
//updatingLocation:(BOOL)updatingLocation
//{
//    if(updatingLocation)
//    {
//        //取出当前位置的坐标
//        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
//    }
//}
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//        }
//        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorPurple;
//        return annotationView;
//    }
//    return nil;
//}
@end
