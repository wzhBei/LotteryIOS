//
//  FilterTableDatasource.m
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "FilterTableDatasource.h"
#import "FilterCell.h"
#import "SelectedFilterManager.h"
#import "ResultViewController.h"
#import "UIStoryboard+Utils.h"

@interface FilterTableDatasource()

@property (nonatomic, strong) NSArray *datasource;
    @property (nonatomic, weak) UITableView *tableView;
@end

@implementation FilterTableDatasource
    
    - (instancetype)initWithTableView:(UITableView *)tableView {
        self = [super init];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        self.tableView = tableView;
        
        return self;
    }
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.datasource.count;
    }
    
    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:FilterCellIdentifier];
        __weak FilterTableDatasource *weakSelf = self;
        cell.showResultblock = ^ {
            ResultViewController *resultController = [UIStoryboard createVCWithStroyboardName:@"Main" identifier:@"ResultViewController"];
            [weakSelf.delegateController.navigationController pushViewController:resultController animated:YES];
        };
        FilterCellModel *model = self.datasource[indexPath.row];
        [cell updateWithModel:model];
        return cell;
    }
    
    - (NSArray *)datasource {
        return [SelectedFilterManager sharedInstance].allSelections;
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 100;
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 0.1f;
    }
    
    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        FilterCellModel *model = self.datasource[indexPath.row];
        model.isChecked = !model.isChecked;
        FilterCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell updateWithModel:model];
    }
    
@end
