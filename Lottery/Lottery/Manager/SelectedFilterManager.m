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
        for (NSNumber *type in @[@(FilterNumber1), @(FilterNumber2), @(FilterNumber3), @(FilterNumber4), @(FilterNumber5), @(FilterNumber6), @(FilterLuckyCount)]) {
            FilterCellModel *model = [[FilterCellModel alloc] init];
            model.type = (FilterType)type.integerValue;
            model.isLuckNumber = YES;
            model.fixedValue = type.integerValue - 1;
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
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    NSMutableArray *temp = [NSMutableArray array];
    for (FilterCellModel *model in self.allLucknumbers) {
        if (model.type == FilterLuckyCount) {
            NSString *minString = [NSString stringWithFormat:@"%ld", model.min];
            NSString *maxString = [NSString stringWithFormat:@"%ld", model.max];
            [resultDic setValue:minString forKey:@"luckMinCount"];
            [resultDic setValue:maxString forKey:@"luckMaxCount"];
            continue;
        }
        [temp addObject:[NSString stringWithFormat:@"%ld", model.fixedValue]];
    }
    if (temp.count > 0 ) {
        [resultDic setValue:temp forKey:@"luckyNumbers"];
        return resultDic;
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
    titleModel1.title = @"確率条件";
    titleModel1.reuseIdentifer  = ConditionTitleTableViewCellIdentifier;
    SelectedFilterCellModel *titleModel2 = [[SelectedFilterCellModel alloc] init];
    titleModel2.cellType = SelectedFilterCellTypeTitle;
    titleModel2.title = @"ラキー条件";
    titleModel2.reuseIdentifer = ConditionTitleTableViewCellIdentifier;
    
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
            [result addObject:newModel];
        }
    }

    [result addObject:titleModel2];
    if (self.allDetailSelections.count > 0) {
        NSInteger validCount = 0;
        NSMutableDictionary *detailDic = [NSMutableDictionary dictionary];
        // 70
        for (FilterCellModel *model in self.allDetailSelections) {
            if (!model.isChecked) {
                continue;
            }
            NSString *key = [NSString stringWithFormat:@"N%u", model.type - 4];
            [detailDic setObject:model.toResultString forKey:key];
            validCount ++;
        }
        if (validCount > 0) {
            SelectedFilterCellModel *newModel = [[SelectedFilterCellModel alloc] init];
            newModel.cellType = SelectedFilterCellTypeTitleEach;
            newModel.selectedEacheNumbers = detailDic;
            newModel.reuseIdentifer = ShowEachNumberFilterCellIdentifier;
            [result addObject:newModel];
        }
    }
    
    if (self.luckyNumberSelected) {
        SelectedFilterCellModel *newModel = [[SelectedFilterCellModel alloc] init];
        NSMutableDictionary *luckDic = [NSMutableDictionary dictionary];
        // 70
        for (FilterCellModel *model in self.allLucknumbers) {
            if (model.type == FilterLuckyCount) {
                newModel.title = model.toResultString;
                continue;
            }
            NSString *key = [NSString stringWithFormat:@"N%u", model.type - 4];
            [luckDic setObject:model.toResultString forKey:key];
        }
        newModel.cellType = SelectedFilterCellTypeTitleLuckNumber;
        newModel.selectedLuckNumbers = luckDic;
        newModel.reuseIdentifer = ShowLuckyNumberCellIdentifier;
        [result addObject:newModel];
    }
    
    return result;
}

- (BOOL)luckyNumbersValid {
    NSMutableArray *ary = [NSMutableArray array];
    for (FilterCellModel *model in self.allLucknumbers) {
        if ([ary containsObject:@(model.fixedValue)]) {
            return NO;
        }
        [ary addObject:@(model.fixedValue)];
        if (!model.isValid) {
            return NO;
        }
    }
    return YES;
}

- (void)resetDetailSelections {
    _allDetailSelections = nil;
    _allLucknumbers = nil;
    _luckyNumberSelected = NO;
}
- (void)resetAllSelections {
    _allBaseSelections = nil;
    [self resetDetailSelections];
}
@end
