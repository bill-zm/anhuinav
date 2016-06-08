//
//  FNMyCenterViewController.h
//  FoodNav
//
//  Created by aa on 16/6/6.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNMyCenterViewController : UIViewController
@property(nonatomic,weak) IBOutlet UIImageView *headimageView;
@property(nonatomic,weak) IBOutlet UILabel *nameLab;
@property(nonatomic,weak) IBOutlet UILabel *welcomeLab;

- (IBAction)exitBtnClick:(id)sender;
- (IBAction)collectBtnClick:(id)sender;
Strong UIAlertView *alertView;
@end
