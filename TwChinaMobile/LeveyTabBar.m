//
//  LeveyTabBar.m
//  LeveyTabBarController
//
//  Created by zhang on 12-10-10.
//  Copyright (c) 2012年 jclt. All rights reserved.
//
//

#import "LeveyTabBar.h"
#include "UIImage+UIImageExt.h"
#import "common_util.h"

@implementation LeveyTabBar
@synthesize backgroundView = _backgroundView;
@synthesize delegate = _delegate;
@synthesize buttons = _buttons;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self)
	{
		//self.backgroundColor = [UIColor clearColor];
		//_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		//[self addSubview:_backgroundView];
		
		self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
		UIButton *btn;
		CGFloat width = [[UIScreen mainScreen] bounds].size.width / [imageArray count];
		for (int i = 0; i < [imageArray count]; i++)
		{
			btn = [UIButton buttonWithType:UIButtonTypeCustom];
			btn.showsTouchWhenHighlighted = YES;
			btn.tag = i;
			btn.frame = CGRectMake(width * i, 0, width+1, frame.size.height);   // tabbar中4个按钮可能存在间隙，用宽度加1的方式解决
            //TRACE_RECT(btn.frame);
            [btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Seleted"] forState:UIControlStateSelected];
			[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
			[self.buttons addObject:btn];
			[self addSubview:btn];
		}
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)img
{
	[_backgroundView setImage:img];
}

- (void)tabBarButtonClicked:(id)sender
{
	UIButton *btn = sender;
	[self selectTabAtIndex:btn.tag];
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [_delegate tabBar:self didSelectIndex:btn.tag];
    }
}

- (void)selectTabAtIndex:(NSInteger)index
{
	for (int i = 0; i < [self.buttons count]; i++)
	{
		UIButton *b = [self.buttons objectAtIndex:i];
		b.selected = NO;
		b.userInteractionEnabled = YES;
	}
	UIButton *btn = [self.buttons objectAtIndex:index];
	btn.selected = YES;
	btn.userInteractionEnabled = NO;
}

- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(UIButton *)[self.buttons objectAtIndex:index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
   
    // Re-index the buttons
     CGFloat width = 320.0f / [self.buttons count];
    for (UIButton *btn in self.buttons) 
    {
        if (btn.tag > index)
        {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * btn.tag, 0, width, self.frame.size.height);
    }
}
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    // Re-index the buttons
    CGFloat width = 320.0f / ([self.buttons count] + 1);
    for (UIButton *b in self.buttons) 
    {
        if (b.tag >= index)
        {
            b.tag ++;
        }
        b.frame = CGRectMake(width * b.tag, 0, width, self.frame.size.height);
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index;
    btn.frame = CGRectMake(width * index, 0, width, self.frame.size.height);
    [btn setImage:[dict objectForKey:@"Default"] forState:UIControlStateNormal];
    [btn setImage:[dict objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[dict objectForKey:@"Seleted"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:btn atIndex:index];
    [self addSubview:btn];
}

- (void)dealloc
{
}

@end

@implementation UIButton (UIButtonImageWithLable)

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]};
    //CGSize titleSize = [title sizeWithAttributes:attributes];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-40.0,
                                              20.0,
                                              0.0,
                                              0)];
    // 将图片压缩
    UIImage *newImage = [image imageByScalingAndCroppingForSize:CGSizeMake(24, 23)];
    //[self setImage:image forState:stateType];
    [self setImage:newImage forState:stateType];
    
    //CGRect rc = self.imageView.frame;
//    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    //[self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    //self.titleLabel.backgroundColor = [UIColor grayColor];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(20.0,
                                              -20.0,
                                             0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
    [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

@end