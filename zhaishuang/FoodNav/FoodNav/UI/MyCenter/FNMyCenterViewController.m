//
//  FNMyCenterViewController.m
//  FoodNav
//
//  Created by aa on 16/6/6.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNMyCenterViewController.h"
#import "FNCollectListViewController.h"
#import "BUIView.h"
#import "FNLoginViewController.h"
#import "SVProgressHUD.h"
@interface FNMyCenterViewController ()

@end

@implementation FNMyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    UIBarButtonItem *tmpbarButtonItem = [[UIBarButtonItem alloc] init];
    tmpbarButtonItem.title = NullString;
    self.navigationItem.backBarButtonItem = tmpbarButtonItem;
    setViewCorner(self.headimageView, 50);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)exitBtnClick:(id)sender{
    self.alertView = nil;
    self.alertView = [[UIAlertView alloc] initWithTitle:Default_TipSTR
                                                message:@"确定要退出吗？"
                                               delegate:self
                                      cancelButtonTitle:Default_CancelSTR
                                      otherButtonTitles:Default_OKSTR,nil];
    [self.alertView showWithCompletionHandler:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                FNLoginViewController *exitlogin = [[FNLoginViewController alloc] initWithNibName:@"FNLoginViewController" bundle:nil];
                [self presentViewController:exitlogin animated:NO completion:nil];
            });
        }
    }];
}
- (IBAction)collectBtnClick:(id)sender{
    if([Common isEmptyString:user_id]){
        [SVProgressHUD showErrorWithStatus:@"未登录"];
        return;
    }
    FNCollectListViewController *collect = [[FNCollectListViewController alloc] initWithNibName:@"FNCollectListViewController" bundle:nil];
    [self.navigationController pushViewController:collect animated:YES];
}
@end
