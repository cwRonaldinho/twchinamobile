//
//  ValidPackagesViewController.m
//  TwChinaMobile
//
//  Created by tw on 15-4-8.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "ValidPackagesViewController.h"
#import "GCArraySectionController.h"

#define kInsetMainViewHV 8.0f             // 主视图区到两边及上面元素的距离
#define kInsetVerticalItems 16.0f
#define kHeightCell             40

@interface ValidPackagesViewController ()

@property (nonatomic, strong) UITableView *myTableView2;

@property (nonatomic, strong) NSArray* retractableControllers;
@end

@implementation ValidPackagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = gkColorBackgrondGray;
    
    // 1. 查询时间
    NSString *queryTime = [NSString stringWithFormat:@"查询时间:%@", [[GlobalData sharedSingleton] lastQueryTime]];
    UILabel *labelQueryTime = [queryTime createFontedLabel:gkFontSmall];
    labelQueryTime.textColor = gkColorDarkGray;
    labelQueryTime.center = CGPointMake(self.view.frame.size.width/2, kInsetVerticalItems + labelQueryTime.frame.size.height/2);
    [self.view addSubview:labelQueryTime];
    
    //
    GCArraySectionController* arrayController = [[GCArraySectionController alloc]
                                                 initWithArray:[GlobalData sharedSingleton].subscribedPackeges
                                                 viewController:self];
    self.retractableControllers = [NSArray arrayWithObjects:arrayController, nil];
    
    _myTableView2 = [[UITableView alloc] initWithFrame:CGRectMake(kInsetMainViewHV, [labelQueryTime getBottomY] + kInsetVerticalItems, self.view.frame.size.width - 2*kInsetMainViewHV, ([arrayController numberOfRow] + 1) * kHeightCell) style:UITableViewStyleGrouped];
    TRACE_RECT(_myTableView2.frame);
    _myTableView2.delegate = self;
    _myTableView2.dataSource = self;
    _myTableView2.layer.cornerRadius = gkCornerRadius;
    _myTableView2.layer.masksToBounds = YES;
    [_myTableView2 setSeparatorInset:UIEdgeInsetsZero];
    [_myTableView2 setLayoutMargins:UIEdgeInsetsZero];
    [self.view addSubview:_myTableView2];}

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

//
- (UITableView*) tableView {
    return _myTableView2;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:section];
    return sectionController.numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController cellForRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController didSelectCellAtRow:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeightCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*@interface ValidPackagesTableView ()
@property (nonatomic, strong) NSArray* retractableControllers;
@property (nonatomic, strong) UIViewController* parent;
@end

@implementation ValidPackagesTableView
- (instancetype)initWithFrame:(CGRect)frame parentVC:(UIViewController *)parent
{
    if (self = [super initWithFrame:frame style:UITableViewStylePlain]) {
        _parent = parent;
        GCArraySectionController* arrayController = [[GCArraySectionController alloc]
                                                     initWithArray:[NSArray arrayWithObjects:@"网聊11元套餐", @"新30元流量包", nil]
                                                     viewController:parent];
        self.retractableControllers = [NSArray arrayWithObjects:arrayController, nil];
        
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:section];
    return sectionController.numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController cellForRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController didSelectCellAtRow:indexPath.row];
}

@end*/
