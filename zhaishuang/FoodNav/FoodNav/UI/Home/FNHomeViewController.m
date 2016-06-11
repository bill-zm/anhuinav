//
//  FNHomeViewController.m
//  FoodNav
//
//  Created by aa on 16/6/6.
//  Copyright © 2016年 xxcao. All rights reserved.
//
#import "FNHomeViewController.h"
#import "CollectTableViewCell.h"
#import "FNDetailViewController.h"
#import "FNMapViewController.h"
#import "FNSearchViewController.h"
#import "FNMainNavigationController.h"
#import "MLSearchBar.h"
#import "FNSearchViewController.h"
#import "FNSiftViewController.h"
@interface FNHomeViewController ()<UITextFieldDelegate>
{
    UITextField *searchText;
    UIButton *cancelButton;
    FNSiftViewController *fnsift;
}
Strong UINib *cellNib;
@end

@implementation FNHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *tmpbarButtonItem = [[UIBarButtonItem alloc] init];
    tmpbarButtonItem.title = NullString;
    self.navigationItem.backBarButtonItem = tmpbarButtonItem;
    UIView *pview = [[UIView alloc] initWithFrame:Frame(0, 0, Screen_Width-250, 30)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"" forState:UIControlStateNormal];
    btn.frame = Frame(0, 0, Screen_Width-250, 30);
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    pview.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [pview addSubview:btn];
    setViewCorner(pview, 5);
    UIImageView *bigimage = [[UIImageView alloc] initWithFrame:Frame(5, 5, 16, 16)];
    [bigimage setImage:Image(@"fnbigmagnifying")];
    [pview addSubview:bigimage];
    searchText = [[UITextField alloc] initWithFrame:CGRectMake(24, 0, Screen_Width-314, 30)];
    searchText.delegate = self;
    searchText.borderStyle = UITextBorderStyleNone;
    [searchText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [searchText setPlaceholder:@"请输入粮仓的名称"];
    [searchText setFont:Font(14.0)];
    searchText.returnKeyType = UIReturnKeySearch;
    [searchText setValue:[Common colorFromHexRGB:@"999999"] forKeyPath:@"_placeholderLabel.textColor"];
    [[UITextField appearance] setTintColor:[Common colorFromHexRGB:@"007AFF"]];
//    [searchText setBackgroundColor:[UIColor redColor]];
    [pview addSubview:searchText];
    
    UIButton *cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelbtn setFrame:Frame(Screen_Width-290, 0, 40, 30)];
    [cancelbtn setTitleColor:[Common colorFromHexRGB:@"A7CB31"] forState:UIControlStateNormal];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelbtn.titleLabel.font = Font(14.0);
    [cancelbtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [pview addSubview:cancelbtn];
    cancelButton = cancelbtn;
    cancelButton.hidden = YES;
    self.navigationItem.titleView = pview;
    
    
    self.cellNib = [UINib nibWithNibName:@"CollectTableViewCell" bundle:nil];
    self.hometableView.frame = Frame(0, 50, Screen_Width, Screen_Height-tabBar_Height-default_NavigationHeight_iOS7-50);
    self.hometableView.rowHeight = 150.0;
    [Common removeExtraCellLines:self.hometableView];
    self.navigationItem.rightBarButtonItem = [Common createBarItemWithLbs:^{
        FNMapViewController *mapVc = [[FNMapViewController alloc] initWithNibName:@"FNMapViewController" bundle:nil];
        [self.navigationController pushViewController:mapVc animated:YES];
    }];
    [self setSiftView];
}
- (void)setSiftView
{
    UIView *pview  = [[UIView alloc] initWithFrame:Frame(0, 0, Screen_Width, 50)];
    pview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pview];
    UILabel *linelab = [[UILabel alloc] initWithFrame:Frame(0, 49, Screen_Width, 1)];
    linelab.text = NullString;
    linelab.backgroundColor = [Common colorFromHexRGB:@"cccccc"];
    [pview addSubview:linelab];
    for(int i=0;i<4;i++){
        UIButton *tmpbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tmpbtn setBackgroundColor:[UIColor clearColor]];
        tmpbtn.titleLabel.font = Font(15.0);
        [tmpbtn setTitleColor:[Common colorFromHexRGB:@"444444"] forState:UIControlStateNormal];
        [tmpbtn setFrame:Frame(i*Screen_Width/4, 0, Screen_Width/4, 50)];
        [tmpbtn addTarget:self action:@selector(btnClickSift:) forControlEvents:UIControlEventTouchUpInside];
        [pview addSubview:tmpbtn];
        UILabel *linelab1 = [[UILabel alloc] initWithFrame:Frame(Screen_Width/4*i, 0, 1, 50)];
        linelab1.text = NullString;
        linelab1.backgroundColor = [Common colorFromHexRGB:@"cccccc"];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:Frame(Screen_Width/4*(i+1)-60, 17, 16, 16)];
        [imageview setImage:Image(@"fnarrowicon.png")];
        switch (i) {
            case 0:
                [tmpbtn setTitle:@"默认排序" forState:UIControlStateNormal];
                [pview addSubview:imageview];
                break;
            case 1:
                [tmpbtn setTitle:@"所在地" forState:UIControlStateNormal];
                [pview addSubview:linelab1];
                SetFrameByXPos(imageview.frame, Screen_Width/4*(i+1)-70);
                [pview addSubview:imageview];
                break;
            case 2:
                [tmpbtn setTitle:@"距离" forState:UIControlStateNormal];
                [pview addSubview:linelab1];
                SetFrameByXPos(imageview.frame, Screen_Width/4*(i+1)-80);
                [pview addSubview:imageview];
                break;
            case 3:
                [tmpbtn setTitle:@"筛选" forState:UIControlStateNormal];
                [pview addSubview:linelab1];
                [imageview setImage:Image(@"fnsifticon.png")];
                [imageview setFrame:Frame(Screen_Width/4*i+60, 17, 16, 16)];
                [pview addSubview:imageview];
                break;
            default:
                break;
        }
    }
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
- (void)searchBtnClick:(id)sender
{
    FNSearchViewController *fnser = [[FNSearchViewController alloc] initWithNibName:@"FNSearchViewController" bundle:nil];
    [self.navigationController pushViewController:fnser animated:YES];
}
- (void)cancelBtnClick:(id)sender
{
    searchText.text = NullString;
    [searchText resignFirstResponder];
}
#pragma mark
#pragma mark --UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    cancelButton.hidden = NO;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    cancelButton.hidden = YES;
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    
//}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    //send 搜索命令
    FNSearchViewController *serView = [[FNSearchViewController alloc] initWithNibName:@"FNSearchViewController" bundle:nil];
    [self.navigationController pushViewController:serView animated:YES];
    searchText.text = NullString;
    [searchText resignFirstResponder];
    return YES;
}
- (void)btnClickSift:(UIButton *)sender
{
    if([self.view.subviews containsObject:fnsift.view]){
        return;
    }
    fnsift = [[FNSiftViewController alloc] initWithNibName:@"FNSiftViewController" bundle:nil];
    fnsift.tableCellBlock = ^(NSInteger row,id data){
        [fnsift removeSelfView];
    };
    [fnsift.view setFrame:Frame(0, -Screen_Height, Screen_Width, Screen_Height)];
    [self.view addSubview:fnsift.view];
    [UIView animateWithDuration:0.3 animations:^{
        SetFrameByYPos(fnsift.view.frame,50);
    } completion:^(BOOL finished) {
    }];
}
@end