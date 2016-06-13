//
//  FNDetailViewController.h
//  FoodNav
//
//  Created by aa on 16/6/7.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNDetailViewController : UIViewController
@property(nonatomic,weak)IBOutlet UIView *fnmapView;
@property(nonatomic,weak)IBOutlet UIButton *navButton;
@property(nonatomic,weak)IBOutlet UIButton *collButton;
- (IBAction)navigateBtnClick:(id)sender;
- (IBAction)collectBtnClick:(id)sender;
@end
