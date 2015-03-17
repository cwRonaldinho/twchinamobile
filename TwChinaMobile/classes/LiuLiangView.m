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

// 控件 tag 值定义
#define kTagLabelQueryTime 1000

// 流量界面相关定义
#define kInsetMainViewHV 8.0f             // 主视图区到两边及上面元素的距离
#define kMainViewHeight 300.0f       // 主视图高度
#define kMainViewButtonDistance 8.0f        // 主视图上下部分间距离
#define kInsetHorizontalTotalInfo 14      // 套餐总量标签距左边框距离，本月已用标签距右边框距离
#define kInsetTopTotalInfo 140      // 套餐总量标签/本月已用标签距上边框距离
#define kFuncButtonDistance 4.0f    // 功能按钮之间间隔，通过该值能计算出功能按钮的宽度，如高度和宽度相同，则高度也通过该值计算即可
//#define kFuncButtonBottomInset 40.0f    // 功能按钮与下面元素距离
#define kLabelLeftFlowRightInset 32.0f       // 剩余流量标签距离右边元素的距离
#define kLabelLeftFlowVerticalInset 4.0f        // 剩余流量标签距离上下元素的距离
#define kLabelLeftFlowKeyValueDistance 2.0f    // 剩余流量名标签与流量值标签的距离
#define kLabelLeftFlowCellHeight 46.0f          // 剩余流量信息行高度

