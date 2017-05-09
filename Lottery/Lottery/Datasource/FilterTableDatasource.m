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
    cell.showResultblock = ^ {
            ResultViewController *resultController = (ResultViewController *)[UIStoryboard createVCWithStroyboardName:@"Main" identifier:@"ResultViewController"];
            [weakSelf.delegateController.navigationController pushViewController:resultController animated:YES];
    };
    FilterCellModel *model = self.datasource[indexPath.row];
    [cell updateWithModel:model textFieldDelegate:self];
    return cell;
}

- (NSArray *)datasource {
    return [SelectedFilterManager sharedInstance].allSelections;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterCellModel *model = self.datasource[indexPath.row];
    model.isChecked = !model.isChecked;
    FilterCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell updateWithModel:model textFieldDelegate:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (FilterCellModel *model in self.datasource) {
        if (!model.isChecked) {
            continue;
        }
        
        [dic addEntriesFromDictionary:[model toConditionDic]];
    }
    return dic;
}



@end
