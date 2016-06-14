//
//  CollectTableViewCell.h
//  FoodNav
//
//  Created by aa on 16/6/7.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIButton *navButton;
- (IBAction)navigateBtnClick:(id)sender;
@end
