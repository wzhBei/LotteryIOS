//
//  FilterCellModel.h
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppSetting.h"

@interface FilterCellModel : NSObject

@property (nonatomic, assign) NSInteger max;
@property (nonatomic, assign) NSInteger min;
@property (nonatomic, assign) BOOL isChecked;
@property (nonatomic, assign) FilterType type;

- (NSDictionary *)toConditionDic;

- (BOOL)isValid;

- (NSString *)conditionString;

@end
