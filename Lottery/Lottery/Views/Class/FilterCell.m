//
//  FilterCell.m
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "FilterCell.h"

@interface FilterCell()
    @property (weak, nonatomic) IBOutlet UIImageView *checkMark;
    @property (weak, nonatomic) IBOutlet UITextField *maxTextField;
    @property (weak, nonatomic) IBOutlet UITextField *MinTextField;
    @property (weak, nonatomic) IBOutlet UIButton *commitButton;
    @property (strong, nonatomic) FilterCellModel *model;
    @property (weak, nonatomic) IBOutlet UILabel *intputRangeLabel;
@end

@implementation FilterCell

-(void)awakeFromNib {
    [super awakeFromNib];
    self.maxTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.MinTextField.keyboardType = UIKeyboardTypeNumberPad;
    
}

- (IBAction)showResultAction:(id)sender {
    if (self.showResultblock) {
        self.showResultblock();
    }
}

- (void)updateWithModel:(FilterCellModel *)model
      textFieldDelegate:(id<UITextFieldDelegate>)delegate
       showCommitButton:(BOOL)showButton {
    self.model = model;

    self.maxTextField.text = [NSString stringWithFormat:@"%ld", model.max];
    self.MinTextField.text = [NSString stringWithFormat:@"%ld", model.min];
    self.checkMark.hidden = !model.isChecked;
    
    self.commitButton.hidden = !showButton;
    if (showButton) {
        [self.commitButton setTitle:[self buttonTitle] forState:UIControlStateNormal];
    }
    
    
    self.MinTextField.tag = TextFieldTagMinPrefix + self.model.type;
    self.maxTextField.tag = TextFieldTagMaxPrefix + self.model.type;
    
    self.MinTextField.delegate = delegate;
    self.maxTextField.delegate = delegate;
    
    self.intputRangeLabel.text = [self rangeString];
}
    
- (NSString *)buttonTitle {
    switch (self.model.type) {
        case FilterTypeSum:
            return @"SUMFilter";
        case FilterTypeCRS:
            return @"CRSFilter";
        case FilterTypeODD:
            return @"ODDFilter";
        case FilterTypeINT:
            return @"INTFilter";
        case FilterTypeCON:
            return @"CONFilter";
        default:
        return @"";
    }
}

- (NSString *)rangeString {
    NSString *rangeString;
    NSInteger min = 0;
    NSInteger max = 0;
   
    switch (self.model.type) {
        case FilterTypeSum:
        {
            min = SumMin;
            max = SumMax;
        }
            break;
        case FilterTypeCRS:
        {
            min = CrsMin;
            max = CrsMax;
        }
            break;
        case FilterTypeODD:
        {
            min = OddMin;
            max = OddMax;
        }
            break;
        case FilterTypeINT:
        {
            min = IntervalMin;
            max = IntervalMax;
        }
            break;
        case FilterTypeCON:
        {
            min = ConMin;
            max = ConMax;
        }
            break;
        default:
        {
            min = 1;
            max = 43;
        };
    }
    rangeString = [NSString stringWithFormat:@"%ld ~ %ld", min, max];
    return rangeString;
}



@end
