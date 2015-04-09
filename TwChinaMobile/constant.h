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
float g_screenWidth;
float g_screenHeight;
/*
 CGRect r = [ UIScreen mainScreen ].applicationFrame;
 r=0，20，320，460
 
 CGRect rx = [ UIScreen mainScreen ].bounds;
 r=0，0，320，480
 */

// 全局测试变量
CGRect g_cr;

// 常量
#define kNavBarHeight 44.0f
#define kTabBarHeight 44.0f
#define kStatusBarHeight 20.0f

// logo size
#define kLogoWidth 30.0f
#define kLogoHeight 30.0f
#define kLogoInset 10.0f // logo距离两侧元素的距离

// 通话按钮尺寸
#define kCommBtnWeight 25.0f
#define kCommBtnHeight 25.0f
#define kCommBtnTag 100

// 尺寸
#define gkCornerRadius 8            // 圆角半径


/// 颜色定义
//#define kColor_FrenchGray [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0] // 浅灰色
#define kColor_RGB(v) [UIColor colorWithRed:v/255.0 green:v/255.0 blue:v/255.0 alpha:1.0]
#define kColorBackCircle [UIColor colorWithRed:70/255.0 green:202/255.0 blue:30/255.0 alpha:1.0]    // 剩余流星弧背景颜色
#define gkColorDarkPink [UIColor colorWithRed:237.0/255 green:58.0/255 blue:59.0/255 alpha:1.0]  
#define gkColorDarkGray kColor_RGB(120) 
#define gkColorBackgrondGray kColor_RGB(239)                                                   // 页面背景灰色

// 字体定义
#define DefaultFontBySize(s) [UIFont fontWithName:@"HelveticaNeue" size:s]
#define gkFontSmall [UIFont fontWithName:@"HelveticaNeue" size:12]         // 小号字体，用于时间、
#define gkFontMiddle [UIFont fontWithName:@"HelveticaNeue" size:14]         // 中号字体，用于描述信息

#endif
