//
//  ResultTableDatasource.h
//  Lottery
//
//  Created by wzhnopc on 2017/5/6.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableDatasource : NSObject<UITableViewDelegate, UITableViewDataSource>

// LotteryModel
- (void)updateDatasource:(NSArray *)datasource;

@end
