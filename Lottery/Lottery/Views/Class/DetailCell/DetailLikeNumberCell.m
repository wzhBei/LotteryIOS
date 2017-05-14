//
//  DetailLikeNumberCell.m
//  Lottery
//
//  Created by wzhnopc on 2017/5/14.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "DetailLikeNumberCell.h"
#import "FilterCellModel.h"

// TODO:追加校验
@interface DetailLikeNumberCell()

@property (weak, nonatomic) IBOutlet UITextField *n1Textfield;
@property (weak, nonatomic) IBOutlet UITextField *n2Textfield;
@property (weak, nonatomic) IBOutlet UITextField *n3Textfield;
@property (weak, nonatomic) IBOutlet UITextField *n4Textfield;
@property (weak, nonatomic) IBOutlet UITextField *n5Textfield;
@property (weak, nonatomic) IBOutlet UITextField *n6Textfield;

@property (strong, nonatomic) NSArray *textFieldAry;
@property (strong, nonatomic) NSArray *modelAry;
@property (weak, nonatomic) IBOutlet UIImageView *checkMark;

@end

@implementation DetailLikeNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.n1Textfield.keyboardType = UIKeyboardTypeNumberPad;
    self.n2Textfield.keyboardType = UIKeyboardTypeNumberPad;
    self.n3Textfield.keyboardType = UIKeyboardTypeNumberPad;
    self.n4Textfield.keyboardType = UIKeyboardTypeNumberPad;
    self.n5Textfield.keyboardType = UIKeyboardTypeNumberPad;
    self.n6Textfield.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldAry = @[self.n1Textfield, self.n2Textfield, self.n3Textfield, self.n4Textfield, self.n5Textfield, self.n6Textfield];
    
    // Initialization code
}

- (void)updateWithModels:(NSArray *)models
       textFieldDelegate:(id<UITextFieldDelegate>)delegate
               isChecked:(BOOL)isChecked {
    self.modelAry = models;
    for (int i = 0; i < models.count; i++) {
        UITextField *textField = self.textFieldAry[i];
        FilterCellModel *model = self.modelAry[i];
        textField.text = [NSString stringWithFormat:@"%ld", model.fixedValue];
        textField.tag = LuckNumberTagPrefix + model.type;
        textField.delegate = delegate;
    }
    self.checkMark.hidden = !isChecked;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
