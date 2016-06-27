//
//  FNSearchViewController.h
//  FoodNav
//
//  Created by 张梦 on 16/6/8.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FNSearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) IBOutlet UITableView *resultTable;
@end
