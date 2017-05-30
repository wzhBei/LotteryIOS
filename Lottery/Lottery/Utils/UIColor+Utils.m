//
//  UIColor+Utils.m
//  Lottery
//
//  Created by wzhnopc on 2017/5/20.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)

+ (UIColor *)L_ColorWithRed:(double)red
                      green:(double)green
                       blue:(double)blue{
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:0.8];
}

+ (UIColor *)L_Orange {
    return [self L_ColorWithRed:249 green:173 blue:83];
}

+ (UIColor *)L_Blue {
    return [self L_ColorWithRed:255 green:250 blue:205];
}

+ (UIColor *)L_Red {
    return [self L_ColorWithRed:255 green:247 blue:125];
}

+ (UIColor *)L_Green {
    return [self L_ColorWithRed:255 green:247 blue:125];
}
@end
