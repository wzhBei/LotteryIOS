//
//  AlertHelper.m
//  Lottery
//
//  Created by wzhnopc on 2017/5/6.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "AlertHelper.h"
#import <MBProgressHUD.h>

@implementation AlertHelper

SINGLETON_IMPL(AlertHelper);

- (void)showHud {
    [MBProgressHUD showHUDAddedTo:[self windowView] animated:YES];
}

- (void)dismissHud {
    [MBProgressHUD hideHUDForView:[self windowView] animated:YES];
}

- (UIView *)windowView {
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    return keywindow;
    
}

@end
