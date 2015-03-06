//
//  CustomTabBarViewController.m
//  TwChinaMobile
//
//  Created by tw on 15-2-12.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "CustomTabBarViewController.h"
#include "constant.h"
#import "GXCustomButton.h"

@interface CustomTabBarViewController ()
    
@end

@implementation CustomTabBarViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (id)initWithImageArray:(NSArray *)arr
{
	self = [super init];
	if (self != nil)
	{
        _myTabBar = [[LeveyTabBar alloc] initWithFrame:CGRectMake(0, g_windowsBounds.size.height - kTabBarHeight, g_applicationFrame.size.width, kTabBarHeight) buttonImages:arr];
        _myTabBar.delegate = self;
        
        [self.view addSubview:_myTabBar];
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBar.hidden = YES; //隐藏原先的tabBar
    //CGFloat tabBarViewY = self.view.frame.size.height - kStatusBarHeight;
    
//    _tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, tabBarViewY, g_applicationFrame.size.width, kStatusBarHeight)];
//    _tabBarView.userInteractionEnabled = YES; //这一步一定要设置为YES，否则不能和用户交互
//    //_tabBarView.image = [UIImage imageNamed:@"changeui.png"];
//    
//    [self.view addSubview:_tabBarView];
    
    // 下面的方法是调用自定义的生成按钮的方法，图片在上文字在下的方法
//    [self creatButtonWithNormalName:@"flow_normal.png" andSelectName:@"flow_active.png" andTitle:@"消息" andIndex:0];
//    [self creatButtonWithNormalName:@"flow_normal.png" andSelectName:@"flow_active.png" andTitle:@"消息" andIndex:1];
//    [self creatButtonWithNormalName:@"flow_normal.png" andSelectName:@"flow_active.png" andTitle:@"消息" andIndex:2];
//    [self creatButtonWithNormalName:@"flow_normal.png" andSelectName:@"flow_active.png" andTitle:@"消息" andIndex:3];
    
    // 添加按钮
    
    //[self changeViewController:btn]; //自定义的控件中的按钮被点击了调用的方法，默认进入界面就选中第一个按钮
    
    //[self.view addSubview:_tabBarView];
}

#pragma mark 创建一个按钮
- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index
{
    /*
     GXCustomButton是自定义的一个继承自UIButton的类，自定义该类的目的是因为系统自带的Button可以设置image和title属性，但是默认的image是在title的左边，若想想上面图片中那样，将image放在title的上面，就需要自定义Button，设置一些东西。（具体GXCustomButton设置了什么，放在下面讲）
     */
    
//    GXCustomButton *button = [GXCustomButton buttonWithType:UIButtonTypeCustom];
//    button.tag = index;
//    
//    
//    CGFloat buttonW = _tabBarView.frame.size.width / 4;
//    CGFloat buttonH = _tabBarView.frame.size.height;
//    button.frame = CGRectMake(80 *index, 0, buttonW, buttonH);
//    
//    
//    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
//    [button setTitle:title forState:UIControlStateNormal];
//    
//    
//    [button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
//    
//    button.imageView.contentMode = UIViewContentModeCenter; // 让图片在按钮内居中
//    button.titleLabel.textAlignment = NSTextAlignmentCenter; // 让标题在按钮内居中
//    button.font = [UIFont systemFontOfSize:12]; // 设置标题的字体大小
//    
//    [_tabBarView addSubview:button];
    
}



#pragma mark 按钮被点击时调用
- (void)changeViewController:(GXCustomButton *)sender
{
    self.selectedIndex = sender.tag; //切换不同控制器的界面
    
    sender.enabled = NO;
    
    if (_previousBtn != sender) {
        
        _previousBtn.enabled = YES;
        
    }
    
    _previousBtn = sender;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
