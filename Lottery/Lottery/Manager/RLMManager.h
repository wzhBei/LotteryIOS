//
//  RLMManager.h
//  Lottery
//
//  Created by wzhnopc on 2017/6/11.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLMNGNumber.h"
#import "AppSetting.h"

@interface RLMManager : NSObject

SINGLETON_DEFINE(RLMManager);

- (void)saveNGModel:(RLMNGNumber *)nbrModel;
- (void)removeNGModel:(RLMNGNumber *)nbrModel;

@end
