//
//  YKMainViewController.m
//  YueKong
//
//  Created by aa on 16/1/6.
//  Copyright © 2016年 Carl Liu. All rights reserved.
//

#import "FNMainViewController.h"
@interface FNMainViewController ()

@end

@implementation FNMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [SVProgressHUD dismiss];
}
//void doNotificaiotn(id self, SEL _cmd, id sender){
//    [[NSNotificationCenter defaultCenter] doNotificationAction:sender Key:NSStringFromSelector(_cmd)];
//}
@end
