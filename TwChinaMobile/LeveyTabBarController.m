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
#import "CustomNavBar.h"
#import "constant.h"
#import "GlobalData.h"
#import "LiuLiangView.h"
#import "CategoryDetailViewController.h"

#define kTagLiuliangView 2000

static LeveyTabBarController *leveyTabBarController;

@implementation UIViewController (LeveyTabBarControllerSupport)

- (LeveyTabBarController *)leveyTabBarController
{
	return leveyTabBarController;
}

@end

//@interface LeveyTabBarController()
//- (void)displayViewAtIndex;
//@end

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
        // 从实际效果来看，self.view 的自身坐标y起始于状态栏加导航栏的高度，所以 _containerView 的y坐标需要为0
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, g_screenWidth, g_screenHeight-kStatusBarHeight-kNavBarHeight)];
        _containerView.backgroundColor = [UIColor whiteColor];
        
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
        [_containerView addSubview:_tabBar];
        
        // 添加滚动主视图
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, g_screenWidth, g_screenHeight - kTabBarHeight*2 - kStatusBarHeight)];
        //向 ScrollView 中加入第一个 View，View 的宽度 200 加上两边的空隙 5 等于 ScrollView 的宽度
        UIView *view1 = [[LiuLiangView alloc] initWithFrame:CGRectMake(0,0,320,g_screenHeight - kTabBarHeight*2 - kStatusBarHeight) parentVC:self];
        //view1.backgroundColor = [UIColor redColor];
        view1.tag = kTagLiuliangView;
        [_scrollView addSubview:view1];
        
        //第二个 View，它的宽度加上两边的空隙 5 等于 ScrollView 的宽度，两个 View 间有 10 的间距
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(325,5,310,g_screenHeight - kTabBarHeight*2 - kStatusBarHeight - 10)];
        view2.backgroundColor = [UIColor greenColor];
        [_scrollView addSubview:view2];
        
        //第三个 View
        UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(645,5,310,g_screenHeight - kTabBarHeight*2 - kStatusBarHeight - 10)];
        view3.backgroundColor = [UIColor blueColor];
        [_scrollView addSubview:view3];
        
        //第4个 View
        UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(965,5,310,g_screenHeight - kTabBarHeight*2 - kStatusBarHeight - 10)];
        view4.backgroundColor = [UIColor grayColor];
        [_scrollView addSubview:view4];
        
        //高度上与 ScrollView 相同，只在横向扩展，所以只要在横向上滚动
        _scrollView.contentSize = CGSizeMake(1280, (g_screenHeight - kTabBarHeight*2 - kStatusBarHeight) * 2);
        
        //用它指定 ScrollView 中内容的当前位置，即相对于 ScrollView 的左上顶点的偏移
        _scrollView.contentOffset = CGPointMake(0, 0);
        
        //按页滚动，总是一次一个宽度，或一个高度单位的滚动
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        _scrollView.delegate = self;
        
        // 测试 UIScrollView 禁止下拉功能。好使，可在不需要下拉的 offset 处进行该设置
        //_scrollView.bounces = NO;
        
        [_containerView addSubview:_scrollView];
        
        // 添加下拉刷新功能
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - _scrollView.bounds.size.height, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        [_scrollView addSubview:_refreshHeaderView];
		
        leveyTabBarController = self;
	}
	return self;
}

/*
- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr
{
	self = [super init];
	if (self != nil)
	{
		_viewControllers = [NSMutableArray arrayWithArray:vcs];
		
		_containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _containerView.backgroundColor = [UIColor whiteColor];
        
        // 自定义导航栏(高度暂定与 tabbar 一致)
        _navBar = [[CustomNavBar alloc] initWithFrame:CGRectMake(0, g_applicationFrame.origin.y, g_applicationFrame.size.width, kTabBarHeight) ];
        _navBar.delegate = self;
    
        _transitionView = [[UIView alloc] initWithFrame:g_windowsBounds];
        _transitionView.backgroundColor =  [UIColor greenColor]; // 为了便于区分该视图，暂用绿色，显示一点
		
        // 自定义tabbar
		_tabBar = [[LeveyTabBar alloc] initWithFrame:CGRectMake(0, _containerView.frame.size.height - kTabBarHeight, g_applicationFrame.size.width, kTabBarHeight) buttonImages:arr];
		_tabBar.delegate = self;
		
        leveyTabBarController = self;
        animateDriect = 0;
	}
	return self;
}*/

