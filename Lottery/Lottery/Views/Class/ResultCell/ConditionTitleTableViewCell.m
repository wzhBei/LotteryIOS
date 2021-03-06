//
//  ConditionTitleTableViewCell.m
//  Lottery
//
//  Created by wangzh on 2017/05/18.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "ConditionTitleTableViewCell.h"

@implementation ConditionTitleTableViewCell

- (void)updateWithModel:(SelectedFilterCellModel *)model {
    self.titleLabel.text = model.title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
