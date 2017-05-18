//
//  ShowLuckyNumberCell.h
//  Lottery
//
//  Created by wzhnopc on 2017/5/14.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedFilterCellModel.h"

static NSString* const ShowLuckyNumberCellIdentifier = @"ShowLuckyNumberCell";

@interface ShowLuckyNumberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *n1Label;
@property (weak, nonatomic) IBOutlet UILabel *n2Label;
@property (weak, nonatomic) IBOutlet UILabel *n3Label;
@property (weak, nonatomic) IBOutlet UILabel *n4Label;
@property (weak, nonatomic) IBOutlet UILabel *n5Label;
@property (weak, nonatomic) IBOutlet UILabel *n6Label;

- (void)updateWithModel:(SelectedFilterCellModel *)model;

@end
