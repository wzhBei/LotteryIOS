//
//  SelectedFilterManager.m
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "SelectedFilterManager.h"
#import "FilterCellModel.h"
#import "SelectedFilterCellModel.h"
#import "ShowBaseFilterCell.h"
#import "ShowEachNumberFilterCell.h"
#import "ShowLuckyNumberCell.h"
#import "ConditionTitleTableViewCell.h"

@interface SelectedFilterManager()

    
@end

@implementation SelectedFilterManager

SINGLETON_IMPL(SelectedFilterManager);
    
- (NSArray *)allBaseSelections {
    if (!_allBaseSelections) {
        NSMutableArray *ary = [NSMutableArray array];
        for (NSNumber *type in @[@(FilterTypeSum), @(FilterTypeCRS), @(FilterTypeODD), @(FilterTypeINT), @(FilterTypeCON)]) {
            FilterCellModel *model = [[FilterCellModel alloc] init];
            model.type = (FilterType)type.integerValue;
            [ary addObject:model];
            
        }
        _allBaseSelections = [NSArray arrayWithArray:ary];
    }
    return _allBaseSelections;
}

- (NSArray *)allDetailSelections {
    if (!_allDetailSelections) {
        NSMutableArray *ary = [NSMutableArray array];
        for (NSNumber *type in @[@(FilterNumber1), @(FilterNumber2), @(FilterNumber3), @(FilterNumber4), @(FilterNumber5), @(FilterNumber6)]) {
            FilterCellModel *model = [[FilterCellModel alloc] init];
            model.type = (FilterType)type.integerValue;
            [ary addObject:model];
            
        }
        _allDetailSelections = [NSArray arrayWithArray:ary];
    }
    return _allDetailSelections;
}

- (NSArray *)allLucknumbers {
    if (!_allLucknumbers) {
        NSMutableArray *ary = [NSMutableArray array];
        for (NSNumber *type in @[@(FilterNumber1), @(FilterNumber2), @(FilterNumber3), @(FilterNumber4), @(FilterNumber5), @(FilterNumber6)]) {
            FilterCellModel *model = [[FilterCellModel alloc] init];
            model.type = (FilterType)type.integerValue;
            model.isLuckNumber = YES;
            // TODO:
            [ary addObject:model];
        }
        _allLucknumbers = [NSArray arrayWithArray:ary];
    }
    return _allLucknumbers;
}

- (NSDictionary *)allSelectedConditions {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *allSelection = [NSMutableArray array];
    [allSelection addObjectsFromArray:self.allBaseSelections];
    [allSelection addObjectsFromArray:self.allDetailSelections];
    for (FilterCellModel *model in allSelection) {
        if (!model.isChecked) {
            continue;
        }
        
        [dic addEntriesFromDictionary:[model toConditionDic]];
    }
    if (self.luckyNumberSelected) {
        [dic addEntriesFromDictionary:[self allLuckNumberConditions]];
    }
    
    return dic;
}   

- (NSDictionary *)allLuckNumberConditions {
    NSMutableArray *temp = [NSMutableArray array];
    for (FilterCellModel *model in self.allLucknumbers) {
        if (model.fixedValue != 0) {
            [temp addObject:[NSString stringWithFormat:@"%ld", model.fixedValue]];
        }
    }
    if (temp.count > 0 ) {
        return @{
                    @"luckyNumbers" : temp
                 };
    }
    return @{};
}

- (NSDictionary *)allSelectedBaseConditions {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (FilterCellModel *model in self.allBaseSelections) {
        if (!model.isChecked) {
            continue;
        }
        
        [dic addEntriesFromDictionary:[model toConditionDic]];
    }
    return dic;
}

- (NSArray *)toSelectedModels {
    //SelectedFilterCellModel
    SelectedFilterCellModel *titleModel1 = [[SelectedFilterCellModel alloc] init];
    titleModel1.cellType = SelectedFilterCellTypeTitle;
    titleModel1.title = @"基礎条件";
    titleModel1.height = 20.f;
    titleModel1.reuseIdentifer  = ConditionTitleTableViewCellIdentifier;
    SelectedFilterCellModel *titleModel2 = [[SelectedFilterCellModel alloc] init];
    titleModel2.cellType = SelectedFilterCellTypeTitle;
    titleModel2.title = @"詳細条件";
    titleModel2.reuseIdentifer = ConditionTitleTableViewCellIdentifier;
    titleModel2.height = 20.f;
    
    NSMutableArray *result = [NSMutableArray array];
    [result addObject:titleModel1];
    if (self.allBaseSelections.count > 0) {
        for (FilterCellModel *model in self.allBaseSelections) {
            if (!model.isChecked) {
                continue;
            }
            SelectedFilterCellModel *newModel = [[SelectedFilterCellModel alloc] init];
            newModel.cellType = SelectedFilterCellTypeTitleBase;
            newModel.title = [model toResultString];
            newModel.reuseIdentifer = ShowBaseFilterCellIdentifier;
            newModel.height = 40.f;
            [result addObject:newModel];
        }
    }

    [result addObject:titleModel2];
    if (self.allDetailSelections.count > 0) {
        NSMutableDictionary *detailDic = [NSMutableDictionary dictionary];
        // 70
        for (FilterCellModel *model in self.allDetailSelections) {
            if (!model.isChecked) {
                continue;
            }
            NSString *key = [NSString stringWithFormat:@"N%u", model.type - 4];
            [detailDic setObject:model.toResultString forKey:key];
        }
        SelectedFilterCellModel *newModel = [[SelectedFilterCellModel alloc] init];
        newModel.cellType = SelectedFilterCellTypeTitleEach;
        newModel.height = 70.f;
        newModel.selectedEacheNumbers = detailDic;
        newModel.reuseIdentifer = ShowEachNumberFilterCellIdentifier;
        [result addObject:newModel];
    }
    
    if (self.luckyNumberSelected) {
        NSMutableDictionary *luckDic = [NSMutableDictionary dictionary];
        // 70
        for (FilterCellModel *model in self.allLucknumbers) {
            NSString *key = [NSString stringWithFormat:@"N%u", model.type - 4];
            [luckDic setObject:model.toResultString forKey:key];
        }
        SelectedFilterCellModel *newModel = [[SelectedFilterCellModel alloc] init];
        newModel.cellType = SelectedFilterCellTypeTitleLuckNumber;
        newModel.height = 100.f;
        newModel.selectedLuckNumbers = luckDic;
        newModel.reuseIdentifer = ShowLuckyNumberCellIdentifier;
        [result addObject:newModel];
    }
    
    return result;
}

- (void)resetDetailSelections {
    _allDetailSelections = nil;
    _allLucknumbers = nil;
}
- (void)resetAllSelections {
    _allBaseSelections = nil;
    [self resetDetailSelections];
}
@end
