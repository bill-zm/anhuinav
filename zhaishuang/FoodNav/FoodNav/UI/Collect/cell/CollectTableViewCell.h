//
//  CollectTableViewCell.h
//  FoodNav
//
//  Created by aa on 16/6/7.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *allNumber;
@property (weak, nonatomic) IBOutlet UILabel *aoHouseNumber;
@property (weak, nonatomic) IBOutlet UILabel *youAllnumber;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property(nonatomic,weak)IBOutlet UIButton *navButton;
- (IBAction)navigateBtnClick:(id)sender;
- (void)initViewCellData:(id)model;
@end
