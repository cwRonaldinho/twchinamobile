//
//  LeveyTabBarControllerViewController.m
//  LeveyTabBarController
//
//  Created by zhang on 12-10-10.
//  Copyright (c) 2012年 jclt. All rights reserved.
//
//

#import "LeveyTabBarController.h"
#import "LeveyTabBar.h"
#include "CustomNavBar.h"
#include "constant.h"
#import "LiuLiangView.h"

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
@synthesize animateDriect;

#pragma mark -
#pragma mark lifecycle
- (id)init
{
	self = [super init];
	if (self != nil)
	{
		_containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _containerView.backgroundColor = [UIColor whiteColor];
        
        // 导航栏(高度暂定与 tabbar 一致)
        _navBar = [[CustomNavBar alloc] initWithFrame:CGRectMake(0, g_applicationFrame.origin.y, g_applicationFrame.size.width, kTabBarHeight) ];
        _navBar.delegate = self;
        
        // tabbar 各按钮对应图片
        NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic setObject:[UIImage imageNamed:@"flow_normal.png"] forKey:@"Default"];
        [imgDic setObject:[UIImage imageNamed:@"flow_active.png"] forKey:@"Highlighted"];
        [imgDic setObject:[UIImage imageNamed:@"flow_active.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic2 setObject:[UIImage imageNamed:@"serve_normal.png"] forKey:@"Default"];
        [imgDic2 setObject:[UIImage imageNamed:@"serve_active.png"] forKey:@"Highlighted"];
        [imgDic2 setObject:[UIImage imageNamed:@"serve_active.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic3 setObject:[UIImage imageNamed:@"discover_normal.png"] forKey:@"Default"];
        [imgDic3 setObject:[UIImage imageNamed:@"discover_active.png"] forKey:@"Highlighted"];
        [imgDic3 setObject:[UIImage imageNamed:@"discover_active.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic4 setObject:[UIImage imageNamed:@"setup_normal.png"] forKey:@"Default"];
        [imgDic4 setObject:[UIImage imageNamed:@"setup_active.png"] forKey:@"Highlighted"];
        [imgDic4 setObject:[UIImage imageNamed:@"setup_active.png"] forKey:@"Seleted"];
        
        NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,nil];
        
        // tabbar
		_tabBar = [[LeveyTabBar alloc] initWithFrame:CGRectMake(0, _containerView.frame.size.height - kTabBarHeight, g_applicationFrame.size.width, kTabBarHeight) buttonImages:imgArr];
		_tabBar.delegate = self;
        
        // 添加滚动主视图
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTabBarHeight+kStatusBarHeight, g_windowsBounds.size.width, g_windowsBounds.size.height - kTabBarHeight*2 - kStatusBarHeight)];
        //向 ScrollView 中加入第一个 View，View 的宽度 200 加上两边的空隙 5 等于 ScrollView 的宽度
        UIView *view1 = [[LiuLiangView alloc] initWithFrame:CGRectMake(0,0,320,g_windowsBounds.size.height - kTabBarHeight*2 - kStatusBarHeight)];
        //view1.backgroundColor = [UIColor redColor];
        [_scrollView addSubview:view1];
        
        //第二个 View，它的宽度加上两边的空隙 5 等于 ScrollView 的宽度，两个 View 间有 10 的间距
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(325,5,310,g_windowsBounds.size.height - kTabBarHeight*2 - kStatusBarHeight - 10)];
        view2.backgroundColor = [UIColor greenColor];
        [_scrollView addSubview:view2];
        
        //第三个 View
        UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(645,5,310,g_windowsBounds.size.height - kTabBarHeight*2 - kStatusBarHeight - 10)];
        view3.backgroundColor = [UIColor blueColor];
        [_scrollView addSubview:view3];
        
        //第4个 View
        UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(965,5,310,g_windowsBounds.size.height - kTabBarHeight*2 - kStatusBarHeight - 10)];
        view4.backgroundColor = [UIColor grayColor];
        [_scrollView addSubview:view4];
        
        //高度上与 ScrollView 相同，只在横向扩展，所以只要在横向上滚动
        _scrollView.contentSize = CGSizeMake(1280, g_windowsBounds.size.height - kTabBarHeight*2 - kStatusBarHeight);
        
        //用它指定 ScrollView 中内容的当前位置，即相对于 ScrollView 的左上顶点的偏移
        _scrollView.contentOffset = CGPointMake(0, 0);
        
        //按页滚动，总是一次一个宽度，或一个高度单位的滚动
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        _scrollView.delegate = self;
        
        [_containerView addSubview:_scrollView];
		
        leveyTabBarController = self;
        //animateDriect = 0;
	}
	return self;
}

- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr
{
	self = [super init];
	if (self != nil)
	{
		_viewControllers = [NSMutableArray arrayWithArray:vcs];
		
		_containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _containerView.backgroundColor = [UIColor whiteColor];
        
//        CGRect tmpCR = _containerView.frame;
//        NSLog(@"init");
//        NSLog(@"container: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
        
        // 导航栏(高度暂定与 tabbar 一致)
        _navBar = [[CustomNavBar alloc] initWithFrame:CGRectMake(0, g_applicationFrame.origin.y, g_applicationFrame.size.width, kTabBarHeight) ];
        _navBar.delegate = self;
        
//        tmpCR = _navBar.frame;
//        NSLog(@"navbar: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
		
		//_transitionView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight + _navBar.frame.size.height, g_applicationFrame.size.width, _containerView.frame.size.height - kTabBarHeight - kTabBarHeight - kStatusBarHeight)]; // transitionView如果做成现在这种只有中间部分的尺寸，在 addSubView 里，坐标系比较乱
        // 尝试 transitionView 使用屏幕全尺寸的效果
        _transitionView = [[UIView alloc] initWithFrame:g_windowsBounds];
        _transitionView.backgroundColor =  [UIColor greenColor]; // 为了便于区分该视图，暂用绿色，显示一点
        
//        tmpCR = _transitionView.frame;
//        NSLog(@"transition view: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
		
        // tabbar
		_tabBar = [[LeveyTabBar alloc] initWithFrame:CGRectMake(0, _containerView.frame.size.height - kTabBarHeight, g_applicationFrame.size.width, kTabBarHeight) buttonImages:arr];
		_tabBar.delegate = self;
        
//        tmpCR = _tabBar.frame;
//        NSLog(@"_tabBar: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
		
        leveyTabBarController = self;
        animateDriect = 0;
	}
	return self;
}

- (void)loadView 
{
	[super loadView];
	
    [_containerView addSubview:_navBar];
	//[_containerView addSubview:_transitionView];
	[_containerView addSubview:_tabBar];
	self.view = _containerView;
    
    CGRect tmpCR = _containerView.frame;
//    NSLog(@"load view");
//    NSLog(@"container: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
    
    tmpCR = _navBar.frame;
//    NSLog(@"navbar: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
    
    tmpCR = _transitionView.frame;
//    NSLog(@"transition view: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
    
    tmpCR = _tabBar.frame;
//    NSLog(@"container: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
}

// 当子vc中出现视图切换，再切换回来的时候，需要在此处将 tabbar 和 statusbar 置顶显示
//- (void)viewWillAppear:(BOOL)animated
//{
//    // 需要通知父视图恢复控件
//    NSLog(@"custom tab bar viewWillAppear");
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.selectedIndex = 0;
    
    CGRect tmpCR = _containerView.frame;
    NSLog(@"viewDidLoad");
//    NSLog(@"container: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
    
    tmpCR = _navBar.frame;
//    NSLog(@"navbar: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
    
    tmpCR = _transitionView.frame;
//    NSLog(@"transition view: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
    
    tmpCR = _tabBar.frame;
//    NSLog(@"container: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
	_tabBar = nil;
	_viewControllers = nil;
}