//- (void)loadView 
//{
//	[super loadView];
//	
//    //[_containerView addSubview:_navBar];
//	//[_containerView addSubview:_transitionView];
//	//[_containerView addSubview:_tabBar];
//	//self.view = _containerView;
//}

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
    
    // 从实际效果来看，self.view 的自身坐标y起始于状态栏加导航栏的高度
    [self.view addSubview:_containerView];
    
    // 1. 自定义导航栏
    // 1.1 左侧
    // logo
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (kTabBarHeight -  kLogoHeight) / 2, kLogoWidth, kLogoHeight)];
    [logoView setImage:[UIImage imageNamed:@"logo.png"]];
    //self.logoView.frame = CGRectMake(kLogoInset, (kTabBarHeight -  kLogoHeight) / 2, kLogoWidth, kLogoHeight);
    
    // 账号
    // 传统方式
    NSString *phoneNumber = [[GlobalData sharedSingleton] account];
    UIFont *font =[UIFont systemFontOfSize:18];
    // 属性字符串方式
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:phoneNumber];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [str length])];
    [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [str length])];
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.attributedText = str;
    accountLabel.frame = CGRectMake(kLogoWidth + kLogoInset, (kTabBarHeight - str.size.height) / 2 , str.size.width, str.size.height);
    
    // 将logo和用户号码标签拼起来作为导航条的左侧按钮视图
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, logoView.frame.size.width + accountLabel.frame.size.width, kNavBarHeight)];
    [leftView addSubview:logoView];
    [leftView addSubview:accountLabel];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftItem;

    // 1.2 右侧
    // 通话按钮
    CGRect frame = CGRectMake(0, 0, kCommBtnWeight, kCommBtnHeight);
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_comm.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navCommButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
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

- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - tabbar operation

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

//-(void)setSelectedIndex:(NSUInteger)index
//{
//    [self displayViewAtIndex:index];
//    [_tabBar selectTabAtIndex:index];
//}

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
        //[self.view bringSubviewToFront:_navBar];
        [self.view bringSubviewToFront:_tabBar];
    }
    
}


#pragma mark - Private methods
//- (void)displayViewAtIndex
//{
//}

#pragma mark -
#pragma mark tabBar delegates
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index
{
    _scrollView.contentOffset = CGPointMake(index*g_screenWidth, 0);
}

// 自定义导航条的协议实现
- (void)navCommButtonClicked:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"tip" message:@"疯狂开发中..." delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil];
    [alert show];
    
    // 测试刷新主视图内容
    //NSString *upadteTime = [[GlobalData sharedSingleton] lastQueryTime];
    //LiuLiangView *view1 = (LiuLiangView *)[_containerView viewWithTag:kTagLiuliangView];
    //[view1 reloadData];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [_containerView setNeedsDisplay];
//    });
    //[self.view setNeedsDisplay];
        
        // 测试视图切换
        CategoryDetailViewController *loginController=[[CategoryDetailViewController alloc]init];
        loginController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        //调用此方法显示模态窗口
        [self presentViewController:loginController animated:YES completion:nil];
}

- (NSInteger)numberOfPages
{
    return 5;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UILabel *l = [[UILabel alloc] initWithFrame:self.view.bounds];
    l.text = [NSString stringWithFormat:@"%d", (int)index];
    l.font = [UIFont systemFontOfSize:72];
    l.backgroundColor = [UIColor clearColor];
    return l;
}

#pragma switch view controllers
- (void)switchToCategoryDetails:(int)index
{
    //NSLog(@"switch to category details");
    CategoryDetailViewController *cagegoryDetailVC = [[CategoryDetailViewController alloc] init];
    [cagegoryDetailVC setCurPage:index];
    [self.navigationController pushViewController:cagegoryDetailVC animated:YES];
    
    // 修改导航条信息
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Method
- (void)reloadTableViewDataSource{
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _reloading = YES;
    
    // 模拟更新数据
    [[GlobalData sharedSingleton] testUpdateData];
    
    // 用http方式重新加载数据
}

- (void)doneLoadingTableViewData{
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_scrollView];
    
    LiuLiangView *view1 = (LiuLiangView *)[_containerView viewWithTag:kTagLiuliangView];
    [view1 reloadData];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    // 加载数据操作，待数据加载成功或超时后通知EGO
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:.5];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date]; // should return date data source was last changed
}

@end
