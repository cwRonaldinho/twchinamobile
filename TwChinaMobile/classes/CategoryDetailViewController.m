//
//  CategoryDetailViewController.m
//  TwChinaMobile
//
//  Created by tw on 15-3-10.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "CategoryDetailViewController.h"
#import "GlobalData.h"

@interface CategoryDetailViewController ()

@end

@implementation CategoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    // 模拟在此处修改全局数据，如查询时间，进而观察主页面中的数据是否会更新
    [[GlobalData sharedSingleton] setLastQueryTime:@"123"];
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
