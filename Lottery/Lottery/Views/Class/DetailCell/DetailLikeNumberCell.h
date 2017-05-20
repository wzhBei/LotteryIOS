//
//  DetailLikeNumberCell.h
//  Lottery
//
//  Created by wzhnopc on 2017/5/14.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSInteger const LuckNumberTagPrefix = 2000;
static NSInteger const LuckNumberMaxPrefix = 200;
static NSString* const DetailLikeNumberCellIdentifier = @"DetailLikeNumberCell";

@interface DetailLikeNumberCell : UITableViewCell

- (void)updateWithModels:(NSArray *)models
       textFieldDelegate:(id<UITextFieldDelegate>)delegate
               isChecked:(BOOL)isChecked;

@end
