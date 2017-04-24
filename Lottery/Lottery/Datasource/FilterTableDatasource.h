//
//  FilterTableDatasource.h
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSetting.h"

@interface FilterTableDatasource : NSObject<UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithTableView:(UITableView *)tableView;
    @property (weak, nonatomic) UIViewController *delegateController;
    
@end
