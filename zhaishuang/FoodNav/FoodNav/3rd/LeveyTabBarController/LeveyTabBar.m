//
//  LeveyTabBar.m
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import "LeveyTabBar.h"
#import "BlockUI.h"
//#import "DataManager.h"
@implementation LeveyTabBar
- (void)dealloc
{
//    RemoveNoticeObserver(NoticeKey_ApproveTabbar_Page, self);
//    RemoveNoticeObserver(NoticeKey_ApproveTabbar_Remove, self);
//    RemoveNoticeObserver(NoticeKey_HistoryLevTabbar_Page, self);
//    RemoveNoticeObserver(NoticeKey_HistoryLevTabbar_Remove, self);
}
- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray titles:(NSArray *)titleArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _object_NoticeKey_ApproveTabbar_Page = nil;
        _object_NoticeKey_ApproveTabbar_Remove = nil;
        _object_NoticeKey_HistoryLevTabbar_Page = nil;
        _object_NoticeKey_HistoryLevTabbar_Remove = nil;
        _object_NoticeKey_SettingLevTabbar_Page = nil;
        _object_NoticeKey_SettingLevTabbar_Remove = nil;
//		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
//		[self addSubview:_backgroundView];
		self.buttons = [NSMutableArray arrayWithCapacity:imageArray.count];
        self.labs = [NSMutableArray arrayWithCapacity:4];
        self.circles = [NSMutableArray array];
		CGFloat width = (Screen_Width) / imageArray.count;
        WeakSelf;
        [imageArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //icon
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
			btn.showsTouchWhenHighlighted = YES;
			btn.tag = idx;
            btn.frame = CGRectMake(width * idx+width/2-50, 10, 29, 29);

			[btn setImage:imageArray[idx][@"Default"] forState:UIControlStateNormal];
			[btn setImage:imageArray[idx][@"Highlighted"] forState:UIControlStateHighlighted];
			[btn setImage:imageArray[idx][@"Seleted"] forState:UIControlStateSelected];
			[wself addSubview:btn];
            [wself.buttons addObject:btn];
            
            //title
            UILabel *label = [[UILabel alloc] initWithFrame:Frame(width * idx+width/2-20, 10, 60, 29)];
            label.text = titleArray[idx];
            label.backgroundColor = ClearColor;
            label.textColor = ColorRGB(153, 153, 153);
            label.font = Font(16.0);
            label.textAlignment = NSTextAlignmentCenter;
            [wself addSubview:label];
            [wself.labs addObject:label];
            
            //mask button
            UIButton *maskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
			maskBtn.tag = idx;
            maskBtn.frame = CGRectMake(width * idx, 0, width, frame.Height);
            [maskBtn handleControlEvent:UIControlEventTouchUpInside
                              withBlock:^(id sender) {
                UIButton *btn = sender;
                [wself selectTabAtIndex:btn.tag];
            }];
			[wself addSubview:maskBtn];
        }];
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)img
{
	[_backgroundView setImage:img];
}

- (void)tabBarButtonClicked:(id)sender
{
	UIButton *btn = sender;
	[self selectTabAtIndex:btn.tag];
}

- (void)selectTabAtIndex:(NSInteger)index
{
    __weak typeof(self) wself = self;
    [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *b = wself.buttons[idx];
		b.selected = NO;
    }];
	UIButton *btn = self.buttons[index];
	btn.selected = YES;
    [self.labs enumerateObjectsUsingBlock:^(UILabel *lab, NSUInteger idx, BOOL *stop) {
        lab.textColor = ColorRGB(153, 153, 153);
    }];
    UILabel *lab = self.labs[index];
    lab.textColor = [Common colorFromHexRGB:@"00bbee"];
    
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [_delegate tabBar:self didSelectIndex:btn.tag];
    }
//    NSLog(@"Select index: %d",btn.tag);
}

- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(UIButton *)self.buttons[index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
   
    // Re-index the buttons
     CGFloat width = (Screen_Width) / [self.buttons count];
    for (UIButton *btn in self.buttons) {
        if (btn.tag > index) {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * btn.tag, 0, width, self.frame.size.height);
    }
}

- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index {
    // Re-index the buttons
    CGFloat width = (Screen_Width) / ([self.buttons count] + 1);
    for (UIButton *b in self.buttons) {
        if (b.tag >= index) {
            b.tag ++;
        }
        b.frame = CGRectMake(width * b.tag, 0, width, self.frame.size.height);
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index;
    btn.frame = CGRectMake(width * index, 0, width, self.frame.size.height);
    [btn setImage:dict[@"Default"] forState:UIControlStateNormal];
    [btn setImage:dict[@"Highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:dict[@"Seleted"] forState:UIControlStateSelected];
    WeakSelf;
    [btn handleControlEvent:UIControlEventTouchUpInside
                  withBlock:^(id sender) {
        UIButton *btn = sender;
        [wself selectTabAtIndex:btn.tag];
    }];
    [self.buttons insertObject:btn
                       atIndex:index];
    [self addSubview:btn];
}

@end
