//
//  FNCollectListViewController.m
//  FoodNav
//
//  Created by aa on 16/6/7.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNCollectListViewController.h"
#import "CollectTableViewCell.h"
#import "FNDetailViewController.h"
#import "FNMapViewController.h"
@interface FNCollectListViewController ()
Strong UINib *cellNib;
@end

@implementation FNCollectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"粮仓收藏";
    self.cellNib = [UINib nibWithNibName:@"CollectTableViewCell" bundle:nil];
    self.colltableView.frame = Frame(0, 0, Screen_Width, Screen_Height-tabBar_Height-default_NavigationHeight_iOS7);
    self.colltableView.rowHeight = 150.0;
    [Common removeExtraCellLines:self.colltableView];
    
    self.navigationItem.rightBarButtonItem = [Common createBarItemWithLbs:^{
        FNMapViewController *mapVc = [[FNMapViewController alloc] initWithNibName:@"FNMapViewController" bundle:nil];
        [self.navigationController pushViewController:mapVc animated:YES];
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CollectTableViewCell";
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [self.cellNib instantiateWithOwner:self options:nil][0];
    }
//    [cell initViewCellData:self.dataArr[indexPath.row]];
    return cell;
 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FNDetailViewController *fndetail = [[FNDetailViewController alloc] initWithNibName:@"FNDetailViewController" bundle:nil];
    [self.navigationController pushViewController:fndetail animated:YES];
}
@end
