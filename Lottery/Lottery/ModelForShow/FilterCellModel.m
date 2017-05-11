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
        default:
            break;
    }
}

- (BOOL)isValid {
    if (self.min >= self.max) {
        return false;
    }
    switch (self.type) {
        case FilterTypeSum:
            return
                self.min >= SumMin &&
                self.min < SumMax &&
                self.max > SumMin &&
                self.max <= SumMax;
        case FilterTypeCRS:
            return
                self.min >= CrsMin &&
                self.min < CrsMax &&
                self.max > CrsMin &&
                self.max <= CrsMax;
            
        case FilterTypeODD:
            return
                self.min >= OddMin &&
                self.min < OddMax &&
                self.max > OddMin &&
                self.max <= OddMax;
        case FilterTypeINT:
            return
                self.min >= IntervalMin &&
                self.min < IntervalMax &&
                self.max > IntervalMin &&
                self.max <= IntervalMax;
        case FilterTypeCON:
            return
                self.min >= IntervalMin &&
                self.min < IntervalMax &&
                self.max > IntervalMin &&
                self.max <= IntervalMax;
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
    }
}
@end
