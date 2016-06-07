//
//  FNHomeViewController.m
//  FoodNav
//
//  Created by aa on 16/6/6.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNHomeViewController.h"
#import "CollectTableViewCell.h"
@interface FNHomeViewController ()
Strong UINib *cellNib;

@end

@implementation FNHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    self.cellNib = [UINib nibWithNibName:@"CollectTableViewCell" bundle:nil];
    self.hometableView.frame = Frame(0, 40, Screen_Width, Screen_Height-tabBar_Height-default_NavigationHeight_iOS7-40);
    self.hometableView.rowHeight = 100.0;
    [Common removeExtraCellLines:self.hometableView];
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
    
    NSString *str=[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&backScheme=applicationScheme&slat=%f&slon=%f&sname=我&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=1",39.989631,116.481018,39.989631,117.481018,@"nihao"];
    str=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * myURL_APP_A =[[NSURL alloc] initWithString:str];
    NSLog(@"%@",myURL_APP_A);
//    if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
        [[UIApplication sharedApplication] openURL:myURL_APP_A];
//    }
}
@end
