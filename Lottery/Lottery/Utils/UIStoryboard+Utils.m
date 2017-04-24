//
//  UIStoryboard+Utils.m
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "UIStoryboard+Utils.h"

@implementation UIStoryboard (Utils)

    + (UIViewController *)createVCWithStroyboardName:(NSString *)storyboardName
                            identifier:(NSString *)identifier {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:identifier];
        return controller;
    }
    
@end
