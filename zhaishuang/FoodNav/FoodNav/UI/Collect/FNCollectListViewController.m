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
#import "MJRefresh.h"
#import "CAppService.h"
@interface FNCollectListViewController ()
Strong UINib *cellNib;
Strong NSMutableArray *dataArr;
@end

@implementation FNCollectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"粮仓收藏";
    UIBarButtonItem *tmpbarButtonItem = [[UIBarButtonItem alloc] init];
    tmpbarButtonItem.title = NullString;
    self.navigationItem.backBarButtonItem = tmpbarButtonItem;
    self.cellNib = [UINib nibWithNibName:@"CollectTableViewCell" bundle:nil];
    self.colltableView.frame = Frame(0, 0, Screen_Width, Screen_Height-tabBar_Height-default_NavigationHeight_iOS7);
    self.colltableView.rowHeight = 150.0;
    [Common removeExtraCellLines:self.colltableView];
    
    self.navigationItem.rightBarButtonItem = [Common createBarItemWithLbs:^{
        FNMapViewController *mapVc = [[FNMapViewController alloc] initWithNibName:@"FNMapViewController" bundle:nil];
        [self.navigationController pushViewController:mapVc animated:YES];
    }];
    [self lowsetupRefreshControllList];
    [[CAppService sharedInstance] collectList_request:user_id success:^(NSDictionary *model) {
        if([model.allKeys containsObject:@"data"]){
            if([model[@"data"] isKindOfClass:[NSArray class]]){
                self.dataArr = [NSMutableArray arrayWithArray:model[@"data"]];
//                if(self.dataArr.count == 0){
//                    self.dataArr = [NSMutableArray arrayWithArray:model[@"data"]];
//                }
//                else{
////                    [self.dataArr addObjectsFromArray:model[@"data"]];
//                }
            }
            [self.colltableView reloadData];
        }
    } failure:^(CAppServiceError *error) {
        
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)lowsetupRefreshControllList {
    __weak typeof(self) wself = self;
    self.colltableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [[CAppService sharedInstance] collectList_request:user_id success:^(NSDictionary *model) {
            if([model.allKeys containsObject:@"data"]){
                if([model[@"data"] isKindOfClass:[NSArray class]]){
                    self.dataArr = [NSMutableArray arrayWithArray:model[@"data"]];
                }
                [self.colltableView reloadData];
            }
        } failure:^(CAppServiceError *error) {
            
        }];
        [wself.colltableView.mj_header endRefreshing];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
//            [wself.colltableView.mj_header endRefreshing];
//        });
    }];
}
//上拉刷新
- (void)setupRefreshControllList
{
    WeakSelf;
    self.colltableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //        if(!(wself.recordArr.count % gPageSize)){
        //            [wself getAppointmentRecordListRequestMany];
        //        }
        //        else{
        //            [Common promptShowTextTips:@"暂无更多数据" Time:1.5 CounstView:self.view];
        [wself.colltableView.mj_footer endRefreshing];
        [wself.colltableView.mj_footer endRefreshingWithNoMoreData];
        //        }
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CollectTableViewCell";
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [self.cellNib instantiateWithOwner:self options:nil][0];
    }
    [cell initViewCellData:self.dataArr[indexPath.row]];
    return cell;
 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FNDetailViewController *fndetail = [[FNDetailViewController alloc] initWithNibName:@"FNDetailViewController" bundle:nil];
    fndetail.liangId = self.dataArr[indexPath.row][@"id"];
    [self.navigationController pushViewController:fndetail animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了删除");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.infoItems removeObjectAtIndex:(indexPath.row*2)];
//        [self.infoItems removeObjectAtIndex:(indexPath.row*2)];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [[CAppService sharedInstance] collectLiang_request:user_id warehouse_id:NullString isdelte:0 success:^(NSDictionary *model) {
            if([model[@"msg"] isEqualToString:@"00001"]){
                [self.dataArr removeObjectAtIndex:indexPath.row];
                [self.colltableView reloadData];
            }
        } failure:^(CAppServiceError *error) {
        }];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"手指撮动了");
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  @"删除";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
@end
