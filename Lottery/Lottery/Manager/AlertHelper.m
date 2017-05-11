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

- (void)showFilterInvalidWithModel:(FilterCellModel *)model {
    NSString *alertString = [NSString stringWithFormat:@"%@で洗い出す場合に、ルールにご参考してください.", [model conditionString]];
    [[AlertHelper sharedInstance] showAlertWithTitle:@"確認" message:alertString ok:^{
    } cancel:nil];
}

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                        ok:(void(^)())okAction
                    cancel:(void(^)())cancelAction {
    __weak AlertHelper *weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (okAction) {
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[weakSelf rootNavigationController] dismissViewControllerAnimated:YES completion:nil];
            okAction();
        }];
        [alertController addAction:ok];
    }
    
    if (cancelAction) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            cancelAction();
            [[weakSelf rootNavigationController] dismissViewControllerAnimated:YES completion:nil];
            
        }];
        [alertController addAction:cancel];
    }
    
    [[self rootNavigationController] presentViewController:alertController animated:YES completion:nil];
    
}

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

- (UINavigationController *)rootNavigationController {
    UINavigationController *rootNavi = (UINavigationController *)[[UIApplication sharedApplication].keyWindow rootViewController];
    return rootNavi;
}

@end
