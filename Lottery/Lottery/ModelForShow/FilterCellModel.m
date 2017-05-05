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
                     @"sumMin" : @(self.min),
                     @"sumMax" : @(self.max)
                     };
        case FilterTypeCRS:
            return @{
                     @"crsMin" : @(self.min),
                     @"crsMax" : @(self.max)
                     };
        case FilterTypeODD:
            return @{
                     @"oddMin" : @(self.min),
                     @"oddMax" : @(self.max)
                     };
        case FilterTypeINT:
            return @{
                     @"intMin" : @(self.min),
                     @"intMax" : @(self.max)
                     };
        case FilterTypeCON:
            return @{
                     @"conMin" : @(self.min),
                     @"conMax" : @(self.max)
                     };
        default:
            break;
    }
}

- (BOOL)isValid {
    return self.max > self.min;
}

@end
