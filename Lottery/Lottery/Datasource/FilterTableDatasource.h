//
//  FilterTableDatasource.h
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSetting.h"

@interface FilterTableDatasource : NSObject<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong, readonly) NSDictionary *selectedConditions;
@property (nonatomic, assign) BOOL isShowingKeyboard;

- (instancetype)initWithTableView:(UITableView *)tableView;
    @property (weak, nonatomic) UIViewController *delegateController;

- (void)dismissKeyboard;


@end
