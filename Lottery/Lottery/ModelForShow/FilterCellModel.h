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
@property (nonatomic, assign) BOOL isLuckNumber;

@property (nonatomic, assign) NSInteger fixedValue;

- (NSDictionary *)toConditionDic;

- (BOOL)isValid;

- (NSString *)conditionString;

// 转换成结果画面需要的字符川
- (NSString *)toResultString;

@end
