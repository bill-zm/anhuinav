//
//  FNMyCenterViewController.m
//  FoodNav
//
//  Created by aa on 16/6/6.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNMyCenterViewController.h"
#import "FNCollectListViewController.h"
@interface FNMyCenterViewController ()

@end

@implementation FNMyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Center";
    setViewCorner(self.headimageView, 50);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)exitBtnClick:(id)sender{

}
- (IBAction)collectBtnClick:(id)sender{
    FNCollectListViewController *collect = [[FNCollectListViewController alloc] initWithNibName:@"FNCollectListViewController" bundle:nil];
    [self.navigationController pushViewController:collect animated:YES];
}
@end
