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
    FilterTypeCON = 4,
    FilterNumber1 = 5,
    FilterNumber2 = 6,
    FilterNumber3 = 7,
    FilterNumber4 = 8,
    FilterNumber5 = 9,
    FilterNumber6 = 10,
    FilterLuckyCount = 11
} FilterType;

typedef enum {
    SelectedFilterCellTypeTitle = 0,
    SelectedFilterCellTypeTitleBase = 1,
    SelectedFilterCellTypeTitleEach = 2,
    SelectedFilterCellTypeTitleLuckNumber = 3
    
} SelectedFilterCellType;

#define WEAK_SELF __weak typeof(self) SELF = self

#define NumberMin 1
#define NumberMax 43

#define SumMax 191
#define SumMin  21

#define  CrsMax 42
#define  CrsMin 5

#define  OddMax 6
#define  OddMin 0

#define  IntervalMax 37
#define  IntervalMin 1

#define  ConMax 6
#define  ConMin 0

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
