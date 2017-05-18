//
//  ResultTableDatasource.m
//  Lottery
//
//  Created by wzhnopc on 2017/5/6.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "ResultTableDatasource.h"
#import "ResultCell.h"

@interface ResultTableDatasource()

@property (nonatomic, strong) NSArray *datasource;

@end

@implementation ResultTableDatasource

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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
