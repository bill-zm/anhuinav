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
    if([self.dataDic.allKeys containsObject:@"longitude"] && [self.dataDic.allKeys containsObject:@"latitude"]){
        NSString *str = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=applicationScheme&poiname=fangheng&poiid=BGVIS&lat=%f&lon=%f&dev=0&style=3",@"粮仓位置", [self.dataDic[@"latitude"] doubleValue], [self.dataDic[@"longitude"] doubleValue]];
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
}
- (void)initViewCellData:(NSDictionary *)model
{
    self.dataDic = model;
    if([model.allKeys containsObject:@"graindepot_name"])
    self.name.text = model[@"graindepot_name"];
    
    if([model.allKeys containsObject:@"address"])
        self.address.text = model[@"address"];
    
    if([model.allKeys containsObject:@"store_count"])
        self.allNumber.text = model[@"store_count"];
    
    if([model.allKeys containsObject:@"warehouse_count"])
        self.aoHouseNumber.text = model[@"warehouse_count"];
    
    if([model.allKeys containsObject:@"oilcan_count"])
        self.youAllnumber.text = model[@"oilcan_count"];
    if([model.allKeys containsObject:@"distance"])
        self.distancelab.text = [NSString stringWithFormat:@"%.1f km",[model[@"distance"] floatValue]/1000];
}
@end
