//
//  FNSiftViewController.h
//  FoodNav
//
//  Created by 张梦 on 16/6/11.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^tableCellSelect)(NSInteger,id);
@interface FNSiftViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) IBOutlet UITableView *allTableView;
@property(nonatomic,weak) IBOutlet UIButton *btnClear;
Copy tableCellSelect tableCellBlock;
- (IBAction)btnClickClear:(id)sender;
- (void)removeSelfView;
@end
