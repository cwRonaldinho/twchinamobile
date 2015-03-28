//
//  UIView_UIView_UIViewExt.h
//  TwChinaMobile
//
//  Created by tw on 15-3-19.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewExt)
- (float)getBottomY;
@end

@implementation UIView(UIVIewExt)

- (float)getBottomY
{
    return self.frame.origin.y + self.frame.size.height;
}

@end
