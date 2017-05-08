//
//  ResultCell.m
//  Lottery
//
//  Created by wzhnopc on 2017/5/4.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "ResultCell.h"

@interface ResultCell()
@property (weak, nonatomic) IBOutlet UILabel *nbrLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet UILabel *crsLabel;
@property (weak, nonatomic) IBOutlet UILabel *oddLabel;
@property (weak, nonatomic) IBOutlet UILabel *intLabel;
@property (weak, nonatomic) IBOutlet UILabel *conLabel;

@end

@implementation ResultCell

- (void)updateCellWithModel:(LotteryModel *)lotteryModel {
    self.nbrLabel.text = lotteryModel.lotteryNumberString;
    self.sumLabel.text = [NSString stringWithFormat:@"%ld", lotteryModel.sum.integerValue];
    self.crsLabel.text = [NSString stringWithFormat:@"%ld", lotteryModel.crs.integerValue];
    self.oddLabel.text = [NSString stringWithFormat:@"%ld", lotteryModel.odd.integerValue];
    self.intLabel.text = [NSString stringWithFormat:@"%ld", lotteryModel.interval.integerValue];
    self.conLabel.text = [NSString stringWithFormat:@"%ld", lotteryModel.con.integerValue];
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
