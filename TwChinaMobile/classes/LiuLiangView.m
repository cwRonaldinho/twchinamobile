//
//  LiuLiangView.m
//  TwChinaMobile
//
//  Created by tw on 15-3-3.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "LiuLiangView.h"
#import "constant.h"
#import "GlobalData.h"
#import "LeveyTabBarController.h"
#import "NSString+NSStringExt.h"
#import "BackCircleView.h"

// 控件 tag 值定义
#define kTagLabelQueryTime              1100
#define kTagLabelTotalFlow                 1101
#define kTagLabelTotalUsedFlow         1102
#define kTagLabelTotalRemainFlow     1103
#define kTagLabelTotalRemainRation  1104
#define kTagLabelInternalFlow            1105
#define kTagLabelLocalFlow                1106
#define kTagLabelLocal4G                   1107
#define kTagLabelLocalIdle                 1108
#define kTagViewBackCircle                1109
#define kTagLabelRationRemain         1110
#define kTagLabelTotalRemainAmount 1111
#define kTagImageViewTotalRemain                1112
#define kTagBtnDetailsBase                  1200

// 流量界面相关定义
#define kInsetMainViewHV 8.0f             // 主视图区到两边及上面元素的距离
#define kMainViewHeight 300.0f       // 主视图高度
#define kMainViewButtonDistance 8.0f        // 主视图上下部分间距离
#define kInsetHorizontalTotalInfo 10      // 套餐总量标签距左边框距离，本月已用标签距右边框距离
#define kInsetTopTotalInfo 140      // 套餐总量标签/本月已用标签距上边框距离
#define kWidthBackCircle 180        // 背景环宽度
#define kHeightBackCircle 180       // 背景环高度
#define kInsetTopBackCircle 24      // 背景环距顶部距离
#define kFuncButtonDistance 4.0f    // 功能按钮之间间隔，通过该值能计算出功能按钮的宽度，如高度和宽度相同，则高度也通过该值计算即可
//#define kFuncButtonBottomInset 40.0f    // 功能按钮与下面元素距离
#define kLabelLeftFlowRightInset 32.0f       // 剩余流量标签距离右边元素的距离
#define kLabelLeftFlowVerticalInset 4.0f        // 剩余流量标签距离上下元素的距离
#define kLabelLeftFlowKeyValueDistance 2.0f    // 剩余流量名标签与流量值标签的距离
#define kHeightRemainFlowCell 46.0f          // 剩余流量信息行高度

#define kHorizontalDividerLineHeight 1.0f           // 水平分隔线高度
#define kVerticalDividerLineWidth 1.0f                      // 垂直分隔线宽度
#define kVerticalDividerLineVerticalInset 8.0f          // 垂直分隔线距离上下元素距离

// 字体定义
#define kFontTotalInfoValue [UIFont systemFontOfSize:15]  // 总量数字字体
#define kFontM [UIFont systemFontOfSize:11]                     // 单位m 字体
#define kFontValuePrefix [UIFont fontWithName:@"HelveticaNeue" size:11]         // 流量值前缀字体
#define kFontDetailValue [UIFont systemFontOfSize:13]                                                   // 流量值字体
#define kColorRemainValue [UIColor colorWithRed:65.0/255 green:197.0/255 blue:77.0/255 alpha:1.0]
#define kColorTotalValue [UIColor colorWithRed:251.0/255 green:109.0/255 blue:160.0/255 alpha:1.0]

@interface LiuLiangView()
- (void) startAnimate;
@end

@implementation LiuLiangView

