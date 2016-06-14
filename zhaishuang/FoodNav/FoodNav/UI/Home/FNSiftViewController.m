//
//  FNSiftViewController.m
//  FoodNav
//
//  Created by 张梦 on 16/6/11.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNSiftViewController.h"

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
    static NSString *CellIdentifier = @"cell_str";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"筛选";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.view.tag == 1){
    if(self.tableCellBlock){
            self.tableCellBlock(indexPath.row,@"data");
    }
        return;
    }
    if(tableView == self.quTableView){
        if(self.tableCellBlock){
            self.tableCellBlock(indexPath.row,@"data");
        }
        return;
    }
    if(tableView == self.allTableView){
        SetFrameByWidth(self.allTableView.frame, Screen_Width/2);
        SetFrameByXPos(self.quTableView.frame, Screen_Width/2);
        SetFrameByWidth(self.quTableView.frame, Screen_Width/2);
    }
}
- (void)fuTableView{
    SetFrameByWidth(self.allTableView.frame, Screen_Width);
    SetFrameByXPos(self.quTableView.frame, Screen_Width);
    SetFrameByWidth(self.quTableView.frame, Screen_Width/2);
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
