//
//  SelectedConditionDatasource.h
//  Lottery
//
//  Created by wangzh on 2017/05/18.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedConditionDatasource : NSObject<UITableViewDelegate, UITableViewDataSource>

- (void)updateDatasource:(NSArray *)datasource;

@end
