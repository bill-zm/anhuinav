//
//  FNDetailViewController.m
//  FoodNav
//
//  Created by aa on 16/6/7.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNDetailViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "CAppService.h"
@interface FNDetailViewController ()<MAMapViewDelegate>
{
    MAMapView *_mapView;
    BOOL iscollect;
}
@end

@implementation FNDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置用户Key
    //        [AMapNaviServices sharedServices].apiKey =@"90a6b42e298d22c2ca28a5638adfbbfc";
    self.title = @"粮仓详情";
    UIBarButtonItem *tmpbarButtonItem = [[UIBarButtonItem alloc] init];
    tmpbarButtonItem.title = NullString;
    self.navigationItem.backBarButtonItem = tmpbarButtonItem;
    [AMapServices sharedServices].apiKey = @"90a6b42e298d22c2ca28a5638adfbbfc";
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds)-20, 420)];
    _mapView.delegate = self;
    [self.fnmapView addSubview:_mapView];
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
    setViewCorner(self.navButton, 5);
    iscollect = NO;
    [[CAppService sharedInstance] liangDetail_request:self.liangId success:^(NSDictionary *model) {
        [self setUIdata:model];
    } failure:^(CAppServiceError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUIdata:(NSDictionary *)dataDic
{
    if([dataDic.allKeys containsObject:@"data"]){
        NSDictionary *model = dataDic[@"data"];
        if([model.allKeys containsObject:@"graindepot_name"]){
            self.name.text = model[@"graindepot_name"];
            CGRect r = [self.name.text boundingRectWithSize:CGSizeMake(Screen_Width, Screen_Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.name.font} context:nil];
            SetFrameByXPos(self.collButton.frame, 134+r.size.width+10);
        }
        
        if([model.allKeys containsObject:@"address"])
            self.address.text = model[@"address"];
        
        if([model.allKeys containsObject:@"store_count"]){
            self.cangHouseAllNum.text = model[@"store_count"];
            self.cangHouseAllNum1.text = model[@"store_count"];
        }
        
        if([model.allKeys containsObject:@"warehouse_count"]){
            self.aoHouseAllNum.text = model[@"warehouse_count"];
            self.aoHouseAllNum1.text = model[@"warehouse_count"];
        }
        
        if([model.allKeys containsObject:@"oilcan_count"]){
            self.youguanAllnumber.text = model[@"oilcan_count"];
            self.youguanAllnumber1.text = model[@"oilcan_count"];
        }
        
        if([model.allKeys containsObject:@"store_design_capacity"])
            self.designAllcapacity.text = model[@"store_design_capacity"];
        
        if([model.allKeys containsObject:@"oilcan_design_capacity"])
            self.youkuanDesignAll.text = model[@"oilcan_design_capacity"];
        
        
        if([model.allKeys containsObject:@"enterprise_id"])
            self.enterpriseName.text = model[@"enterprise_id"];
        
        if([model.allKeys containsObject:@"longitude"] && [model.allKeys containsObject:@"latitude"]){
            self.lbsSign.text = [NSString stringWithFormat:@"%@, %@",model[@"longitude"],model[@"latitude"]];
            
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake([model[@"longitude"] doubleValue], [model[@"latitude"] doubleValue]);
            pointAnnotation.title = model[@"graindepot_name"];
            pointAnnotation.subtitle = model[@"address"];
            [_mapView addAnnotation:pointAnnotation];
            _mapView.centerCoordinate =  CLLocationCoordinate2DMake([model[@"longitude"] doubleValue], [model[@"latitude"] doubleValue]);
        }
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
- (IBAction)navigateBtnClick:(id)sender
{
    NSString *str = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=applicationScheme&poiname=fangheng&poiid=BGVIS&lat=%f&lon=%f&dev=0&style=3",@"粮仓位置", 39.989631, 117.481018];
    str=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * myURL_APP_A =[[NSURL alloc] initWithString:str];
    NSLog(@"%@",myURL_APP_A);
    //    if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
    [[UIApplication sharedApplication] openURL:myURL_APP_A];
    //    }
    //    else{
    //        Alert(@"请您先安装高德地图");
    //    }
}
- (IBAction)collectBtnClick:(id)sender
{
    if(iscollect){
        [[CAppService sharedInstance] collectLiang_request:user_id warehouse_id:self.liangId isdelte:1 success:^(NSDictionary *model) {
            if([model.allKeys containsObject:@"msg"]){
                if([model[@"msg"] isEqualToString:@"00001"]){
                    [self.collButton setImage:Image(@"fnuncollecticon") forState:UIControlStateNormal];
                    iscollect = !iscollect;
                }
            }
        } failure:^(CAppServiceError *error) {
        }];
    }
    else{
        [[CAppService sharedInstance] collectLiang_request:user_id warehouse_id:self.liangId isdelte:0 success:^(NSDictionary *model) {
            if([model[@"msg"] isEqualToString:@"00001"]){
                [self.collButton setImage:Image(@"fnalcollecticon") forState:UIControlStateNormal];
                iscollect = !iscollect;
            }
        } failure:^(CAppServiceError *error) {
        }];
    }
}
@end
