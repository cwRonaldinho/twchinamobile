//
//  BaseViewController.m
//  MyMovie
//
//  Created by zsm on 14-8-15.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
        //self.hiddenTabBar = YES;
        self.isBackButton = NO;     // 默认无后退按钮
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.ßß
   
    [self.navigationController.navigationBar
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        [UIColor  orangeColor], UITextAttributeTextColor,
                                                                     nil]];
    if (_isBackButton == YES) {
        //初始化返回按钮
        [self _initBackItem];
    }
    
//    MainTabBarController * mainTabBar  = [MainTabBarController sharaMainTabBar];
//    mainTabBar.hiddenTabBar = self.hiddenTabBar;
    
}

//初始化返回按钮
- (void)_initBackItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 13, 21);
    //设置标题图片
    [backButton setBackgroundImage:[UIImage imageNamed:@"btn_back_m(2).png"] forState:UIControlStateNormal];
    //添加事件
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    //创建导航按钮
    UIBarButtonItem *leftBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    
    
    //设置到导航控制器上去显示
    self.navigationItem.leftBarButtonItem =             leftBarButtonItem1;
}

#pragma mark - Back Action
- (void)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (BOOL)shouldAutorotate
{
    NSLog(@"让不让我旋转?");
    return NO;
}

@end
