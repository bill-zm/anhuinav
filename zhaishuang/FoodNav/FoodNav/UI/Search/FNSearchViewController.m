//
//  FNSearchViewController.m
//  FoodNav
//
//  Created by 张梦 on 16/6/8.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNSearchViewController.h"
#import "FNMapViewController.h"
#import "CollectTableViewCell.h"
#import "FNDetailViewController.h"
@interface FNSearchViewController ()
{
//@property(strong,nonatomic)MLSearchBar *mySearchBar;
}
Strong UINib *cellNib;
@end

@implementation FNSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索结果";
    UIBarButtonItem *tmpbarButtonItem = [[UIBarButtonItem alloc] init];
    tmpbarButtonItem.title = NullString;
    self.navigationItem.backBarButtonItem = tmpbarButtonItem;
    self.cellNib = [UINib nibWithNibName:@"CollectTableViewCell" bundle:nil];
    self.resultTable.frame = Frame(0, 0, Screen_Width, Screen_Height-tabBar_Height-default_NavigationHeight_iOS7);
    self.resultTable.rowHeight = 150.0;
    [Common removeExtraCellLines:self.resultTable];
    self.navigationItem.rightBarButtonItem = [Common createBarItemWithLbs:^{
        FNMapViewController *mapVc = [[FNMapViewController alloc] initWithNibName:@"FNMapViewController" bundle:nil];
        //传粮仓坐标列表
        [self.navigationController pushViewController:mapVc animated:YES];
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#pragma mark UISearchBar and UISearchDisplayController Delegate Methods

@end
