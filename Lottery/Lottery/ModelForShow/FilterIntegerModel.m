//
//  FilterIntegerModel.m
//  Lottery
//
//  Created by wangzh on 2017/05/05.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "FilterIntegerModel.h"
#import "FilterCellModel.h"

@interface FilterIntegerModel()

@property (nonatomic, strong) NSArray *models;

@end

@implementation FilterIntegerModel

- (instancetype)initWithFilterCellModels:(NSArray *)models {
    self = [super init];
    self.models = models;
    return self;
}

- (NSDictionary *)toParameterDic {
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    for (FilterCellModel *filterModel in self.models) {
        [mutDic setValuesForKeysWithDictionary:[filterModel toConditionDic]];
    }
        
    return mutDic;
}

@end
