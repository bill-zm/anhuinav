//
//  FNLoginViewController+Navigation.m
//  FoodNav
//
//  Created by aa on 16/6/6.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNLoginViewController+Navigation.h"
#import "LeveyTabBarController.h"
#import "FNHomeViewController.h"
#import "FNMyCenterViewController.h"
#import "FNMainNavigationController.h"
#import "FNMapViewController.h"
#import "AnnotationClusterViewController.h"
@implementation FNLoginViewController (Navigation)

#pragma -mark
#pragma -mark NavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController.hidesBottomBarWhenPushed) {
        [self.leveyTabBarController hidesTabBar:YES
                                       animated:YES];
    } else {
        [self.leveyTabBarController hidesTabBar:NO
                                       animated:YES];
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
#pragma -mark
#pragma -mark init ViewController & NavigationController
- (void)setupViews{

    FNHomeViewController *homeVc = [[FNHomeViewController alloc] init];
//    AnnotationClusterViewController *homeVc = [[AnnotationClusterViewController alloc] init];
//    homeVc.isFirstPage = YES;
    FNMyCenterViewController *myCenterVc = [[FNMyCenterViewController alloc] init];
    
    FNMainNavigationController *homeNC = [[FNMainNavigationController alloc] initWithRootViewController:homeVc];
    homeNC.delegate = (id)self;
    FNMainNavigationController *centerNC = [[FNMainNavigationController alloc] initWithRootViewController:myCenterVc];
    centerNC.delegate = (id)self;
    
    NSMutableDictionary *imgDic = [NSMutableDictionary dictionary];
    imgDic[@"Default"]     = Image(@"fnhomeicon.png");
    imgDic[@"Highlighted"] = Image(@"fnhighcentericon.png");
    imgDic[@"Seleted"]     = Image(@"fnhighcentericon.png");
    
    NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionary];
    imgDic2[@"Default"]     = Image(@"fncentericon.png");
    imgDic2[@"Highlighted"] = Image(@"fnhighhomeicon.png");
    imgDic2[@"Seleted"]     = Image(@"fnhighhomeicon.png");
    //
    NSArray *ctrlArr;
    NSArray *imgArr;
    NSArray *titlesArray;
    ctrlArr = @[homeNC,centerNC];
    imgArr = @[imgDic,imgDic2];
    titlesArray = @[@"首页",@"个人中心"];
    if (!self.leveyTabBarController) {
        self.leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:ctrlArr
                                                                                 imageArray:imgArr
                                                                                     titles:titlesArray];
        UIImage *bgTabBarImg = [Common drawImageSize:Size(Screen_Width, 49.0)
                                               Color:ColorRGB(248, 248, 248)];
        [self.leveyTabBarController.tabBar setBackgroundImage:bgTabBarImg];
        self.leveyTabBarController.tabBar.layer.borderColor = [Common colorFromHexRGB:@"d0d0d0"].CGColor;
        self.leveyTabBarController.tabBar.layer.borderWidth = 1.0;
        gTabBar = self.leveyTabBarController;
        gTabBar.delegate = self;
        [self.leveyTabBarController setTabBarTransparent:YES];
        self.leveyTabBarController.selectedIndex = 0;
        [self.leveyTabBarController hidesTabBar:NO
                                       animated:YES];
        
    }
}

#pragma -mark
#pragma -mark LeveyTabBarController Delegate
- (void)tabBarController:(LeveyTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    NSString *tmpNoticeStr;
    switch (tabBarController.selectedIndex) {
//        case ECattleSign:{
//            tmpNoticeStr = NoticeKey_CattleSign;
//            break;
//        }
//        case ECattleLeave:{
//            tmpNoticeStr = NoticeKey_CattleLeave;
//            break;
//        }
//            //点击tarber 不需要从新定位
//        case ECattleApprove:{
//            tmpNoticeStr = NoticeKey_CattleApprove;
//            break;
//        }
//        case ECattleSetting:{
//            tmpNoticeStr = NoticeKey_CattleSetting;
//            break;
//        }
//    }
//    if(!isApproveFlag){
//        if([tmpNoticeStr isEqualToString:NoticeKey_CattleApprove]){
//            tmpNoticeStr = NoticeKey_CattleSetting;
//        }
    }
//    
//    PostNoticeObserver(tmpNoticeStr, @(tabBarController.selectedIndex));
//    
//    //写入viewController层级
//    gVCArr[0] = viewController;
}
@end
