//
//  XLCycleScrollView.m
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import "XLCycleScrollView.h"
#include "constant.h"

@implementation XLCycleScrollView

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize currentPage = _curPage;
@synthesize datasource = _datasource;
@synthesize delegate = _delegate;

- (void)dealloc
{
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 5, self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        //_scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.contentOffset = CGPointMake(0, 320);
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_scrollView];
        
        _curPage = 0;
        
        
        
        UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*5, 480)];
        testView.backgroundColor = [UIColor grayColor];
        for (int i=0; i<5; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*320, 320, 100, 20)];
            btn.backgroundColor = [UIColor redColor];
            [btn setTitle:[NSString stringWithFormat:@"h%d", i] forState:UIControlStateNormal];
            [testView addSubview:btn];
        }
        [_scrollView addSubview:testView];
    }
    return self;
}

- (void)setDataource:(id<XLCycleScrollViewDatasource>)datasource
{
    _datasource = datasource;
    //[self reloadData];
}



- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_curPage];
    }
    
}

//- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
//{
//    if (index == _curPage) {
//        [_curViews replaceObjectAtIndex:1 withObject:view];
//        for (int i = 0; i < 3; i++) {
//            UIView *v = [_curViews objectAtIndex:i];
//            v.userInteractionEnabled = YES;
//            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                        action:@selector(handleTap:)];
//            [v addGestureRecognizer:singleTap];
//            v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
//            [_scrollView addSubview:v];
//        }
//    }
//}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    int x = aScrollView.contentOffset.x;
    
    //往下翻一张
    if(x >= (2*self.frame.size.width)) {
        //_curPage = [self validPageValue:_curPage+1];
        //[self loadData];
    }
    
    //往上翻
    if(x <= 0) {
        //_curPage = [self validPageValue:_curPage-1];
        //[self loadData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    //[_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
    
}

@end
