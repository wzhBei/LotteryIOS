//
//  FilterCell.h
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterCellModel.h"

static NSString* const FilterCellIdentifier = @"FilterCell";

@interface FilterCell : UITableViewCell

@property (nonatomic, copy) void(^showResultblock)();
    
    - (void)updateWithModel:(FilterCellModel *)model;
    
@end
