//
//  FNLoginViewController.h
//  FoodNav
//
//  Created by aa on 16/6/3.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeveyTabBarController.h"
#import "HYCircleLoadingView.h"
@interface FNLoginViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *userNumber;
@property (retain, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UILabel *vistureLab;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet HYCircleLoadingView *circleLoadingView;
@property (retain, nonatomic) LeveyTabBarController *leveyTabBarController;
- (IBAction)btnClick:(id)sender;
@end
