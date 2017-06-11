//
//  NGNumbersContentCell.h
//  Lottery
//
//  Created by wzhnopc on 2017/6/4.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLMNGNumber.h"

static NSString *const NGNumbersContentCellIdentifier = @"NGNumbersContentCell";

@interface NGNumbersContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nbr1Label;
@property (weak, nonatomic) IBOutlet UILabel *nbr1Label2;
@property (weak, nonatomic) IBOutlet UILabel *nbr1Label3;
@property (weak, nonatomic) IBOutlet UILabel *nbr1Label4;
@property (weak, nonatomic) IBOutlet UILabel *nbr1Label5;
@property (weak, nonatomic) IBOutlet UILabel *nbr1Label6;
@property (weak, nonatomic) IBOutlet UIImageView *checkMark;

- (void)updateWithModel:(RLMNGNumber *)model;

@end
