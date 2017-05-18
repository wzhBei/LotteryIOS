//
//  LotteryModel.m
//  Lottery
//
//  Created by wzhnopc on 2017/5/4.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "LotteryModel.h"
#import "NSNumber+Utils.h"

@implementation LotteryModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"lotteryNumber" : @"id",
             @"n1" : @"n1",
             @"n2" : @"n2",
             @"n3" : @"n3",
             @"n4" : @"n4",
             @"n5" : @"n5",
             @"n6" : @"n6",
             @"n7" : @"n7",
             @"sum" : @"sumValue",
             @"crs" : @"crsValue",
             @"odd" : @"oddValue",
             @"con" : @"conValue",
             @"interval" : @"intValue"
             };
}

+ (NSValueTransformer *)URLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (NSString *)lotteryNumberString {
    NSMutableArray *ary = [NSMutableArray arrayWithArray:@[self.n1.stringValue, self.n2.stringValue, self.n3.stringValue, self.n4.stringValue, self.n5.stringValue, self.n6.stringValue]];
    if (self.n7) {
        [ary addObject:self.n7.stringValue];
    }
    return [ary componentsJoinedByString:@","];
}

@end
