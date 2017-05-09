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
    switch (self.type) {
            if (self.min > self.max) {
                return false;
            }
            
        case FilterTypeSum:
            return
            self.min >= 21 &&
            self.min <= 190 * 3 &&
            self.max > 21 &&
            self.max <= 191;
        case FilterTypeCRS:
            return
            self.min >= 5 &&
            self.min <= 35 &&
            self.max > 5 &&
            self.max <= 35;
            
        case FilterTypeODD:
            return
            self.min >= 0 &&
            self.min <= 6 &&
            self.max > 5 &&
            self.max <= 6;
        case FilterTypeINT:
            return
            self.min >= 5 &&
            self.min <= 35 &&
            self.max > 5 &&
            self.max <= 35;
        case FilterTypeCON:
            return @{
                     @"conMin" : [@(self.min) stringValue],
                     @"conMax" : [@(self.max) stringValue]
                     };
        default:
            break;
    }

    return self.max > self.min;
}

@end
