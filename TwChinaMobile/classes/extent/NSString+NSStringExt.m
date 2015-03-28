//
//  NSString+NSStringExt.m
//  TwChinaMobile
//
//  Created by tw on 15-3-16.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "NSString+NSStringExt.h"

@implementation NSString(NSStringExt)
- (CGSize)getSizeOfFontedString:(UIFont *)font;
{
    // 先计算出名称和值各自的高度
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [self length])];
    return attrString.size;
}

// 根据指定字体创建相应尺寸的 UILabel，origin默认为0
- (UILabel *)createFontedLabel:(UIFont *)font
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self];
    //[attrString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, [attrString length])];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [attrString length])];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, attrString.size.width, attrString.size.height)];
    label.attributedText = attrString;
    return label;
}

// 根据指定字体、分段、颜色创建相应 UILabel
- (UILabel *)createSpecLabel:(NSArray *)fonts lens:(int *)lensV colors:(NSArray *)colorsV
{
    CGSize size = {0, 0};
    // 计算每一部分字串的长度
    int curPos = 0;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self];
    for (int i = 0; i < [fonts count]; i++) {
        int lenString = lensV[i];
        [attr addAttribute:NSFontAttributeName value:(UIFont *)[fonts objectAtIndex:i] range:NSMakeRange(curPos, lenString)];
        [attr addAttribute:NSForegroundColorAttributeName value:(UIColor *)[colorsV objectAtIndex:i] range:NSMakeRange(curPos, lenString)];
        size.width += attr.size.width;
        size.height = MAX(size.height, attr.size.height);
        curPos +=lenString;
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    label.attributedText = attr;
    return label;
}
@end
