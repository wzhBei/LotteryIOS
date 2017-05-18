//
//  ConditionTitleTableViewCell.h
//  Lottery
//
//  Created by wangzh on 2017/05/18.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedFilterCellModel.h"

static NSString* const ConditionTitleTableViewCellIdentifier = @"ConditionTitleTableViewCell";

// height30
@interface ConditionTitleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (void)updateWithModel:(SelectedFilterCellModel *)model;

@end
