//
//  ShowEachNumberFilterCell.h
//  Lottery
//
//  Created by wzhnopc on 2017/5/14.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedFilterCellModel.h"

static NSString* const ShowEachNumberFilterCellIdentifier = @"ShowEachNumberFilterCell";

// height 90
@interface ShowEachNumberFilterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;

- (void)updateWithModel:(SelectedFilterCellModel *)model;

@end
