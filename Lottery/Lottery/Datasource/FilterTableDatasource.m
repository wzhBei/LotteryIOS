//
//  FilterTableDatasource.m
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "FilterTableDatasource.h"
#import "FilterCell.h"
#import "SelectedFilterManager.h"
#import "ResultViewController.h"
#import "UIStoryboard+Utils.h"
#import "AlertHelper.h"
#import "CheckFilterViewController.h"
#import "ApiManager.h"

@interface FilterTableDatasource()

@property (nonatomic, strong) NSArray *datasource;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UITextField *currentTextField;

@end

@implementation FilterTableDatasource

- (void)dismissKeyboard {
    [self.currentTextField resignFirstResponder];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [tableView registerNib:[UINib nibWithNibName:@"FilterCell" bundle:nil] forCellReuseIdentifier:FilterCellIdentifier];
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:FilterCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak FilterTableDatasource *weakSelf = self;
    __weak FilterCellModel *model = self.datasource[indexPath.row];

    cell.showResultblock = ^ {
        if (model.isValid) {
            [weakSelf doFilterWithModel:model];
        } else {
            [[AlertHelper sharedInstance] showFilterInvalidWithModel:model];
            return;
        }
    };
    [cell updateWithModel:model
        textFieldDelegate:self
         showCommitButton:YES];
    return cell;
}

- (void)doFilterWithModel:(FilterCellModel *)model {
    ApiManager *manager = [[ApiManager alloc] init];
    [[AlertHelper sharedInstance] showHud];
    __weak CheckFilterViewController *weakSelf = (CheckFilterViewController *)self.delegateController;
    [manager getLotterysWithCount:5
                     conditionDic:model.toConditionDic sucess:^(NSArray *models) {
                         ResultViewController *resultController = (ResultViewController *)[UIStoryboard createVCWithStroyboardName:@"Main" identifier:@"ResultViewController"];
                         [resultController updateWithDatasource:models];
                         [weakSelf.navigationController pushViewController:resultController animated:YES];
                         [[AlertHelper sharedInstance] dismissHud];
                     } failed:^(NSURLSessionDataTask *task) {
                         [[AlertHelper sharedInstance] dismissHud];
                         
                     }];
}

- (NSArray *)datasource {
    return [SelectedFilterManager sharedInstance].allBaseSelections;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 156;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.isShowingKeyboard) {
        [self dismissKeyboard];
        return;
    }
    FilterCellModel *model = self.datasource[indexPath.row];
    if (![model isValid]) {
        [[AlertHelper sharedInstance] showFilterInvalidWithModel:model];
        return;
    }
    model.isChecked = !model.isChecked;
    FilterCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell updateWithModel:model
        textFieldDelegate:self
         showCommitButton:YES];
    [self dismissKeyboard];
}

#pragma mark TextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
   
    NSString *resultString = @"";
    if ([textField.text hasPrefix:@"0"] || textField.text.length == 0) {
        textField.text = @"";
    }
    
    // 删除的场合
    if (string.length == 0) {
        NSString *currentString = textField.text;
        if (currentString.length > 0) {
            NSString *subedString = [currentString substringToIndex:currentString.length -1];
            resultString = subedString;
        }
    } else {
        NSString *currentString = textField.text;
        resultString = [currentString stringByAppendingString:string];
    }
    
    BOOL isMaxTextField = (textField.tag - TextFieldTagMinPrefix) >= 10;
    NSInteger index = isMaxTextField ? textField.tag - TextFieldTagMaxPrefix : textField.tag - TextFieldTagMinPrefix;
    FilterCellModel *model = self.datasource[index];
    
    if(isMaxTextField) {
        model.max = [resultString integerValue];
    } else {
        model.min = [resultString integerValue];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentTextField = textField;
}

- (NSDictionary *)selectedConditions {
    return [SelectedFilterManager sharedInstance].allSelectedBaseConditions;
}



@end
