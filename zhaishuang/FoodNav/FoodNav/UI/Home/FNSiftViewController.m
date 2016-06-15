//
//  FNSiftViewController.m
//  FoodNav
//
//  Created by 张梦 on 16/6/11.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNSiftViewController.h"
#import "CAppService.h"
@interface FNSiftViewController ()

@end

@implementation FNSiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *tmpbarButtonItem = [[UIBarButtonItem alloc] init];
    tmpbarButtonItem.title = NullString;
    self.navigationItem.backBarButtonItem = tmpbarButtonItem;
    [Common removeExtraCellLines:self.allTableView];
    [Common removeExtraCellLines:self.quTableView];
//    20000，50000，100000，10000000
    self.mdataArr = [NSMutableArray arrayWithArray:@[@"0 - 20km",@"0 - 50km",@"0 - 100km",@"不限"]];
    [[CAppService sharedInstance] getCitycode_request:^(NSDictionary *model) {
        if([model.allKeys containsObject:@"data"]){
            self.alldataArr = [NSMutableArray arrayWithArray:model[@"data"]];
//            self.shidataArr = [NSMutableArray array];
//            for(NSDictionary *tmpdic in self.alldataArr){
//                if([tmpdic.allKeys containsObject:@"name"] && [tmpdic.allKeys containsObject:@"id"]){
//                    
//                }
//            }
            [self.allTableView reloadData];
        }
    } failure:^(CAppServiceError *error) {
        
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.view.tag == 1){
        SetFrameByHeight(self.allTableView.frame, 200);
        return self.mdataArr.count;
        
    }
    SetFrameByHeight(self.allTableView.frame, 800);
    if(tableView == self.allTableView)
        return self.alldataArr.count;
    else if(tableView == self.quTableView)
        return self.quDataArr.count;
    else
        return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell_str";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(self.view.tag == 0){
    if(tableView == self.allTableView)
        cell.textLabel.text = self.alldataArr[indexPath.row][@"name"];
    if(tableView == self.quTableView)
        cell.textLabel.text = self.quDataArr[indexPath.row][@"name"];
    }
    else{
        cell.textLabel.text = self.mdataArr[indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.view.tag == 1){
    if(self.tableCellBlock){
            self.tableCellBlock(indexPath.row,self.mdataArr[indexPath.row]);
    }
        return;
    }
    if(tableView == self.quTableView){
        if(self.tableCellBlock){
            self.tableCellBlock(indexPath.row,self.quDataArr[indexPath.row][@"id"]);
        }
        return;
    }
    if(tableView == self.allTableView){
        SetFrameByWidth(self.allTableView.frame, Screen_Width/2);
        SetFrameByXPos(self.quTableView.frame, Screen_Width/2);
        SetFrameByWidth(self.quTableView.frame, Screen_Width/2);
        self.quDataArr = [NSMutableArray arrayWithArray:self.alldataArr[indexPath.row][@"children"]];
        [self.quTableView reloadData];
    }
}
- (void)fuTableView{
    SetFrameByWidth(self.allTableView.frame, Screen_Width);
    SetFrameByXPos(self.quTableView.frame, Screen_Width);
    SetFrameByWidth(self.quTableView.frame, Screen_Width/2);
    [self.allTableView reloadData];
    [self.quTableView reloadData];
}
- (IBAction)btnClickClear:(id)sender
{
    [self removeSelfView];
}
- (void)removeSelfView
{
    [UIView animateWithDuration:0.3 animations:^{
        SetFrameByYPos(self.view.frame,-Screen_Height);
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}
@end
