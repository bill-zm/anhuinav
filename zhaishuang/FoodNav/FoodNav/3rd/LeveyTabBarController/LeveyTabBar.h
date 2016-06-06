//
//  LeveyTabBar.h
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MacroDef.h"

@protocol LeveyTabBarDelegate;

@interface LeveyTabBar : UIView

Strong UIImageView *backgroundView;
Assign id<LeveyTabBarDelegate> delegate;
Strong NSMutableArray *buttons;
Strong NSMutableArray *labs;
Strong NSMutableArray *circles;

Strong id object_NoticeKey_ApproveTabbar_Page;
Strong id object_NoticeKey_ApproveTabbar_Remove;
Strong id object_NoticeKey_HistoryLevTabbar_Page;
Strong id object_NoticeKey_HistoryLevTabbar_Remove;
Strong id object_NoticeKey_SettingLevTabbar_Page;
Strong id object_NoticeKey_SettingLevTabbar_Remove;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray titles:(NSArray *)titleArray;
- (void)selectTabAtIndex:(NSInteger)index;
- (void)removeTabAtIndex:(NSInteger)index;
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index;
- (void)setBackgroundImage:(UIImage *)img;

@end
@protocol LeveyTabBarDelegate<NSObject>
@optional
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index; 
@end
