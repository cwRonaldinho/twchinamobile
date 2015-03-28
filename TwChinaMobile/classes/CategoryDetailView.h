//
//  CategoryDetailView.h
//  TwChinaMobile
//
//  Created by tw on 15-3-18.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryDetailView : UIView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *mainImageName;
@property (nonatomic, copy) NSString *desp;
@property (nonatomic, strong) NSArray *arrayDetailImageName;
@property (nonatomic) unsigned int total;
@property (nonatomic) unsigned int remain;
@property (nonatomic, copy) NSString *queryTime;

- (void)loadItems;
@end
