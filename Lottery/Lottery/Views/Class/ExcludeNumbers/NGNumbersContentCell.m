//
//  NGNumbersContentCell.m
//  Lottery
//
//  Created by wzhnopc on 2017/6/4.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "NGNumbersContentCell.h"

// Height 85
@implementation NGNumbersContentCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.checkMark.hidden = YES;
    // Initialization code
}

- (void)updateWithModel:(RLMNGNumber *)model {
    self.nbr1Label.text = model.n1;
    self.nbr1Label2.text = model.n2;
    self.nbr1Label3.text = model.n3;
    self.nbr1Label4.text = model.n4;
    self.nbr1Label5.text = model.n5;
    self.nbr1Label6.text = model.n6;
    self.checkMark.hidden = !model.isChecked;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