- (id)initWithFrame:(CGRect)frame parentVC:(LeveyTabBarController *)parent
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _parent = parent;
        self.backgroundColor = kColor_RGB(238.0);
        
        NSString *stringLabelText = @"";                    // label 的字符串
        NSMutableAttributedString *attrString;          // 属性字符串
        
        // 1. 主视图 圆角效果用按钮实现
        _mainView = [[UIButton alloc] initWithFrame:CGRectMake(kInsetMainViewHV, kInsetMainViewHV, g_applicationFrame.size.width - kInsetMainViewHV*2, kMainViewHeight)];
        [_mainView.layer setMasksToBounds:YES];
        [_mainView.layer setCornerRadius:10.0]; //设置矩圆角半径
        [_mainView.layer setBorderWidth:1.0];   //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 192.0/255, 192.0/255, 192.0/255, 1 });
        [_mainView.layer setBorderColor:colorref];//边框颜色
        _mainView.backgroundColor = [UIColor whiteColor];
        //[_mainView addSubview:btn];
        
        // 1.1 主视图背景
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flowbackgroundgreen.png"]];
        backgroundView.frame = CGRectMake(0, 0, g_applicationFrame.size.width - kInsetMainViewHV*2, kMainViewHeight-kHeightRemainFlowCell*2);   // 注意，背景视图是添加到 _mainView 中的，所以其 frame 值是相对于 _mainView 的坐标
        [_mainView addSubview:backgroundView];
        
        // 1.2 查询时间
        NSString *queryTime = [NSString stringWithFormat:@"查询时间:%@", [[GlobalData sharedSingleton] lastQueryTime]];
        UILabel *labelQueryTime = [queryTime createFontedLabel:[UIFont systemFontOfSize:10]];
        attrString = (NSMutableAttributedString *)labelQueryTime.attributedText;
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, [attrString length])];   // 设置字体颜色
        labelQueryTime.center = CGPointMake((g_screenWidth - kInsetMainViewHV * 2)/2, 10);        // 设置 center 坐标。因为每个 UILabel 的位置都不同，所以需要单独设置
        labelQueryTime.tag = kTagLabelQueryTime;
        [_mainView addSubview:labelQueryTime];
        
        // 1.3 总量信息
        UIFont *fontTotalKey = [UIFont systemFontOfSize:12]; // 总量信息名称字体
