//
//  AlertHelper.h
//  Lottery
//
//  Created by wzhnopc on 2017/5/6.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSetting.h"


@interface AlertHelper : NSObject

SINGLETON_DEFINE(AlertHelper);

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                        ok:(void(^)())okAction
                    cancel:(void(^)())cancelAction;

- (void)showHud;

- (void)dismissHud;

@end
