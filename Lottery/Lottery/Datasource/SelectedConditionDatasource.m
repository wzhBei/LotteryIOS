//
//  SelectedConditionDatasource.m
//  Lottery
//
//  Created by wangzh on 2017/05/18.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "SelectedConditionDatasource.h"

@interface SelectedConditionDatasource()

@property (strong, nonatomic) NSArray *datasource;

@end

@implementation SelectedConditionDatasource

// LotteryModel
- (void)updateDatasource:(NSArray *)datasource {
    self.datasource = datasource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:ResultCellIdentifier];
    
    LotteryModel *model = self.datasource[indexPath.row];
    [cell updateCellWithModel:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 216;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

@end
