//
//  FNCollectListViewController.h
//  FoodNav
//
//  Created by aa on 16/6/7.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNCollectListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) IBOutlet UITableView *colltableView;
@end
