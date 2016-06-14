//
//  FNHomeViewController+request.m
//  FoodNav
//
//  Created by aa on 16/6/14.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNHomeViewController+request.h"
#import "CAppService.h"
#import "SVProgressHUD.h"
@implementation FNHomeViewController (request)
- (void)getLiangListData:(NSInteger)pn P:(NSInteger)p
{
    if(p == 1)
        [SVProgressHUD showWithStatus:@"加载数据中..."];
    [[CAppService sharedInstance] liangcangList_request:pn p:p success:^(NSDictionary *model) {
        self.npage++;
        if([model.allKeys containsObject:@"data"]){
            if([model[@"data"] isKindOfClass:[NSArray class]]){
                if(self.dataArr.count == 0){
                    self.dataArr = [NSMutableArray arrayWithArray:model[@"data"]];
                }
                else{
                    [self.dataArr addObjectsFromArray:model[@"data"]];
                }
            }
            [self.hometableView reloadData];
        }
        if(p == 1){
            [self setupRefreshControllList];
            [SVProgressHUD dismiss];
        }
    } failure:^(CAppServiceError *error) {
        [SVProgressHUD dismiss];
    }];
}
@end
