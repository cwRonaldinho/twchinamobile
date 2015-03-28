//
//  CategoryDetailViewController.m
//  TwChinaMobile
//
//  Created by tw on 15-3-10.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "CategoryDetailViewController.h"
#import "GlobalData.h"
#import "CategoryDetailView.h"
#import "constant.h"
#import "GlobalData.h"

@interface CategoryDetailViewController ()

@end

@implementation CategoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, g_screenWidth, g_screenHeight - kTabBarHeight - kStatusBarHeight)];
    _scrollView.contentSize = CGSizeMake(g_screenWidth * 4, g_screenHeight - kTabBarHeight - kStatusBarHeight);
    _scrollView.contentOffset = CGPointMake(0, 0);
    
    NSArray *arrayTitle = [NSArray arrayWithObjects:@"国内通用流量", @"本地通用流量", @"本地4G流量", @"本地闲时流量", nil];
    NSArray *arrayMainImageName = [NSArray arrayWithObjects:@"flowquerytypedetailbigpicchn.png", @"flowquerytypedetailbigpiclocal.png", @"flowquerytypedetailbigpic4g.png", @"flowquerytypedetailbigpicfree.png", nil];
    NSArray *arrayDesp = [NSArray arrayWithObjects:@"在2G/3G/4G网络、全时段、国内均通用", @"在2G/3G/4G网络、全时段、北京本地使用", @"在4G网络、夜间闲时(每日23:00至次日7:00)、北京本地使用", @"在2G/3G/4G网络、全时段、国内均通用", nil];
    NSArray *arrayAreaTime1 = [NSArray arrayWithObjects:@"flowquerytypechpic1.png", @"flowquerytypechpic2.png", @"flowquerytypechpic3.png", nil];
    NSArray *arrayAreaTime2 = [NSArray arrayWithObjects:@"flowquerytypechpic1.png", @"flowquerytypechpic2.png", @"flowquerytypechpic4.png", nil];
    NSArray *arrayAreaTime3 = [NSArray arrayWithObjects:@"flowquerytypechpic5.png", @"flowquerytypechpic2.png", @"flowquerytypechpic4.png", nil];
    NSArray *arrayAreaTime4 = [NSArray arrayWithObjects:@"flowquerytypechpic1.png", @"flowquerytypechpic6.png", @"flowquerytypechpic4.png", nil];
    NSArray *arrayDetailImageName = [NSArray arrayWithObjects:arrayAreaTime1, arrayAreaTime2, arrayAreaTime3, arrayAreaTime4, nil];
    
    GlobalData *gdata = [GlobalData sharedSingleton];
    unsigned int arrayTotal[] = {gdata.internalTotalFlow, gdata.localTotalFlow, gdata.local4GTotalFlow, gdata.localIdleTotalFlow};
    unsigned int arrayRemain[] = {gdata.internalRemainFlow, gdata.localRemainFlow, gdata.local4GRemainFlow, gdata.localIdleRemainFlow};
    
    for (int i = 0; i < 4; i++) {
        CategoryDetailView *view1 = [[CategoryDetailView alloc] initWithFrame:CGRectMake(g_screenWidth * i, 0, g_screenWidth, g_screenHeight - kTabBarHeight - kStatusBarHeight)];
        view1.title = [arrayTitle objectAtIndex:i];
        view1.mainImageName = [arrayMainImageName objectAtIndex:i];
        view1.desp = [arrayDesp objectAtIndex:i];
        view1.arrayDetailImageName = [arrayDetailImageName objectAtIndex:i];
        view1.total  = arrayTotal[i];
        view1.remain = arrayRemain[i];
        view1.queryTime = [[GlobalData sharedSingleton] lastQueryTime];
        [view1 loadItems];
        [_scrollView addSubview:view1];
    }
    
    _scrollView.pagingEnabled = YES; // 按页滚动，总是一次一个宽度，或一个高度单位的滚动
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;

    [self.view addSubview:_scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
