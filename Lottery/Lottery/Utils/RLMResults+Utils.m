//
//  RLMResults+Utils.m
//  Lottery
//
//  Created by wzhnopc on 2017/6/11.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "RLMResults+Utils.h"

@implementation RLMResults (Utils)

- (NSArray *)toArray {
    NSMutableArray *ary = [NSMutableArray array];
    for (NSObject *obj in self) {
        [ary addObject:obj];
    }
    return ary;
}

@end
