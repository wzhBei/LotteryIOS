//
//  ShowEachNumberFilterCell.m
//  Lottery
//
//  Created by wzhnopc on 2017/5/14.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "ShowEachNumberFilterCell.h"
#import "UIColor+Utils.h"

@interface ShowEachNumberFilterCell()

@property (nonatomic, strong) SelectedFilterCellModel *model;
@property (nonatomic, strong) NSArray *eachNumberTitles;

@end

@implementation ShowEachNumberFilterCell

-(void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor L_Blue];
}

- (void)updateWithModel:(SelectedFilterCellModel *)model {
    self.model = model;
    for (int i = 0 ; i < self.eachNumberTitles.count; i++) {
        NSString *str = self.eachNumberTitles[i];
        UILabel *label = [[self labelArray] objectAtIndex:i];
        label.text = str;
    }
    [self labelShowOrHidden];
    
}

- (void)labelShowOrHidden {
    for(int i= 0; i < 6; i++) {
        UILabel *label = [self labelArray][i];
        label.hidden = i > self.eachNumberTitles.count - 1;
    }
}

- (NSArray *)labelArray {
    if (self.label1 != nil) {
        return @[self.label1, self.label2, self.label3, self.label4, self.label5, self.label6];
    }
    return nil;
}

- (NSString *)titleForKey:(NSString *)key {
    NSString *value = self.model.selectedEacheNumbers[key];
    return value;
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
