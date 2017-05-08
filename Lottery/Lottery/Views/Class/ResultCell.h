//
//  ResultCell.h
//  Lottery
//
//  Created by wzhnopc on 2017/5/4.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryModel.h"

static NSString* const ResultCellIdentifier = @"ResultCell";

@interface ResultCell : UITableViewCell

- (void)updateCellWithModel:(LotteryModel *)lotteryModel;

@end