//        UIFont *fontTotalInfoValue = [UIFont systemFontOfSize:15];   // 总量数字字体
//        UIFont *fontM = [UIFont systemFontOfSize:11];                     // 单位m 字体
        
        // 1.3.1 套餐总量标题
        stringLabelText = @"套餐总量";
        UILabel *labelTotalFlow = [stringLabelText createFontedLabel:fontTotalKey];
        attrString = (NSMutableAttributedString *)labelTotalFlow.attributedText;
        labelTotalFlow.center = CGPointMake(kInsetHorizontalTotalInfo + attrString.size.width/2, kInsetTopTotalInfo + attrString.size.height/2);
        [_mainView addSubview:labelTotalFlow];
        // 1.3.1.1 套餐总量值
        stringLabelText = [NSString stringWithFormat:@"%dM", [[GlobalData sharedSingleton] totalFlow]];
        UILabel *labelTotalFlowValue = [stringLabelText createFontedLabel:kFontTotalInfoValue];
        attrString = (NSMutableAttributedString *)labelTotalFlowValue.attributedText;
        [attrString addAttribute:NSFontAttributeName value:kFontM range:NSMakeRange([[NSString stringWithFormat:@"%d", [[GlobalData sharedSingleton] totalFlow]] length], 1)]; // 注意：虽然重新设置了标签内容中包含多种字体，但标签的长度已经固定，所以在设置 center 时需要使用标签的宽度
        labelTotalFlowValue.center = CGPointMake(kInsetHorizontalTotalInfo + labelTotalFlowValue.frame.size.width/2, labelTotalFlow.frame.origin.y + labelTotalFlow.frame.size.height + attrString.size.height/2);
        labelTotalFlowValue.tag = kTagLabelTotalFlow;
        [_mainView addSubview:labelTotalFlowValue];
        
        // 1.3.2 本月已用标题
        stringLabelText = @"本月已用";
        UILabel *labelTotalUsed = [stringLabelText createFontedLabel:fontTotalKey];
        attrString = (NSMutableAttributedString *)labelTotalUsed.attributedText;
        labelTotalUsed.center = CGPointMake(g_screenWidth - kInsetMainViewHV*2 - attrString.size.width/2 - kInsetHorizontalTotalInfo, kInsetTopTotalInfo + attrString.size.height/2);
        [_mainView addSubview:labelTotalUsed];
        // 1.3.1.2 本月已用值
        stringLabelText = [NSString stringWithFormat:@"%dM", [[GlobalData sharedSingleton] totalUsedFlow]];
        UILabel *labelTotalUsedFlowValue = [stringLabelText createFontedLabel:kFontTotalInfoValue];
        attrString = (NSMutableAttributedString *)labelTotalUsedFlowValue.attributedText;
        [attrString addAttribute:NSFontAttributeName value:kFontM range:NSMakeRange([[NSString stringWithFormat:@"%d", [[GlobalData sharedSingleton] totalUsedFlow]] length], 1)]; // 注意：虽然重新设置了标签内容中包含多种字体，但标签的长度已经固定，所以在设置 center 时需要使用标签的宽度
        labelTotalUsedFlowValue.center = CGPointMake(g_screenWidth - kInsetMainViewHV*2 - labelTotalUsedFlowValue.frame.size.width/2 - kInsetHorizontalTotalInfo, labelTotalUsed.frame.origin.y + labelTotalUsed.frame.size.height + attrString.size.height/2);
        labelTotalUsedFlowValue.tag = kTagLabelTotalUsedFlow;
        [_mainView addSubview:labelTotalUsedFlowValue];
        
        // 1.4 动画背景
        UIImageView *imageViewBackCircle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flowbackcirgreen.png"]];
        imageViewBackCircle.frame = CGRectMake((g_screenWidth -kInsetMainViewHV*2 - kWidthBackCircle)/2, kInsetTopBackCircle, kWidthBackCircle, kHeightBackCircle);
        imageViewBackCircle.tag = kTagImageViewTotalRemain;
        [_mainView addSubview:imageViewBackCircle];
        [self startAnimate];
        
        // 1.4.1 剩余流量环
        BackCircleView *backCicleView = [[BackCircleView alloc] initWithFrame:CGRectMake(0, 0, imageViewBackCircle.bounds.size.width, imageViewBackCircle.bounds.size.height) totalAmount:[[GlobalData sharedSingleton] totalFlow]];
        backCicleView.backgroundColor = [UIColor clearColor];
        [backCicleView setCurAmount:[[GlobalData sharedSingleton] totalRemainFlow]];
        backCicleView.tag = kTagViewBackCircle;
        [imageViewBackCircle addSubview:backCicleView];
        
        // 1.4.2 剩余流量百分数
        // 1.4.2.1 标题
        NSString *title = @"月套餐剩余";
        UILabel *labelTotalTitle = [title createFontedLabel:[UIFont systemFontOfSize:15]];
        labelTotalTitle.center = CGPointMake(imageViewBackCircle.bounds.size.width / 2, 64);
        [imageViewBackCircle addSubview:labelTotalTitle];
        // 1.4.2.2 值
        NSString *rationRemain = @"100";
        UILabel *labelRationRemain = [rationRemain createFontedLabel:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30]];
        attrString = (NSMutableAttributedString *)labelRationRemain.attributedText;
        [attrString addAttribute:NSForegroundColorAttributeName value:kColorBackCircle range:NSMakeRange(0, 3)];
        labelRationRemain.center = CGPointMake(labelTotalTitle.frame.origin.x + labelRationRemain.frame.size.width/2, labelTotalTitle.frame.origin.y + labelTotalTitle.frame.size.height + labelRationRemain.frame.size.height/2);
        labelRationRemain.tag = kTagLabelRationRemain;
        [imageViewBackCircle addSubview:labelRationRemain];
        // 1.4.2.3 百分号
        NSString *ration = @"%";
        UILabel *labelRation = [ration createFontedLabel:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20]];
        attrString = (NSMutableAttributedString *)labelRation.attributedText;
        [attrString addAttribute:NSForegroundColorAttributeName value:kColorBackCircle range:NSMakeRange(0, [ration length])];
        labelRation.center = CGPointMake(labelRationRemain.frame.origin.x + labelRationRemain.frame.size.width + labelRation.frame.size.width/2, labelRationRemain.center.y);
        [imageViewBackCircle addSubview:labelRation];
        // 1.4.2.4 本月总剩余量标签
        title = @"本月剩余";
        UILabel *labelTotalRemainAmountTitle = [title createFontedLabel:[UIFont systemFontOfSize:10]];
        attrString = (NSMutableAttributedString *)labelTotalRemainAmountTitle.attributedText;
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [title length])];
        labelTotalRemainAmountTitle.center = CGPointMake(imageViewBackCircle.bounds.size.width / 2, 144);
        [imageViewBackCircle addSubview:labelTotalRemainAmountTitle];
        // 1.4.2.5 本月总剩余量值
        UILabel *labelTotalRemainAmountValue = [[UILabel alloc] init];
        NSString *value = [NSString stringWithFormat:@"%dM", [[GlobalData sharedSingleton] totalRemainFlow]];
        NSMutableAttributedString *strKey = [[NSMutableAttributedString alloc] initWithString:value];
        [strKey addAttribute:NSFontAttributeName value:kFontDetailValue range:NSMakeRange(0, [value length] - 1)];    // 数字字体
        [strKey addAttribute:NSFontAttributeName value:kFontM range:NSMakeRange([value length] - 1, 1)];    // m单位字体
        [strKey addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [value length])];
        labelTotalRemainAmountValue.attributedText = strKey;
        labelTotalRemainAmountValue.frame = CGRectMake((imageViewBackCircle.bounds.size.width - strKey.size.width) / 2, labelTotalRemainAmountTitle.frame.origin.y + labelTotalRemainAmountTitle.frame.size.height, strKey.size.width, strKey.size.height);
        labelTotalRemainAmountValue.tag = kTagLabelTotalRemainAmount;
        [imageViewBackCircle addSubview:labelTotalRemainAmountValue];

        
        // 测试按钮，测试切换视图功能
