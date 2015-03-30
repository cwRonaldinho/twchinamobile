//
//  MyNavViewController.m
//  TwChinaMobile
//
//  Created by tw on 15-3-10.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIImage+UIImageExt.h"
#import "constant.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //取消导航栏的透明效果
    //self.navigationBar.translucent = NO;
    
    //设置导航栏的样式(样式效果参见 http://my.oschina.net/hmj/blog/103332)
    //self.navigationBar.barStyle = UIBarStyleBlack;
    
    //设置导航栏的背景图片 TODO:
    UIImage *image = [UIImage imageNamed:@"title1_bg.png"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    /*
    // 经测试，直接在 UINavgationController 的子类中设置 baritem 及 背景色 属性无效，但可以设置 bar 的背景色，原因不明，先绕过
    // 自定义右侧按钮
    // 通话按钮
    CGRect frame = CGRectMake(0, 0, kCommBtnWeight, kCommBtnHeight);
    //CGRect frame = CGRectMake(0, 0, 54, 30);
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_comm.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navCommButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationController.navigationItem.rightBarButtonItem = rightItem;
    self.navigationBar.backgroundColor = [UIColor purpleColor];
     */
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

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

// 没效果??
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationPortraitUpsideDown;
//}

@end
