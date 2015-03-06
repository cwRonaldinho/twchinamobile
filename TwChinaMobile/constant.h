//
//  constant.h
//  TwChinaMobile
//
//  Created by tw on 15-2-5.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#ifndef TwChinaMobile_constant_h
#define TwChinaMobile_constant_h

// 全局变量
CGRect g_windowsBounds;
CGRect g_applicationFrame;
/*
 CGRect r = [ UIScreen mainScreen ].applicationFrame;
 r=0，20，320，460
 
 CGRect rx = [ UIScreen mainScreen ].bounds;
 r=0，0，320，480
 */

// 全局测试变量
CGRect g_cr;

// 常量
#define kTabBarHeight 49.0f
#define kStatusBarHeight 20.0f

// logo size
#define kLogoWidth 40.0f
#define kLogoHeight 40.0f
#define kLogoInset 10.0f // logo距离两侧元素的距离

// 通话按钮尺寸
#define kCommBtnWeight 30.0f
#define kCommBtnHeight 30.0f
#define kCommBtnTag 100

// 流量界面相关定义
#define kMainViewInset 8.0f             // 主视图区到两边及上面元素的距离
#define kMainViewHeight 310.0f       // 主视图高度
#define kMainViewButtonDistance 8.0f        // 主视图上下部分间距离
#define kFuncButtonDistance 4.0f    // 功能按钮之间间隔，通过该值能计算出功能按钮的宽度，如高度和宽度相同，则高度也通过该值计算即可
//#define kFuncButtonBottomInset 40.0f    // 功能按钮与下面元素距离
#define kLabelLeftFlowRightInset 32.0f       // 剩余流量标签距离右边元素的距离
#define kLabelLeftFlowVerticalInset 4.0f        // 剩余流量标签距离上下元素的距离
#define kLabelLeftFlowKeyValueDistance 2.0f    // 剩余流量名标签与流量值标签的距离
#define kLabelLeftFlowCellHeight 46.0f          // 剩余流量信息行高度

#define kHorizontalDividerLineHeight 1.0f           // 水平分隔线高度
#define kVerticalDividerLineWidth 1.0f                      // 垂直分隔线宽度
#define kVerticalDividerLineVerticalInset 8.0f          // 垂直分隔线距离上下元素距离

/// 颜色定义
//#define kColor_FrenchGray [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0] // 浅灰色
#define kColor_RGB(v) [UIColor colorWithRed:v/255 green:v/255 blue:v/255 alpha:1.0]

#endif
