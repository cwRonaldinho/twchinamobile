//
//  LeveyTabBarControllerViewController.h
//  LeveyTabBarController
//
//  Created by zhang on 12-10-10.
//  Copyright (c) 2012年 jclt. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "LeveyTabBar.h"
#import "CustomNavBar.h"
#import "EGORefreshTableHeaderView.h"

@class UITabBarController;
@protocol LeveyTabBarControllerDelegate;

@interface MainTabBarController : UIViewController <LeveyTabBarDelegate, UIScrollViewDelegate, EGORefreshTableHeaderDelegate>
{
	LeveyTabBar *_tabBar;
	UIView      *_containerView;
	UIView		*_transitionView;

	NSMutableArray *_viewControllers;
	NSUInteger _selectedIndex;
	
	BOOL _tabBarTransparent;
	BOOL _tabBarHidden;
    
    NSInteger animateDriect;
    
    BOOL _reloading;
}

@property(nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;

@property(nonatomic, strong) UIScrollView *scrollView;  // 所有一级页面均放在该滑动视图之中

@property(nonatomic, copy) NSMutableArray *viewControllers;

@property(nonatomic, readonly) UIViewController *selectedViewController;
@property(nonatomic) NSUInteger selectedIndex;

// Apple is readonly
@property (nonatomic, strong) CustomNavBar *navBar; // 添加自定义导航栏 新语法，只需要声明 property 即可
@property (nonatomic, readonly) LeveyTabBar *tabBar;
@property(nonatomic,assign) id<LeveyTabBarControllerDelegate> delegate;


// Default is NO, if set to YES, content will under tabbar
@property (nonatomic) BOOL tabBarTransparent;
@property (nonatomic) BOOL tabBarHidden;

@property(nonatomic,assign) NSInteger animateDriect;

//- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr;

- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;
//- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated driect:(NSInteger)driect;

// Remove the viewcontroller at index of viewControllers.
- (void)removeViewControllerAtIndex:(NSUInteger)index;

// Insert an viewcontroller at index of viewControllers.
- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index;

- (void)hideBars:(BOOL)yesOrNo;

// 切换视图操作
- (void)switchToCategoryDetails:(int)index;

// 下拉刷新相关操作
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

+ (MainTabBarController *)mainTabBarController;

@end


@protocol LeveyTabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(MainTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(MainTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
@end

// 重绘本视图协议
@protocol RedrawLevyTabBarControllerDelegate <NSObject>
@optional
- (void)reDraw;
@end

@interface UIViewController (LeveyTabBarControllerSupport)
//@property(nonatomic, readonly) MainTabBarController *leveyTabBarController;
@end

