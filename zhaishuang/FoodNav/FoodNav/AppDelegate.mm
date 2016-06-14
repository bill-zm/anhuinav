//
//  AppDelegate.m
//
//  Created by Reese on 16-6-3.
//  Copyright (c) 2016年 Reese. All rights reserved.
//
#import "AppDelegate.h"
#import "FNLoginViewController.h"
//#import "FNavViewController.h"
#import "SVProgressHUD.h"
#import "CAppService.h"
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    FNLoginViewController *fnController = [[FNLoginViewController alloc] initWithNibName:@"FNLoginViewController" bundle:nil];
    self.window.rootViewController = fnController;
    [self.window makeKeyAndVisible];
//    id obj = [NSJSONSerialization JSONObjectWithData:[@"{\"success\":true,\"msg\":\"\",\"data\":[{\"id\":\"402469\",\"create_name\":\"\",\"create_by\":\"\",\"update_name\":\"\",\"create_date\":\"1900\/1\/1 00:00:00\",\"update_by\":\"\",\"update_date\":\"1900\/1\/1 00:00:00\",\"graindepot_name\":\"\u67f4\u6865\u7cae\u7ad9\",\"enterprise_id\":\"3443834\",\"postalcode\":\"315809\",\"address\":\"\u6d59\u6c5f\u7701\u5b81\u6ce2\u5e02\u5317\u4ed1\u533a\u67f4\u6865\u8857\u9053\u9547\u5357\u8def42\u5f0410\u53f7\",\"corporation\":\"\",\"phone_no\":\"\",\"fax_no\":\"\",\"email\":\"\",\"longitude\":\"121.9157\",\"latitude\":\"29.872000\",\"is_valid\":\"Y\",\"gd_count\":\"1\",\"store_design_capacity\":\"7605.0000\",\"store_actual_capacity\":\"7605.0000\",\"oilcan_design_capacity\":\".0000\",\"oilcan_actual_capacity\":\".0000\",\"is_storage_title\":\"\",\"is_finish_title\":\"\",\"store_count\":\"0\",\"warehouse_count\":\"0\",\"oilcan_count\":\"0\",\"remark\":\"\",\"graindepot_gb_code\":\"005\",\"land_assign\":\"10976.0000\",\"floor_space\":\"10976.0000\",\"land_sell\":\".0000\",\"land_other\":\".0000\",\"land_value\":\".0000\",\"land_spare_space\":\".0000\",\"land_facilities_old_value\":\"157.0000\",\"terrace\":\"4303.0000\",\"terrace_railway\":\".0000\",\"engine_count\":\"0\",\"terrace_length\":\".0000\",\"terrace_wharf\":\".0000\",\"engine_ability\":\".0000\",\"engine_age_limit\":\".0000\",\"engine_cooler\":\".0000\",\"receive\":\"30.0000\",\"receive_railway\":\".0000\",\"receive_road\":\"30.0000\",\"receive_other\":\".0000\",\"receive_waterway\":\".0000\",\"send\":\"30.0000\",\"send_railway\":\".0000\",\"send_road\":\"30.0000\",\"send_waterway\":\".0000\",\"send_other\":\".0000\",\"ensure_aeration\":\"0\",\"ensure_fumigation\":\"0\",\"ensure_low_temperature\":\"0\",\"ensure_thermometric\":\"0\",\"ensure_atmosphere\":\"0\",\"it_is_business\":\"0\",\"it_is_storage\":\"0\",\"it_is_auto\":\"0\",\"it_is_remote\":\"0\",\"it_is_other\":\"0\",\"province_id\":\"\u6d59\u6c5f\u7701\",\"country_id\":\"\u5317\u4ed1\u533a\",\"city_id\":\"\u5b81\u6ce2\u5e02\",\"audit_name\":\"\",\"audit_state\":\"\",\"audit_date\":\"1900\/1\/1 00:00:00\",\"picture1\":\"\",\"picture2\":\"\",\"reserve_type\":\"\",\"administrativeArea\":\"\",\"belong_id\":\" \",\"belong_code\":\" \",\"develop_company\":\"\",\"mark\":\"1\"}]}" dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
//    NSLog(@"%@",obj);
    return YES;
}
@end
