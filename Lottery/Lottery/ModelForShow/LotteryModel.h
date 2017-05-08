//
//  LotteryModel.h
//  Lottery
//
//  Created by wzhnopc on 2017/5/4.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface LotteryModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *lotteryNumber;
@property (nonatomic, copy, readonly) NSNumber *n1;
@property (nonatomic, copy, readonly) NSNumber *n2;
@property (nonatomic, copy, readonly) NSNumber *n3;
@property (nonatomic, copy, readonly) NSNumber *n4;
@property (nonatomic, copy, readonly) NSNumber *n5;
@property (nonatomic, copy, readonly) NSNumber *n6;
@property (nonatomic, copy, readonly) NSNumber *n7;

@property (nonatomic, copy, readonly) NSNumber *sum;
@property (nonatomic, copy, readonly) NSNumber *crs;
@property (nonatomic, copy, readonly) NSNumber *odd;
@property (nonatomic, copy, readonly) NSNumber *con;
@property (nonatomic, copy, readonly) NSNumber *interval;


- (NSString *)lotteryNumberString;

@end
