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
    
- (NSArray *)allSelections {
    if (!_allSelections) {
        NSMutableArray *ary = [NSMutableArray array];
        for (NSNumber *type in @[@(0), @(1), @(2), @(3), @(4)]) {
            FilterCellModel *model = [[FilterCellModel alloc] init];
            model.type = (FilterType)type.integerValue;
            [ary addObject:model];
            
        }
        _allSelections = [NSArray arrayWithArray:ary];
    }
    return _allSelections;
}
    
@end
