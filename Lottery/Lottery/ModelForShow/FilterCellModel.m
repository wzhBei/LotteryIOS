//
//  FilterCellModel.m
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "FilterCellModel.h"

@implementation FilterCellModel

- (NSDictionary *)toConditionDic {
    if (![self isValid]) {
        return @{};
    }
    
    switch (self.type) {
        case FilterTypeSum:
            return @{
                     @"sumMin" : [@(self.min) stringValue],
                     @"sumMax" : [@(self.max) stringValue]
                     };
        case FilterTypeCRS:
            return @{
                     @"crsMin" : [@(self.min) stringValue],
                     @"crsMax" : [@(self.max) stringValue]
                     };
        case FilterTypeODD:
            return @{
                     @"oddMin" : [@(self.min) stringValue],
                     @"oddMax" : [@(self.max) stringValue]
                     };
        case FilterTypeINT:
            return @{
                     @"intMin" : [@(self.min) stringValue],
                     @"intMax" : [@(self.max) stringValue]
                     };
        case FilterTypeCON:
            return @{
                     @"conMin" : [@(self.min) stringValue],
                     @"conMax" : [@(self.max) stringValue]
                     };
        case FilterNumber1:
        case FilterNumber2:
        case FilterNumber3:
        case FilterNumber4:
        case FilterNumber5:
        case FilterNumber6:
            return
            @{
              [NSString stringWithFormat:@"MinN%u", self.type - 4] : [@(self.min) stringValue],
              [NSString stringWithFormat:@"MaxN%u", self.type - 4] : [@(self.max) stringValue]
              };
        default:
            return @{};
    }
}

- (BOOL)isValid {
    if (self.min > self.max) {
        return false;
    }
    switch (self.type) {
        case FilterTypeSum:
            return
                self.min >= SumMin &&
                self.min <= SumMax &&
                self.max >= SumMin &&
                self.max <= SumMax;
        case FilterTypeCRS:
            return
                self.min >= CrsMin &&
                self.min <= CrsMax &&
                self.max >= CrsMin &&
                self.max <= CrsMax;
            
        case FilterTypeODD:
            return
                self.min >= OddMin &&
                self.min <= OddMax &&
                self.max >= OddMin &&
                self.max <= OddMax;
        case FilterTypeINT:
            return
                self.min >= IntervalMin &&
                self.min <= IntervalMax &&
                self.max >= IntervalMin &&
                self.max <= IntervalMax;
        case FilterTypeCON:
            return
                self.min >= ConMin &&
                self.min <= ConMax &&
                self.max >= ConMin &&
                self.max <= ConMax;
        case FilterNumber1:
        case FilterNumber2:
        case FilterNumber3:
        case FilterNumber4:
        case FilterNumber5:
        case FilterNumber6:
        {
            if (self.isLuckNumber) {
                return self.fixedValue >= NumberMin && self.fixedValue <= NumberMax;
            }
            return
            self.min >= NumberMin &&
            self.min <= NumberMax &&
            self.max >= NumberMin &&
            self.max <= NumberMax;
        }
            
        case FilterLuckyCount:
            return
            self.min >= 1 &&
            self.min <= 6 &&
            self.max >= 1 &&
            self.min <= 6;
    }
    
}

- (void)setType:(FilterType)type {
    _type = type;
    switch (type) {
        case FilterTypeSum:
        {
            self.min = SumMin;
            self.max = SumMax;
        }
            break;
        case FilterTypeCRS:
        {
            self.min = CrsMin;
            self.max = CrsMax;
        }
            break;
        case FilterTypeODD:
        {
            self.min = OddMin;
            self.max = OddMax;
        }
            break;
        case FilterTypeINT:
        {
            self.min = IntervalMin;
            self.max = IntervalMax;
        }
            break;
        case FilterTypeCON:
        {
            self.min = ConMin;
            self.max = ConMax;
        }
            break;
            
        case FilterNumber1:
        case FilterNumber2:
        case FilterNumber3:
        case FilterNumber4:
        case FilterNumber5:
        case FilterNumber6:
        {
            self.min = NumberMin;
            self.max = NumberMax;
        }
            break;
        case FilterLuckyCount:
        {
            self.min = 1;
            self.max = 6;
        }
            break;
    }
}

- (NSString *)conditionDescription {
    switch (self.type) {
        case FilterTypeSum:
            return @"-----合計限定-----";
        case FilterTypeCRS:
            return @"-----全幅限定-----";
        case FilterTypeODD:
            return @"-----奇数限定-----";
        case FilterTypeINT:
            return @"-----間隔限定-----";
        case FilterTypeCON:
            return @"-----連番限定-----";
        case FilterNumber1:
        case FilterNumber2:
        case FilterNumber3:
        case FilterNumber4:
        case FilterNumber5:
        case FilterNumber6:
            return [NSString stringWithFormat:@"-----Number%u 限定-----", (self.type - 4)];
        default:
            return @"";
    }
}

- (NSString *)conditionString {
    switch (self.type) {
        case FilterTypeSum:
            return @"SUM";
        case FilterTypeCRS:
            return @"CRS";
        case FilterTypeODD:
            return @"ODD";
        case FilterTypeINT:
            return @"INTERVAL";
        case FilterTypeCON:
            return @"CON";
        case FilterNumber1:
        case FilterNumber2:
        case FilterNumber3:
        case FilterNumber4:
        case FilterNumber5:
        case FilterNumber6:
            return [NSString stringWithFormat:@"Number:%u", (self.type - 4)];
        default:
            return @"";
    }
}

/// 结果画面条件list显示的字符串
- (NSString *)toResultString {
    NSString *rangeString = [NSString stringWithFormat:@"%ldから%ldまで", self.min, self.max];
    switch (self.type) {
        case FilterTypeSum:
        case FilterTypeCRS:
        case FilterTypeODD:
        case FilterTypeINT:
        case FilterTypeCON:
             return [NSString stringWithFormat:@"%@:  %@", self.conditionString,rangeString];
        case FilterNumber1:
        case FilterNumber2:
        case FilterNumber3:
        case FilterNumber4:
        case FilterNumber5:
        case FilterNumber6: {
            if (self.isLuckNumber) {
                return [NSString stringWithFormat:@"%ld",self.fixedValue];
            }
            return [NSString stringWithFormat:@"Number%u: %ld ~ %ld", (self.type - 4), self.min, self.max];
        }
        case FilterLuckyCount:
            return [NSString stringWithFormat:@"下記%ld ~ %ld のラキー数字が含まれています。", self.min, self.max];
    }
}

@end
