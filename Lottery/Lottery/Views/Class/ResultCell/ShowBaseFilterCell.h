//
//  ShowBaseFilterCell.h
//  Lottery
//
//  Created by wzhnopc on 2017/5/14.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedFilterCellModel.h"

static NSString* const ShowBaseFilterCellIdentifier = @"ShowBaseFilterCell";

@interface ShowBaseFilterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *filterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ConditionLabel;

- (void)updateWithModel:(SelectedFilterCellModel *)model;

@end
