//
//  ShowLuckyNumberCell.m
//  Lottery
//
//  Created by wzhnopc on 2017/5/14.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "ShowLuckyNumberCell.h"
#import "UIColor+Utils.h"

@interface ShowLuckyNumberCell()

@property (nonatomic, strong) SelectedFilterCellModel *model;
@property (nonatomic, strong) NSArray *eachNumberTitles;

@end

@implementation ShowLuckyNumberCell

-(void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor L_Green];
}

- (void)updateWithModel:(SelectedFilterCellModel *)model {
    self.model = model;
    for (int i = 0 ; i < self.eachNumberTitles.count; i++) {
        NSString *str = self.eachNumberTitles[i];
        UILabel *label = [[self labelArray] objectAtIndex:i];
        label.text = str;
    }
    self.titleLabel.text = model.title;
}

- (NSArray *)labelArray {
    if (self.n1Label != nil) {
        return @[self.n1Label, self.n2Label, self.n3Label, self.n4Label, self.n5Label, self.n6Label];
    }
    return nil;
}

- (NSArray *)eachNumberTitles {
    if (!_eachNumberTitles) {
        NSMutableArray *ary = [NSMutableArray array];
        for (int i = 1; i < 7; i ++) {
            NSString *eachString = [self titleForKey:[NSString stringWithFormat:@"N%d", i]];
            if (eachString) {
                [ary addObject:eachString];
            }
        }
        _eachNumberTitles = ary;
    }
    return _eachNumberTitles;
}

- (NSString *)titleForKey:(NSString *)key {
    NSString *value = self.model.selectedLuckNumbers[key];
    return value;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
