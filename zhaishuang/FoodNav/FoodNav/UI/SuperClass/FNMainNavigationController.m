//
//  YKMainNavigationController.m
//  YueKong
//
//  Created by aa on 16/1/6.
//  Copyright © 2016年 Carl Liu. All rights reserved.
//

#import "FNMainNavigationController.h"

@interface FNMainNavigationController ()

@end

@implementation FNMainNavigationController
#pragma mark 一个类只会调用一次
+ (void)initialize {
    // 1.取出设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // 174 204 69
//    [navBar setBackgroundColor:[Common colorFromHexRGB:@"a7cb31"]];
    [navBar setBackgroundImage:[Common drawImageSize:Size(Screen_Width, 64) Color:[Common colorFromHexRGB:@"A7CB31"]]
                 forBarMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:[Common drawImageSize:Size(Screen_Width, 0.3) Color:[Common colorFromHexRGB:@"ffffff"]]];
    // 3.标题
//    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowColor = [Common colorFromHexRGB:@"000000"];
//    shadow.shadowOffset = Size(0.1, 0.1);
    NSDictionary *attributesDic = @{NSForegroundColorAttributeName : [Common colorFromHexRGB:@"ffffff"],
//                                    NSShadowAttributeName : shadow,
                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:20.0]};
    [navBar setTitleTextAttributes:attributesDic];
}
#pragma mark 控制状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
