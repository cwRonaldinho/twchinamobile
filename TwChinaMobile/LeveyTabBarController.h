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

@class UITabBarController;
@protocol LeveyTabBarControllerDelegate;

@interface LeveyTabBarController : UIViewController <LeveyTabBarDelegate, UIScrollViewDelegate>
{
	LeveyTabBar *_tabBar;
	UIView      *_containerView;
	UIView		*_transitionView;

	NSMutableArray *_viewControllers;
	NSUInteger _selectedIndex;
	
	BOOL _tabBarTransparent;
	BOOL _tabBarHidden;
    
    NSInteger animateDriect;
}

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

@end


@protocol LeveyTabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(LeveyTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(LeveyTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
@end

// 重绘本视图协议
@protocol RedrawLevyTabBarControllerDelegate <NSObject>
@optional
- (void)reDraw;
@end

@interface UIViewController (LeveyTabBarControllerSupport)
@property(nonatomic, readonly) LeveyTabBarController *leveyTabBarController;
@end

