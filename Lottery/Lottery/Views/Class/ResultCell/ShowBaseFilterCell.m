//
//  ShowBaseFilterCell.m
//  Lottery
//
//  Created by wzhnopc on 2017/5/14.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "ShowBaseFilterCell.h"
#import "UIColor+Utils.h"

@implementation ShowBaseFilterCell

- (void)updateWithModel:(SelectedFilterCellModel *)model {
    self.filterNameLabel.text = model.title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor L_Orange];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
