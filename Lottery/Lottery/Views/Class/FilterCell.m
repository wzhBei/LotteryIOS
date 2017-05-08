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
    @property (weak, nonatomic) FilterCellModel *model;
@end

@implementation FilterCell

-(void)awakeFromNib {
    [super awakeFromNib];
    self.maxTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.MinTextField.keyboardType = UIKeyboardTypeNumberPad;
    
//    self.MinTextField.placeholder = @"0";
//    self.maxTextField.placeholder = @"0";
}

- (IBAction)showResultAction:(id)sender {
    if (self.showResultblock) {
        self.showResultblock();
    }
}

- (void)updateWithModel:(FilterCellModel *)model
      textFieldDelegate:(id<UITextFieldDelegate>)delegate {
    self.model = model;

    self.maxTextField.text = [NSString stringWithFormat:@"%ld", model.max];
    self.MinTextField.text = [NSString stringWithFormat:@"%ld", model.min];
    self.checkMark.hidden = !model.isChecked;
    [self.commitButton setTitle:[self buttonTitle] forState:UIControlStateNormal];
    
    self.MinTextField.tag = TextFieldTagMinPrefix + self.model.type;
    self.maxTextField.tag = TextFieldTagMaxPrefix + self.model.type;
    
    self.MinTextField.delegate = delegate;
    self.maxTextField.delegate = delegate;
    

}
    
- (NSString *)buttonTitle {
    switch (self.model.type) {
        case FilterTypeSum:
            return @"SUM过滤";
        case FilterTypeCRS:
            return @"CRS过滤";
        case FilterTypeODD:
            return @"ODD过滤";
        case FilterTypeINT:
            return @"INT过滤";
        case FilterTypeCON:
            return @"CON过滤";
        default:
        return @"";
    }
}


@end
