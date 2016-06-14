//
//  CollectTableViewCell.m
//  FoodNav
//
//  Created by aa on 16/6/7.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "CollectTableViewCell.h"

@implementation CollectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    setViewCorner(self.navButton, 5);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)navigateBtnClick:(id)sender
{
    NSString *str = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=applicationScheme&poiname=fangheng&poiid=BGVIS&lat=%f&lon=%f&dev=0&style=3",@"粮仓位置", 39.989631, 117.481018];
    str=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * myURL_APP_A =[[NSURL alloc] initWithString:str];
    NSLog(@"%@",myURL_APP_A);
    //    if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
    [[UIApplication sharedApplication] openURL:myURL_APP_A];
    //    }
    //    else{
    //        Alert(@"请您先安装高德地图");
    //    }
}
@end
