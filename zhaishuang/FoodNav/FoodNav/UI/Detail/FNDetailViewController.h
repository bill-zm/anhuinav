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
@property (weak, nonatomic) IBOutlet UIView *mymapView;
@property(nonatomic,weak)IBOutlet UIButton *navButton;
@property(nonatomic,weak)IBOutlet UIButton *collButton;
Strong NSString *liangId;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *youguanAllnumber;
@property (weak, nonatomic) IBOutlet UILabel *cangHouseAllNum;
@property (weak, nonatomic) IBOutlet UILabel *aoHouseAllNum;
@property (weak, nonatomic) IBOutlet UILabel *youguanAllnumber1;
@property (weak, nonatomic) IBOutlet UILabel *cangHouseAllNum1;
@property (weak, nonatomic) IBOutlet UILabel *aoHouseAllNum1;

@property (weak, nonatomic) IBOutlet UILabel *enterpriseName;
@property (weak, nonatomic) IBOutlet UILabel *designAllcapacity;
@property (weak, nonatomic) IBOutlet UILabel *lbsSign;
@property (weak, nonatomic) IBOutlet UILabel *youkuanDesignAll;
@property (weak, nonatomic) IBOutlet UILabel *distancelab;
Strong NSDictionary *dataDic;
- (IBAction)navigateBtnClick:(id)sender;
- (IBAction)collectBtnClick:(id)sender;
@end
