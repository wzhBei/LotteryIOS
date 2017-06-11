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
    NSString *alertString = [NSString stringWithFormat:@"%@で絞り込む場合に、入力数値は正確性をご確認してくだい。", [model conditionString]];
    [[AlertHelper sharedInstance] showAlertWithTitle:@"確認" message:alertString ok:^{
    } cancel:nil];
}

- (void)showLuckFilterInvalidAlert {
    [[AlertHelper sharedInstance] showAlertWithTitle:@"確認" message:@"ラキー数字また限定範囲入力不正ですが、ご確認してください。" ok:^{
    } cancel:nil];
}

- (UIAlertController *)oldNuberValidAlertOk:(void(^)())okAction {
    return [self alertWithTitle:@"注意" message:@"昇順で全部数字をご入力してください。" ok:okAction cancel:nil];
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

- (UIAlertController *)alertWithTitle:(NSString *)title
                   message:(NSString *)message
                        ok:(void(^)())okAction
                    cancel:(void(^)())cancelAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (okAction) {
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            okAction();
        }];
        [alertController addAction:ok];
    }
    
    if (cancelAction) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            cancelAction();
            
        }];
        [alertController addAction:cancel];
    }
    return alertController;
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
