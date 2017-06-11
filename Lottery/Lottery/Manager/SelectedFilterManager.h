//
//  SelectedFilterManager.h
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppSetting.h"

@interface SelectedFilterManager : NSObject
    
SINGLETON_DEFINE(SelectedFilterManager);
    
/// [FilterCellModel]
@property (strong, nonatomic) NSArray *allBaseSelections;

@property (strong, nonatomic) NSArray *allDetailSelections;

@property (strong, nonatomic) NSArray *allExcluedSelections;

@property (strong, nonatomic) NSArray *allLucknumbers;
@property (assign, nonatomic) BOOL luckyNumberSelected;
@property (assign, nonatomic) BOOL luckyNumbersValid;

@property (strong, nonatomic, readonly) NSDictionary *allSelectedConditions;
@property (strong, nonatomic, readonly) NSDictionary *allSelectedBaseConditions;

- (void)resetDetailSelections;
- (void)resetAllSelections;
- (NSArray *)toSelectedModels;

@end
