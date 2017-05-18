//
//  SelectedFilterCellModel.h
//  Lottery
//
//  Created by wangzh on 2017/05/18.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppSetting.h"

@interface SelectedFilterCellModel : NSObject

@property (assign, nonatomic) SelectedFilterCellType cellType;
@property (assign, nonatomic) CGFloat height;

@property (strong, nonatomic) NSString *title;

// -------------
// {"N1" : "5~10"}
@property (strong, nonatomic) NSDictionary *selectedEacheNumbers;

// -------------
// {"N1" : @(1)}
@property (strong, nonatomic) NSDictionary *selectedLuckNumbers;
// "3~6"
@property (assign, nonatomic) NSString *luckyNumberRange;

@end
