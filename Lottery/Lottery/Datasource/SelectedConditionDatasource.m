//
//  SelectedConditionDatasource.m
//  Lottery
//
//  Created by wangzh on 2017/05/18.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "SelectedConditionDatasource.h"
#import "ShowBaseFilterCell.h"
#import "ShowEachNumberFilterCell.h"
#import "ShowLuckyNumberCell.h"
#import "ConditionTitleTableViewCell.h"
#import "SelectedFilterCellModel.h"
#import "ConditionTitleTableViewCell.h"

@interface SelectedConditionDatasource()

// SelectedFilterCellModel
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
    SelectedFilterCellModel *model = self.datasource[indexPath.row];
    switch (model.cellType) {
        case SelectedFilterCellTypeTitle:
        {
            ConditionTitleTableViewCell *cell = (ConditionTitleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:model.reuseIdentifer];
            [cell updateWithModel:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case SelectedFilterCellTypeTitleBase:
        {
            ShowBaseFilterCell *cell = (ShowBaseFilterCell *)[tableView dequeueReusableCellWithIdentifier:model.reuseIdentifer];
            [cell updateWithModel:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case SelectedFilterCellTypeTitleEach:
        {
            ShowEachNumberFilterCell *cell = (ShowEachNumberFilterCell *)[tableView dequeueReusableCellWithIdentifier:model.reuseIdentifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell updateWithModel:model];
            return cell;
        }
            break;
        case SelectedFilterCellTypeTitleLuckNumber:
        {
            ShowLuckyNumberCell *cell = (ShowLuckyNumberCell *)[tableView dequeueReusableCellWithIdentifier:model.reuseIdentifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell updateWithModel:model];
            return cell;
        }
            break;
        default:
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectedFilterCellModel *model = self.datasource[indexPath.row];
    return model.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

@end