#define kHorizontalDividerLineHeight 1.0f           // 水平分隔线高度
#define kVerticalDividerLineWidth 1.0f                      // 垂直分隔线宽度
#define kVerticalDividerLineVerticalInset 8.0f          // 垂直分隔线距离上下元素距离


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
        backgroundView.frame = CGRectMake(0, 0, g_applicationFrame.size.width - kInsetMainViewHV*2, kMainViewHeight-kLabelLeftFlowCellHeight*2);   // 注意，背景视图是添加到 _mainView 中的，所以其 frame 值是相对于 _mainView 的坐标
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
        UIFont *fontTotalInfoValue = [UIFont systemFontOfSize:15];   // 总量数字字体
        UIFont *fontM = [UIFont systemFontOfSize:11];                     // 单位m 字体
        
        // 1.3.1 套餐总量标题
        stringLabelText = @"套餐总量";
        UILabel *labelTotalFlow = [stringLabelText createFontedLabel:fontTotalKey];
        attrString = (NSMutableAttributedString *)labelTotalFlow.attributedText;
        labelTotalFlow.center = CGPointMake(kInsetHorizontalTotalInfo + attrString.size.width/2, kInsetTopTotalInfo + attrString.size.height/2);
        [_mainView addSubview:labelTotalFlow];
        // 1.3.1.1 套餐总量值
        stringLabelText = [NSString stringWithFormat:@"%dM", [[GlobalData sharedSingleton] totalFlow]];
        UILabel *labelTotalFlowValue = [stringLabelText createFontedLabel:fontTotalInfoValue];
        attrString = (NSMutableAttributedString *)labelTotalFlowValue.attributedText;
        [attrString addAttribute:NSFontAttributeName value:fontM range:NSMakeRange([[NSString stringWithFormat:@"%d", [[GlobalData sharedSingleton] totalFlow]] length], 1)]; // 注意：虽然重新设置了标签内容中包含多种字体，但标签的长度已经固定，所以在设置 center 时需要使用标签的宽度
        labelTotalFlowValue.center = CGPointMake(kInsetHorizontalTotalInfo + labelTotalFlowValue.frame.size.width/2, labelTotalFlow.frame.origin.y + labelTotalFlow.frame.size.height + attrString.size.height/2);
        [_mainView addSubview:labelTotalFlowValue];
        
        // 1.3.2 本月已用标题
        stringLabelText = @"本月已用";
        UILabel *labelTotalUsed = [stringLabelText createFontedLabel:fontTotalKey];
        attrString = (NSMutableAttributedString *)labelTotalUsed.attributedText;
        labelTotalUsed.center = CGPointMake(g_screenWidth - kInsetMainViewHV*2 - attrString.size.width/2 - kInsetHorizontalTotalInfo, kInsetTopTotalInfo + attrString.size.height/2);
        [_mainView addSubview:labelTotalUsed];
        // 1.3.1.2 本月已用值
        stringLabelText = [NSString stringWithFormat:@"%dM", [[GlobalData sharedSingleton] totalUsedFlow]];
        UILabel *labelTotalUsedFlowValue = [stringLabelText createFontedLabel:fontTotalInfoValue];
        attrString = (NSMutableAttributedString *)labelTotalUsedFlowValue.attributedText;
        [attrString addAttribute:NSFontAttributeName value:fontM range:NSMakeRange([[NSString stringWithFormat:@"%d", [[GlobalData sharedSingleton] totalUsedFlow]] length], 1)]; // 注意：虽然重新设置了标签内容中包含多种字体，但标签的长度已经固定，所以在设置 center 时需要使用标签的宽度
        labelTotalUsedFlowValue.center = CGPointMake(g_screenWidth - kInsetMainViewHV*2 - labelTotalUsedFlowValue.frame.size.width/2 - kInsetHorizontalTotalInfo, labelTotalUsed.frame.origin.y + labelTotalUsed.frame.size.height + attrString.size.height/2);
        [_mainView addSubview:labelTotalUsedFlowValue];

        
        // 测试按钮，测试切换视图功能
        UIButton *btnTestSwitchVC = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 160, 30)];
        [btnTestSwitchVC addTarget:self action:@selector(testSwitchVC:) forControlEvents:UIControlEventTouchDown];
        btnTestSwitchVC.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnTestSwitchVC setTitle:@"流量明细" forState:UIControlStateNormal];
        [btnTestSwitchVC setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btnTestSwitchVC.backgroundColor = [UIColor clearColor];
        [_mainView addSubview:btnTestSwitchVC];
        
        /// 各类流量信息
        // 背景
        UIView *liuliangDetailBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, kMainViewHeight - kLabelLeftFlowCellHeight*2, g_windowsBounds.size.width - kInsetMainViewHV*2, kLabelLeftFlowCellHeight*2)];
        liuliangDetailBackgroundView.backgroundColor = kColor_RGB(250.0);
        [_mainView addSubview:liuliangDetailBackgroundView];
        
        UIFont *fontKey =[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];   // 流量名称字体
        UIFont *fontValue =[UIFont fontWithName:@"HelveticaNeue" size:11];          // 流量值字体
        
        // 先计算出名称和值各自的高度
        NSMutableAttributedString *strKey = [[NSMutableAttributedString alloc] initWithString:@"高度"];
        //[strKey addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [strKey length])];
        [strKey addAttribute:NSFontAttributeName value:fontKey range:NSMakeRange(0, [strKey length])];
        float heightKey = strKey.size.height;   // 名称字符高度
        
        strKey = [[NSMutableAttributedString alloc] initWithString:@"高度"];
        [strKey addAttribute:NSFontAttributeName value:fontValue range:NSMakeRange(0, [strKey length])];
        float heightValue = strKey.size.height;
        
        NSString *valuePrefix = @"剩余";
        
        // "国内通用流量"key
        UILabel *labelInternalGeneral = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:@"国内通用流量"];
        [strKey addAttribute:NSFontAttributeName value:fontKey range:NSMakeRange(0, [strKey length])];
        labelInternalGeneral.attributedText = strKey;
        labelInternalGeneral.frame = CGRectMake(_mainView.frame.size.width/2 - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height - kLabelLeftFlowCellHeight - kLabelLeftFlowVerticalInset  - heightValue - kLabelLeftFlowVerticalInset - kLabelLeftFlowKeyValueDistance - heightKey, strKey.size.width, strKey.size.height);
        [_mainView addSubview:labelInternalGeneral];
        
        // "国内通用流量"value
        UILabel *labelInternalGeneralValue = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%dM",valuePrefix, 789]];
        [strKey addAttribute:NSFontAttributeName value:fontValue range:NSMakeRange(0, [strKey length])];
        [strKey addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];
        labelInternalGeneralValue.attributedText = strKey;
        labelInternalGeneralValue.frame = CGRectMake(_mainView.frame.size.width/2 - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height - kLabelLeftFlowCellHeight - kLabelLeftFlowVerticalInset  - heightValue - kLabelLeftFlowVerticalInset, strKey.size.width, strKey.size.height);
        [_mainView addSubview:labelInternalGeneralValue];
        
        // "本地通用流量"key
        UILabel *labelLocalGeneral = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:@"本地通用流量"];
        [strKey addAttribute:NSFontAttributeName value:fontKey range:NSMakeRange(0, [strKey length])];
        labelLocalGeneral.attributedText = strKey;
        labelLocalGeneral.frame = CGRectMake(_mainView.frame.size.width - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height - kLabelLeftFlowCellHeight - kLabelLeftFlowVerticalInset  - heightValue - kLabelLeftFlowVerticalInset - kLabelLeftFlowKeyValueDistance - heightKey, strKey.size.width, strKey.size.height);
        [_mainView addSubview:labelLocalGeneral];
        
        // "本地通用流量"value
        UILabel *labelLocalGeneralValue = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%dM",valuePrefix, 0]];
        [strKey addAttribute:NSFontAttributeName value:fontValue range:NSMakeRange(0, [strKey length])];
        [strKey addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];
        labelLocalGeneralValue.attributedText = strKey;
        labelLocalGeneralValue.frame = CGRectMake(_mainView.frame.size.width - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height - kLabelLeftFlowCellHeight - kLabelLeftFlowVerticalInset  - heightValue - kLabelLeftFlowVerticalInset, strKey.size.width, strKey.size.height);
        [_mainView addSubview:labelLocalGeneralValue];
        
        // "本地4G流量"key
        UILabel *labelLocal4G = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:@"本地4G流量"];
        [strKey addAttribute:NSFontAttributeName value:fontKey range:NSMakeRange(0, [strKey length])];
        labelLocal4G.attributedText = strKey;
        labelLocal4G.frame = CGRectMake(_mainView.frame.size.width/2 - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height - kLabelLeftFlowVerticalInset  - heightValue - kLabelLeftFlowKeyValueDistance - heightKey, strKey.size.width, strKey.size.height);
        [_mainView addSubview:labelLocal4G];
        
        // "本地4G流量"value
        UILabel *labelLocal4GValue = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%dM",valuePrefix, 1]];
        [strKey addAttribute:NSFontAttributeName value:fontValue range:NSMakeRange(0, [strKey length])];
        [strKey addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];
        labelLocal4GValue.attributedText = strKey;
        labelLocal4GValue.frame = CGRectMake(_mainView.frame.size.width/2 - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height - kLabelLeftFlowVerticalInset  - heightValue, strKey.size.width, strKey.size.height);
        [_mainView addSubview:labelLocal4GValue];
        
        // "本地闲时流量"key
        UILabel *labelLocalIdle = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:@"本地闲时流量"];
        [strKey addAttribute:NSFontAttributeName value:fontKey range:NSMakeRange(0, [strKey length])];
        labelLocalIdle.attributedText = strKey;
        labelLocalIdle.frame = CGRectMake(_mainView.frame.size.width - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height  - kLabelLeftFlowVerticalInset  - heightValue - kLabelLeftFlowKeyValueDistance - heightKey, strKey.size.width, strKey.size.height);
        [_mainView addSubview:labelLocalIdle];
        
        // "本地闲时流量"value
        UILabel *labelLocalIdleValue = [[UILabel alloc] init];
        strKey = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%dM",valuePrefix, 99]];
        [strKey addAttribute:NSFontAttributeName value:fontValue range:NSMakeRange(0, [strKey length])];
        [strKey addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange([valuePrefix length], [strKey length] - [valuePrefix length])];
        labelLocalIdleValue.attributedText = strKey;
        labelLocalIdleValue.frame = CGRectMake(_mainView.frame.size.width - kLabelLeftFlowRightInset - strKey.size.width, _mainView.frame.size.height  - kLabelLeftFlowVerticalInset  - heightValue, strKey.size.width, strKey.size.height);
        [_mainView addSubview:labelLocalIdleValue];
        
        // 横向分隔线1
        UIImageView *lineY1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"liney.png"]];
        lineY1.frame = CGRectMake(0, _mainView.frame.size.height - kLabelLeftFlowCellHeight*2, _mainView.frame.size.width, kHorizontalDividerLineHeight);
        [_mainView addSubview:lineY1];
        
        // 横向分隔线1
        UIImageView *lineY2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"liney.png"]];
        lineY2.frame = CGRectMake(0, _mainView.frame.size.height - kLabelLeftFlowCellHeight, _mainView.frame.size.width, kHorizontalDividerLineHeight);
        [_mainView addSubview:lineY2];
        
        // 纵向分隔线1
        UIImageView *lineX1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"linex.png"]];
        lineX1.frame = CGRectMake(_mainView.frame.size.width/2, _mainView.frame.size.height - kLabelLeftFlowCellHeight*2 + kVerticalDividerLineVerticalInset, kVerticalDividerLineWidth, kLabelLeftFlowCellHeight - kVerticalDividerLineVerticalInset*2);
        [_mainView addSubview:lineX1];
        
        // 纵向分隔线2
        UIImageView *lineX2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"linex.png"]];
        lineX2.frame = CGRectMake(_mainView.frame.size.width/2, _mainView.frame.size.height - kLabelLeftFlowCellHeight + kVerticalDividerLineVerticalInset, kVerticalDividerLineWidth, kLabelLeftFlowCellHeight - kVerticalDividerLineVerticalInset*2);
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
    return self;
}

// 重新加载相关控件的数据
- (void)reloadData
{
    UILabel *labelQueryTime = (UILabel *)[self viewWithTag:kTagLabelQueryTime];
    NSDictionary *attr = [(NSAttributedString *)labelQueryTime.attributedText attributesAtIndex:0 effectiveRange:NULL];
    labelQueryTime.attributedText = [[NSAttributedString alloc] initWithString:@"abc" attributes:attr];
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
    [_parent switchToCategoryDetails];
}

@end
