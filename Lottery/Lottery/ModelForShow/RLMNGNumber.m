//
//  RLMNGNumber.m
//  Lottery
//
//  Created by wzhnopc on 2017/6/11.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "RLMNGNumber.h"

@implementation RLMNGNumber

+ (NSString *)primaryKey {
    return @"numberID";
}

+ (NSArray<NSString *> *)ignoredProperties {
    return @[@"isChecked"];
}
@end
