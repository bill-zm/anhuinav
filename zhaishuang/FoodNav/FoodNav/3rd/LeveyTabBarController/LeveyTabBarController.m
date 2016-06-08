//
//  LeveyTabBarControllerViewController.m
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//
#import "LeveyTabBarController.h"
#import "LeveyTabBar.h"
#define kTabBarHeight (49.0)

static LeveyTabBarController *leveyTabBarController;

@implementation UIViewController (LeveyTabBarControllerSupport)

- (LeveyTabBarController *)leveyTabBarController
{
	return leveyTabBarController;
}

@end

@interface LeveyTabBarController (private)
- (void)displayViewAtIndex:(NSUInteger)index;
@end

@implementation LeveyTabBarController
@synthesize delegate = _delegate;
@synthesize selectedViewController = _selectedViewController;
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize tabBarHidden = _tabBarHidden;

#pragma mark -
#pragma mark lifecycle
- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr titles:(NSArray *)tArr {
	self = [super init];
		_viewControllers = [NSMutableArray arrayWithArray:vcs];
        CGRect r = [UIScreen mainScreen].bounds;
        _containerView = [[UIView alloc] initWithFrame:r];
		_transitionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, _containerView.frame.size.height - (iOS7 ? 0 : kTabBarHeight))];
//		_transitionView.backgroundColor =  [UIColor whiteColor];
        _transitionView.layer.borderWidth = 0.5;
        _transitionView.layer.borderColor = [Common colorFromHexRGB:@"999999"].CGColor;
		_tabBar = [[LeveyTabBar alloc] initWithFrame:CGRectMake(0,[[UIScreen mainScreen] bounds].size.height - (iOS7 ? 0 : kTabBarHeight), [[UIScreen mainScreen] bounds].size.width, kTabBarHeight) buttonImages:arr titles:tArr];
		_tabBar.delegate = self;
        leveyTabBarController = self;
	return self;
}

- (void)loadView 
{
	[super loadView];
	[_containerView addSubview:_transitionView];
    UILabel *lab = [[UILabel alloc] initWithFrame:Frame(Screen_Width/2, 0, 0.5, kTabBarHeight)];
    lab.backgroundColor = [Common colorFromHexRGB:@"cccccc"];
    lab.alpha = 0.4;
    [_tabBar addSubview:lab];
	[_containerView addSubview:_tabBar];
	self.view = _containerView;
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.selectedIndex = 0;
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	_tabBar = nil;
	_viewControllers = nil;
}

- (void)dealloc {
    _tabBar = nil;
    _viewControllers = nil;
}

#pragma mark - instant methods
- (LeveyTabBar *)tabBar
{
	return _tabBar;
}

- (BOOL)tabBarTransparent
{
	return _tabBarTransparent;
}
- (void)setTabBarTransparent:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		_transitionView.frame = CGRectMake(0, 0, Screen_Width, _containerView.frame.size.height - (iOS7 ? 0 : kTabBarHeight));
	}
}
- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;
{
	if (yesOrNO == YES)
	{
		if (self.tabBar.frame.origin.y == Screen_Height)
		{
			return;
		}
	}
	else 
	{
		if (self.tabBar.frame.origin.y == Screen_Height - kTabBarHeight)
		{
			return;
		}
	}
	if (animated == YES)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3f];
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else 
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		[UIView commitAnimations];
	}
	else 
	{
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else 
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
	}
}

- (NSUInteger)selectedIndex
{
	return _selectedIndex;
}
- (UIViewController *)selectedViewController
{
    return [_viewControllers objectAtIndex:_selectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)index
{
    [self displayViewAtIndex:index];
    [_tabBar selectTabAtIndex:index];
}

- (void)removeViewControllerAtIndex:(NSUInteger)index
{
    if (index >= [_viewControllers count])
    {
        return;
    }
    // Remove view from superview.
    [[(UIViewController *)[_viewControllers objectAtIndex:index] view] removeFromSuperview];
    // Remove viewcontroller in array.
    [_viewControllers removeObjectAtIndex:index];
    // Remove tab from tabbar.
    [_tabBar removeTabAtIndex:index];
}

- (void)removeCustomObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self.tabBar.object_NoticeKey_ApproveTabbar_Page];
    [[NSNotificationCenter defaultCenter] removeObserver:self.tabBar.object_NoticeKey_ApproveTabbar_Remove];
    [[NSNotificationCenter defaultCenter] removeObserver:self.tabBar.object_NoticeKey_HistoryLevTabbar_Page];
    [[NSNotificationCenter defaultCenter] removeObserver:self.tabBar.object_NoticeKey_HistoryLevTabbar_Remove];
    [[NSNotificationCenter defaultCenter] removeObserver:self.tabBar.object_NoticeKey_SettingLevTabbar_Page];
    [[NSNotificationCenter defaultCenter] removeObserver:self.tabBar.object_NoticeKey_SettingLevTabbar_Remove];
}

- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    [_viewControllers insertObject:vc atIndex:index];
    [_tabBar insertTabWithImageDic:dict atIndex:index];
}
#pragma mark - Private methods
- (void)displayViewAtIndex:(NSUInteger)index
{
    // Before changing index, ask the delegate should change the index.
    if ([_delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) 
    {
        if (![_delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
            return;
    }
    UIViewController *targetViewController = [self.viewControllers objectAtIndex:index];
    // If target index is equal to current index.
    if (_selectedIndex == index && [[_transitionView subviews] count] != 0) 
    {
        if ([targetViewController isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController*)targetViewController popToRootViewControllerAnimated:YES];
        }
        return;
    }
    _selectedIndex = index;
	[_transitionView.subviews makeObjectsPerformSelector:@selector(setHidden:) withObject:@(YES)];
    targetViewController.view.hidden = NO;
	targetViewController.view.frame = _transitionView.frame;
    for(UIView *v in [_transitionView  subviews]){
        [v removeFromSuperview];
    }
    [_transitionView addSubview:targetViewController.view];
    if ([_delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
    {
        [_delegate tabBarController:self didSelectViewController:targetViewController];
    }
}
#pragma mark -
#pragma mark tabBar delegates
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index
{
	[self displayViewAtIndex:index];
}
@end