- (void)dealloc 
{
    _tabBar.delegate = nil;
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
    CGRect tmpCR = _transitionView.frame;
    NSLog(@"transition view1: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
    
	if (yesOrNo == YES)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		_transitionView.frame = CGRectMake(0, 0, g_applicationFrame.size.width, _containerView.frame.size.height - kTabBarHeight);
	}
    
    tmpCR = _transitionView.frame;
    NSLog(@"transition view2: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
}




- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated
{
	if (yesOrNO == YES)
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height)
		{
			return;
		}
	}
	else 
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height - kTabBarHeight)
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

- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    [_viewControllers insertObject:vc atIndex:index];
    [_tabBar insertTabWithImageDic:dict atIndex:index];
}

// 设置 navbar 及 tabbar 的显示与否
- (void)hideBars:(BOOL)yesOrNo
{
    if (yesOrNo) {
        [self.view bringSubviewToFront:_transitionView];
    }
    else
    {
        [self.view bringSubviewToFront:_navBar];
        [self.view bringSubviewToFront:_tabBar];
    }
    
}


#pragma mark - Private methods
- (void)displayViewAtIndex:(NSUInteger)index
{
    // Before change index, ask the delegate should change the index.
    if ([_delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) 
    {
        if (![_delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
        {
            return;
        }
    }
    // If target index if equal to current index, do nothing.
    if (_selectedIndex == index && [[_transitionView subviews] count] != 0) 
    {
        return;
    }
    NSLog(@"Display View.");
    _selectedIndex = index;
    
	UIViewController *selectedVC = [self.viewControllers objectAtIndex:index];
	
    CGRect tmpCR = selectedVC.view.frame;
    //NSLog(@"selected view: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
    
	selectedVC.view.frame = _transitionView.frame;
    
    tmpCR = selectedVC.view.frame;
    //NSLog(@"selected view: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
    //selectedVC.view.frame = CGRectMake(0, 0, _transitionView.frame.size.width, _transitionView.frame.size.height);
	if ([selectedVC.view isDescendantOfView:_transitionView]) 
	{
		[_transitionView bringSubviewToFront:selectedVC.view];
	}
	else
	{
		[_transitionView addSubview:selectedVC.view];
        
        CGRect crT1 = selectedVC.view.frame;
        crT1 = selectedVC.view.bounds;
	}
    
    tmpCR = selectedVC.view.frame;
    //NSLog(@"selected view: \n(%f, %f, %f, %f)", tmpCR.origin.x, tmpCR.origin.y,tmpCR.size.width, tmpCR.size.height);
    
    // Notify the delegate, the viewcontroller has been changed.
//    if ([_delegate respondsToSelector:@selector(tabBarController:didSelectViewController::)]) 
//    {
//        [_delegate tabBarController:self didSelectViewController:selectedVC];
//    }

}

#pragma mark -
#pragma mark tabBar delegates
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index
{
	if (self.selectedIndex == index) {
//        UINavigationController *nav = [self.viewControllers objectAtIndex:index];
//        [nav popToRootViewControllerAnimated:YES];
    }else {
        //[self displayViewAtIndex:index];
        //_scrollView.contentOffset = CGPointMake(index*g_windowsBounds.size.width, 0);
    }
    _scrollView.contentOffset = CGPointMake(index*g_windowsBounds.size.width, 0);
}

// 自定义导航条的协议实现
- (void)navBar:(CustomNavBar *)navBar didClickButton:(NSInteger)index
{
    if (kCommBtnTag == index) {
        NSLog(@"comm button clicked");
        
        // 测试视图切换
//        SwapViewTestVC2 *loginController=[[SwapViewTestVC2 alloc]init];
//        loginController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//        //调用此方法显示模态窗口
//        [self presentViewController:loginController animated:YES completion:nil];
    }
}

- (NSInteger)numberOfPages
{
    return 5;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UILabel *l = [[UILabel alloc] initWithFrame:self.view.bounds];
    l.text = [NSString stringWithFormat:@"%d",index];
    l.font = [UIFont systemFontOfSize:72];
    l.backgroundColor = [UIColor clearColor];
    return l;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:[NSString stringWithFormat:@"当前点击第%d个页面",index]
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

@end