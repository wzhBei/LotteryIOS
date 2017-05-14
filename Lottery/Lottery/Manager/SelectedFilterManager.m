//
//  SelectedFilterManager.m
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "SelectedFilterManager.h"
#import "FilterCellModel.h"

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
            // TODO:
            model.fixedValue = type.integerValue;
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
    return dic;
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

- (void)resetDetailSelections {
    _allDetailSelections = nil;
    _allLucknumbers = nil;
}
- (void)resetAllSelections {
    _allBaseSelections = nil;
    [self resetDetailSelections];
}
@end
