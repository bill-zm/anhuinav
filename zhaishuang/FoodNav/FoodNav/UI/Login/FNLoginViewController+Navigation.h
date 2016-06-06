//
//  FNLoginViewController+Navigation.h
//  FoodNav
//
//  Created by aa on 16/6/6.
//  Copyright © 2016年 xxcao. All rights reserved.
//

#import "FNLoginViewController.h"
#import "LeveyTabBarController.h"

@interface FNLoginViewController (Navigation)<LeveyTabBarControllerDelegate>
- (void)setupViews;
@end
