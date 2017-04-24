//
//  AppSetting.h
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

typedef enum {
    FilterTypeSum = 0,
    FilterTypeCRS = 1,
    FilterTypeODD = 2,
    FilterTypeINT = 3,
    FilterTypeCON = 4
} FilterType;

#import <Foundation/Foundation.h>

// singletonクラス定義用共通部品
#ifndef Singleton_h
#define Singleton_h

#define SINGLETON_IMPL( classname )\
+ (classname *)sharedInstance\
{\
static dispatch_once_t onceToken;\
static classname *_sharedInstance = nil;\
dispatch_once(&onceToken, ^{\
_sharedInstance = [[[self class] alloc] init];\
});\
return _sharedInstance;\
}

#define SINGLETON_DEFINE( classname )\
+ (classname *)sharedInstance;

#endif

@interface AppSetting : NSObject

    
@end
