//
//  CategoryDetailViewController.h
//  TwChinaMobile
//
//  Created by tw on 15-3-10.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CategoryDetailViewController : BaseViewController<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView; 
@end
