//
//  UIStoryboard+Utils.h
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (Utils)

+ (UIViewController *)createVCWithStroyboardName:(NSString *)storyboardName
                        identifier:(NSString *)identifier;
@end
