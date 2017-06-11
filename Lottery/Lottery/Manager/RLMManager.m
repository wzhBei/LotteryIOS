//
//  RLMManager.m
//  Lottery
//
//  Created by wzhnopc on 2017/6/11.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "RLMManager.h"

@implementation RLMManager

SINGLETON_IMPL(RLMManager);

- (void)saveNGModel:(RLMNGNumber *)nbrModel {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [RLMNGNumber createOrUpdateInRealm:realm withValue:nbrModel];
    [realm commitWriteTransaction];
}

- (void)removeNGModel:(RLMNGNumber *)nbrModel {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:nbrModel];
    [realm commitWriteTransaction];
}

@end
