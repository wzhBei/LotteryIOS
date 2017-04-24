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
    @property (strong, nonatomic) NSArray *allSelections;
    
@end