//        UIButton *btnTestSwitchVC = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 160, 30)];
//        [btnTestSwitchVC addTarget:self action:@selector(testSwitchVC:) forControlEvents:UIControlEventTouchDown];
//        btnTestSwitchVC.titleLabel.font = [UIFont systemFontOfSize:14];
//        [btnTestSwitchVC setTitle:@"流量明细" forState:UIControlStateNormal];
//        [btnTestSwitchVC setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        btnTestSwitchVC.backgroundColor = [UIColor clearColor];
//        [_mainView addSubview:btnTestSwitchVC];
        
        /// 各类流量信息
        // 背景
        UIView *liuliangDetailBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, kMainViewHeight - kHeightRemainFlowCell*2, g_windowsBounds.size.width - kInsetMainViewHV*2, kHeightRemainFlowCell*2)];
        liuliangDetailBackgroundView.backgroundColor = kColor_RGB(250.0);
        [_mainView addSubview:liuliangDetailBackgroundView];
        
        UIFont *fontKey =[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];               // 流量名称字体
//        UIFont *kFontValuePrefix =[UIFont fontWithName:@"HelveticaNeue" size:11];          // 流量值前缀字体
//        UIFont *kFontDetailValue =[UIFont systemFontOfSize:13];                                                    // 流量值字体
//        UIColor *kColorRemainValue = [UIColor colorWithRed:65.0/255 green:197.0/255 blue:77.0/255 alpha:1.0];
//        UIColor *kColorTotalValue = [UIColor colorWithRed:251.0/255 green:109.0/255 blue:160.0/255 alpha:1.0];
        
        // 先计算出名称和值各自的高度
        strKey = [[NSMutableAttributedString alloc] initWithString:@"高度"];
        //[strKey addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [strKey length])];
        [strKey addAttribute:NSFontAttributeName value:fontKey range:NSMakeRange(0, [strKey length])];
        float heightKey = strKey.size.height;   // 名称字符高度
        
        strKey = [[NSMutableAttributedString alloc] initWithString:@"高度"];
        [strKey addAttribute:NSFontAttributeName value:kFontValuePrefix range:NSMakeRange(0, [strKey length])];
        float heightValue = strKey.size.height;
        
        NSString *valuePrefix = @"剩余";
        
        // 1.5
        // 1.5.1 "国内通用流量"key
        UILabel *labelInternalGeneral = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:@"国内通用流量"];
        [strKey addAttribute:NSFontAttributeName value:fontKey range:NSMakeRange(0, [strKey length])];
        labelInternalGeneral.attributedText = strKey;
        labelInternalGeneral.frame = CGRectMake(_mainView.frame.size.width/2 - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height - kHeightRemainFlowCell - kLabelLeftFlowVerticalInset  - heightValue - kLabelLeftFlowVerticalInset - kLabelLeftFlowKeyValueDistance - heightKey, strKey.size.width, strKey.size.height);
        [_mainView addSubview:labelInternalGeneral];
        
        // 1.5.2 "国内通用流量"value
        UILabel *labelInternalGeneralValue = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%dM",valuePrefix, [[GlobalData sharedSingleton] internalRemainFlow]]];
        [strKey addAttribute:NSFontAttributeName value:kFontValuePrefix range:NSMakeRange(0, [valuePrefix length])];    // 前缀字体
        [strKey addAttribute:NSFontAttributeName value:kFontDetailValue range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];    // 值字体
        [strKey addAttribute:NSForegroundColorAttributeName value:kColorRemainValue range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];
        labelInternalGeneralValue.attributedText = strKey;
        labelInternalGeneralValue.frame = CGRectMake(_mainView.frame.size.width/2 - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height - kHeightRemainFlowCell - kLabelLeftFlowVerticalInset  - heightValue - kLabelLeftFlowVerticalInset, strKey.size.width, strKey.size.height);
        labelInternalGeneralValue.tag = kTagLabelInternalFlow;
        [_mainView addSubview:labelInternalGeneralValue];
        
        // 1.5.3 流量详细按钮1
        UIButton *btnDetails = [[UIButton alloc] initWithFrame:CGRectMake(0, _mainView.frame.size.height - kHeightRemainFlowCell * 2, _mainView.frame.size.width / 2, kHeightRemainFlowCell)];
        btnDetails.tag = kTagBtnDetailsBase + 0;
        [btnDetails addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:btnDetails];
        
        // 1.6
        // 1.6.1 "本地通用流量"key
        UILabel *labelLocalGeneral = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:@"本地通用流量"];
        [strKey addAttribute:NSFontAttributeName value:fontKey range:NSMakeRange(0, [strKey length])];
        labelLocalGeneral.attributedText = strKey;
        labelLocalGeneral.frame = CGRectMake(_mainView.frame.size.width - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height - kHeightRemainFlowCell - kLabelLeftFlowVerticalInset  - heightValue - kLabelLeftFlowVerticalInset - kLabelLeftFlowKeyValueDistance - heightKey, strKey.size.width, strKey.size.height);
        [_mainView addSubview:labelLocalGeneral];
        
        // 1.6.2 "本地通用流量"value
        UILabel *labelLocalGeneralValue = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总计%dM", 0]];
        [strKey addAttribute:NSFontAttributeName value:kFontValuePrefix range:NSMakeRange(0, [strKey length])];
        [strKey addAttribute:NSFontAttributeName value:kFontDetailValue range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];    // 值字体
        [strKey addAttribute:NSForegroundColorAttributeName value:kColorTotalValue range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];
        labelLocalGeneralValue.attributedText = strKey;
        labelLocalGeneralValue.frame = CGRectMake(_mainView.frame.size.width - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height - kHeightRemainFlowCell - kLabelLeftFlowVerticalInset  - heightValue - kLabelLeftFlowVerticalInset, strKey.size.width, strKey.size.height);
        labelLocalGeneralValue.tag = kTagLabelLocalFlow;
        [_mainView addSubview:labelLocalGeneralValue];
        
        // 1.6.3 流量详细信息2
        btnDetails = [[UIButton alloc] initWithFrame:CGRectMake(_mainView.frame.size.width/2, _mainView.frame.size.height - kHeightRemainFlowCell * 2, _mainView.frame.size.width / 2, kHeightRemainFlowCell)];
        btnDetails.tag = kTagBtnDetailsBase + 1;
        [btnDetails addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:btnDetails];
        
        // 1.7
        // 1.7.1 "本地4G流量"key
        UILabel *labelLocal4G = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:@"本地4G流量"];
        [strKey addAttribute:NSFontAttributeName value:fontKey range:NSMakeRange(0, [strKey length])];
        labelLocal4G.attributedText = strKey;
        labelLocal4G.frame = CGRectMake(_mainView.frame.size.width/2 - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height - kLabelLeftFlowVerticalInset  - heightValue - kLabelLeftFlowKeyValueDistance - heightKey, strKey.size.width, strKey.size.height);
        [_mainView addSubview:labelLocal4G];
        
        // 1.7.2 "本地4G流量"value
        UILabel *labelLocal4GValue = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总计%dM", 0]];
        [strKey addAttribute:NSFontAttributeName value:kFontValuePrefix range:NSMakeRange(0, [strKey length])];
        [strKey addAttribute:NSFontAttributeName value:kFontDetailValue range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];    // 值字体
        [strKey addAttribute:NSForegroundColorAttributeName value:kColorTotalValue range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];
        labelLocal4GValue.attributedText = strKey;
        labelLocal4GValue.frame = CGRectMake(_mainView.frame.size.width/2 - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height - kLabelLeftFlowVerticalInset  - heightValue, strKey.size.width, strKey.size.height);
        labelLocal4GValue.tag = kTagLabelLocal4G;
        [_mainView addSubview:labelLocal4GValue];
        
        // 1.7.3 流量详细信息3
        btnDetails = [[UIButton alloc] initWithFrame:CGRectMake(0, _mainView.frame.size.height - kHeightRemainFlowCell, _mainView.frame.size.width / 2, kHeightRemainFlowCell)];
        btnDetails.tag = kTagBtnDetailsBase + 2;
        [btnDetails addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:btnDetails];
        
        // 1.8
        // 1.8.1 "本地闲时流量"key
        UILabel *labelLocalIdle = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:@"本地闲时流量"];
        [strKey addAttribute:NSFontAttributeName value:fontKey range:NSMakeRange(0, [strKey length])];
        labelLocalIdle.attributedText = strKey;
        labelLocalIdle.frame = CGRectMake(_mainView.frame.size.width - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height  - kLabelLeftFlowVerticalInset  - heightValue - kLabelLeftFlowKeyValueDistance - heightKey, strKey.size.width, strKey.size.height);
        [_mainView addSubview:labelLocalIdle];
        
        // 1.8.2 "本地闲时流量"value
        UILabel *labelLocalIdleValue = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%dM",valuePrefix, [[GlobalData sharedSingleton] localIdleRemainFlow]]];
        [strKey addAttribute:NSFontAttributeName value:kFontValuePrefix range:NSMakeRange(0, [strKey length])];
        [strKey addAttribute:NSFontAttributeName value:kFontDetailValue range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];    // 值字体
        [strKey addAttribute:NSForegroundColorAttributeName value:kColorRemainValue range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];
        labelLocalIdleValue.attributedText = strKey;
        labelLocalIdleValue.frame = CGRectMake(_mainView.frame.size.width - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height  - kLabelLeftFlowVerticalInset  - heightValue, strKey.size.width, strKey.size.height);
        labelLocalIdleValue.tag = kTagLabelLocalIdle;
        [_mainView addSubview:labelLocalIdleValue];
        
        // 1.8.3 流量详细信息3
        btnDetails = [[UIButton alloc] initWithFrame:CGRectMake(_mainView.frame.size.width/2, _mainView.frame.size.height - kHeightRemainFlowCell, _mainView.frame.size.width / 2, kHeightRemainFlowCell)];
        btnDetails.tag = kTagBtnDetailsBase + 3;
        [btnDetails addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:btnDetails];
        
        // 横向分隔线1
        UIImageView *lineY1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"liney.png"]];
        lineY1.frame = CGRectMake(0, _mainView.frame.size.height - kHeightRemainFlowCell*2, _mainView.frame.size.width, kHorizontalDividerLineHeight);
        [_mainView addSubview:lineY1];
        
        // 横向分隔线1
        UIImageView *lineY2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"liney.png"]];
        lineY2.frame = CGRectMake(0, _mainView.frame.size.height - kHeightRemainFlowCell, _mainView.frame.size.width, kHorizontalDividerLineHeight);
        [_mainView addSubview:lineY2];
        
        // 纵向分隔线1
        UIImageView *lineX1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"linex.png"]];
        lineX1.frame = CGRectMake(_mainView.frame.size.width/2, _mainView.frame.size.height - kHeightRemainFlowCell*2 + kVerticalDividerLineVerticalInset, kVerticalDividerLineWidth, kHeightRemainFlowCell - kVerticalDividerLineVerticalInset*2);
        [_mainView addSubview:lineX1];
        
        // 纵向分隔线2
        UIImageView *lineX2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"linex.png"]];
        lineX2.frame = CGRectMake(_mainView.frame.size.width/2, _mainView.frame.size.height - kHeightRemainFlowCell + kVerticalDividerLineVerticalInset, kVerticalDividerLineWidth, kHeightRemainFlowCell - kVerticalDividerLineVerticalInset*2);
        [_mainView addSubview:lineX2];
        [self addSubview:_mainView];
        
        // 2. 功能按钮
        // "分析流量"按钮
        CGSize btnSize = CGSizeMake((self.bounds.size.width - kInsetMainViewHV*2 - kFuncButtonDistance*3) / 4, (self.bounds.size.width - kInsetMainViewHV*2 - kFuncButtonDistance*3) / 4);
        //float btnY = self.view.frame.size.height - kFuncButtonBottomInset - btnSize.height; // 按钮相对于本视图的y坐标，减法方式
        //float btnY = kInsetMainViewHV + kMainViewHeight + kMainViewButtonDistance;    // _transitionView 非全尺寸情况
        float btnY = kInsetMainViewHV + kMainViewHeight + kMainViewButtonDistance;
        
        // 各功能按钮对应图片
        NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic setObject:[UIImage imageNamed:@"flowbtnanalysenormal.png"] forKey:@"Default"];
        [imgDic setObject:[UIImage imageNamed:@"flowbtnanalyseactive.png"] forKey:@"Highlighted"];
        [imgDic setObject:[UIImage imageNamed:@"flowbtnanalyseactive.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic2 setObject:[UIImage imageNamed:@"flowbtnusenormal.png"] forKey:@"Default"];
        [imgDic2 setObject:[UIImage imageNamed:@"flowbtnuseactive.png"] forKey:@"Highlighted"];
        [imgDic2 setObject:[UIImage imageNamed:@"flowbtnuseactive.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic3 setObject:[UIImage imageNamed:@"flowbtnextnormal.png"] forKey:@"Default"];
        [imgDic3 setObject:[UIImage imageNamed:@"flowbtnextactive.png"] forKey:@"Highlighted"];
        [imgDic3 setObject:[UIImage imageNamed:@"flowbtnextactive.png"] forKey:@"Seleted"];
        NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic4 setObject:[UIImage imageNamed:@"flowbtnsharenormal.png"] forKey:@"Default"];
        [imgDic4 setObject:[UIImage imageNamed:@"flowbtnshareactive.png"] forKey:@"Highlighted"];
        [imgDic4 setObject:[UIImage imageNamed:@"flowbtnshareactive.png"] forKey:@"Seleted"];
        
        NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,nil];
        
        for (int i=0; i<4; i++) {
            float btnX = kInsetMainViewHV + i*btnSize.width + i*kFuncButtonDistance;  // 按钮相对于本视图的x坐标
            CGRect cr = CGRectMake(btnX, btnY, btnSize.width, btnSize.height);
            //UIButton *btnAnalyze = [[UIButton alloc] initWithFrame:cr];
            //btnAnalyze.backgroundColor = [UIColor redColor];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.showsTouchWhenHighlighted = YES;
            btn.tag = i;
            btn.frame = cr;
            [btn setImage:[[imgArr objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
            [btn setImage:[[imgArr objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
            [btn setImage:[[imgArr objectAtIndex:i] objectForKey:@"Seleted"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(funcButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            //btn.backgroundColor = [UIColor grayColor];
            [self addSubview:btn];
        }
    }
    
    // 添加点击事件
    //UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    //[self addGestureRecognizer:gesture];
    return self;
}

- (void)tap:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn) {
        [_parent switchToCategoryDetails:(int)btn.tag - kTagBtnDetailsBase];
    }
}

// 重新加载相关控件的数据
- (void)reloadData
{
    // 模拟更新数据
    //[[GlobalData sharedSingleton] testUpdateData];
    
    // 查询时间(只需要修改值，不需要重新设置属性)
    UILabel *labelQueryTime = (UILabel *)[_mainView viewWithTag:kTagLabelQueryTime];
    NSDictionary *attr = [(NSAttributedString *)labelQueryTime.attributedText attributesAtIndex:0 effectiveRange:NULL];
    labelQueryTime.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"查询时间:%@", [[GlobalData sharedSingleton] lastQueryTime]] attributes:attr];
    
    // 1.3.1.2 本月已用值
    // 删除旧标签
    UILabel *labelTotalUsedFlowValue = (UILabel *)[_mainView viewWithTag:kTagLabelTotalUsedFlow];
    CGRect frame = labelTotalUsedFlowValue.frame;
    [labelTotalUsedFlowValue removeFromSuperview];
    // 创建新标签
    NSString *stringLabelText = [NSString stringWithFormat:@"%dM", [[GlobalData sharedSingleton] totalUsedFlow]];
    labelTotalUsedFlowValue = [stringLabelText createFontedLabel:kFontTotalInfoValue];
    NSMutableAttributedString *attrString = (NSMutableAttributedString *)labelTotalUsedFlowValue.attributedText;
    [attrString addAttribute:NSFontAttributeName value:kFontM range:NSMakeRange([[NSString stringWithFormat:@"%d", [[GlobalData sharedSingleton] totalUsedFlow]] length], 1)];
    labelTotalUsedFlowValue.center = CGPointMake(g_screenWidth - kInsetMainViewHV*2 - labelTotalUsedFlowValue.frame.size.width/2 - kInsetHorizontalTotalInfo, frame.origin.y + attrString.size.height/2);
    labelTotalUsedFlowValue.tag = kTagLabelTotalUsedFlow;
    [_mainView addSubview:labelTotalUsedFlowValue];

    // 1.6.2 "本地通用流量"value
    // 删除旧标签
    UILabel *labelInternalGeneralValue = (UILabel *)[_mainView viewWithTag:kTagLabelInternalFlow];
    //frame = labelInternalGeneralValue.frame;
    [labelInternalGeneralValue removeFromSuperview];
    // 创建新标签
    labelInternalGeneralValue = [[UILabel alloc] init];
    NSString *valuePrefix = @"剩余";
    NSMutableAttributedString *strKey = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%dM", valuePrefix, [[GlobalData sharedSingleton] internalRemainFlow]]];
    [strKey addAttribute:NSFontAttributeName value:kFontValuePrefix range:NSMakeRange(0, [valuePrefix length])];    // 前缀字体
    [strKey addAttribute:NSFontAttributeName value:kFontDetailValue range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];    // 值字体
    [strKey addAttribute:NSForegroundColorAttributeName value:kColorRemainValue range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];
    labelInternalGeneralValue.attributedText = strKey;
    labelInternalGeneralValue.frame = CGRectMake(_mainView.frame.size.width/2 - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height - kHeightRemainFlowCell - kLabelLeftFlowVerticalInset  - strKey.size.height - kLabelLeftFlowVerticalInset, strKey.size.width, strKey.size.height);
    labelInternalGeneralValue.tag = kTagLabelInternalFlow;
    [_mainView addSubview:labelInternalGeneralValue];
    
    // // 1.4.2.5 本月总剩余量标签
    // 删除旧标签
    UILabel *labelTotalRemainValue = (UILabel *)[_mainView viewWithTag:kTagLabelTotalRemainAmount];
    frame = labelTotalRemainValue.frame;
    [labelTotalRemainValue removeFromSuperview];
    // 创建新标签
    UILabel *labelTotalRemainAmountValue = [[UILabel alloc] init];
    NSString *value = [NSString stringWithFormat:@"%dM", [[GlobalData sharedSingleton] totalRemainFlow]];
    strKey = [[NSMutableAttributedString alloc] initWithString:value];
    [strKey addAttribute:NSFontAttributeName value:kFontDetailValue range:NSMakeRange(0, [value length] - 1)];    // 数字字体
    [strKey addAttribute:NSFontAttributeName value:kFontM range:NSMakeRange([value length] - 1, 1)];    // m单位字体
    [strKey addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [value length])];
    labelTotalRemainAmountValue.attributedText = strKey;
    labelTotalRemainAmountValue.frame = frame;
    labelTotalRemainAmountValue.tag = kTagLabelTotalRemainAmount;
    UIImageView *viewBackCircle = (UIImageView *)[_mainView viewWithTag:kTagImageViewTotalRemain];
    [viewBackCircle addSubview:labelTotalRemainAmountValue];
    
    // 开启动画
    [self startAnimate];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)testSwitchVC:(id)sender
{
    [_parent switchToCategoryDetails:0];
}

// 开始剩余流量信息动画展示
- (void) startAnimate
{
    unsigned int nTotalRemain = [[GlobalData sharedSingleton] totalRemainFlow];
    __block unsigned int nCurShow = [[GlobalData sharedSingleton] totalFlow];
    unsigned int nTotal = [[GlobalData sharedSingleton] totalFlow];

    _animateTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,dispatch_get_main_queue()); // 只能用主线程队列才有效果
    dispatch_source_set_timer(_animateTimer, dispatch_walltime(DISPATCH_TIME_NOW, 0), USEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_animateTimer, ^{
        if (nCurShow >= nTotalRemain) {
            BackCircleView *viewBackCircle = (BackCircleView *)[_mainView viewWithTag:kTagViewBackCircle];
            [viewBackCircle setCurAmount:nCurShow];
            
            // 剩余流量百分比
            UILabel *labelRationRemain = (UILabel *)[_mainView viewWithTag:kTagLabelRationRemain];
            NSDictionary *attr = [(NSAttributedString *)labelRationRemain.attributedText attributesAtIndex:0 effectiveRange:NULL];
            if (nCurShow == nTotal) {
                labelRationRemain.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d", (int)(nCurShow*100.0/nTotal)] attributes:attr];
            }
            else {
                labelRationRemain.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %d", (int)(nCurShow*100.0/nTotal)] attributes:attr];
            }
            nCurShow-=5;
        }
        else {
            dispatch_source_cancel(_animateTimer);
        }
    });
    
    dispatch_resume(_animateTimer);
}

@end
