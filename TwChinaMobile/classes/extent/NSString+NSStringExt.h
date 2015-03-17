//
//  NSString+NSStringExt.h
//  TwChinaMobile
//
//  Created by tw on 15-3-16.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(NSStringExt)
- (CGSize)getSizeOfFontedString:(UIFont *)font;
- (UILabel *)createFontedLabel:(UIFont *)font;
@end
