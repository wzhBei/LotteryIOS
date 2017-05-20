//
//  CheckDetailFilterViewController.m
//  Lottery
//
//  Created by wzhnopc on 2017/5/14.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "CheckDetailFilterViewController.h"
#import "DetailLikeNumberCell.h"
#import "FilterCell.h"
#import "SelectedFilterManager.h"
#import "ApiManager.h"
#import "AlertHelper.h"
#import "ResultViewController.h"
#import "UIStoryboard+Utils.h"

@interface CheckDetailFilterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonnull) NSArray *datasource;
@property (nonatomic, weak) UITextField *currentTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;

@end

@implementation CheckDetailFilterViewController

- (void)dismissKeyboard {
    [self.currentTextField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"loto6 好み条件";
    [self customizeBackbar];
    
    self.tableview.estimatedRowHeight = 150.f;
    
    NSMutableArray *ary = [NSMutableArray arrayWithArray:[SelectedFilterManager sharedInstance].allDetailSelections];
    self.datasource = ary;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"FilterCell" bundle:nil] forCellReuseIdentifier:FilterCellIdentifier];
    // Do any additional setup after loading the view.
}

- (void)customizeBackbar {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = btnItem;
}

- (void)goback:(id)sender {
    [[SelectedFilterManager sharedInstance] resetDetailSelections];
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.datasource.count ) {
        FilterCell *detailCell = [tableView dequeueReusableCellWithIdentifier:FilterCellIdentifier];
        [detailCell updateWithModel:self.datasource[indexPath.row]
                  textFieldDelegate:self
                   showCommitButton:NO];
        return detailCell;
    }
    
    DetailLikeNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailLikeNumberCellIdentifier];
    [cell updateWithModels:[SelectedFilterManager sharedInstance].allLucknumbers
         textFieldDelegate:self
                 isChecked:[SelectedFilterManager sharedInstance].luckyNumberSelected];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isShowingKeyboard) {
        [self dismissKeyboard];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    if (indexPath.row < self.datasource.count) {
        FilterCellModel *model = self.datasource[indexPath.row];
        if (![model isValid]) {
            [[AlertHelper sharedInstance] showFilterInvalidWithModel:model];
            return;
        }
        model.isChecked = !model.isChecked;
        FilterCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell updateWithModel:model
            textFieldDelegate:self
             showCommitButton:NO];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self dismissKeyboard];
        return;
    }

    if (![SelectedFilterManager sharedInstance].luckyNumbersValid) {
        [[AlertHelper sharedInstance] showLuckFilterInvalidAlert];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self dismissKeyboard];
        return;
    }
    [SelectedFilterManager sharedInstance].luckyNumberSelected = ![SelectedFilterManager sharedInstance].luckyNumberSelected;
    DetailLikeNumberCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell updateWithModels:[SelectedFilterManager sharedInstance].allLucknumbers
         textFieldDelegate:self
                 isChecked:[SelectedFilterManager sharedInstance].luckyNumberSelected];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissKeyboard];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.datasource.count) {
        return UITableViewAutomaticDimension;
    }
    return 156;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count + 1;
}

- (NSDictionary *)selectedConditionDic {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (FilterCellModel *model in self.datasource) {
        if (!model.isChecked) {
            continue;
        }
        
        [dic addEntriesFromDictionary:[model toConditionDic]];
    }
    return dic;
}

- (IBAction)showMultipleResult:(id)sender {
    if ([SelectedFilterManager sharedInstance].allSelectedConditions.count == 0) {
        [[AlertHelper sharedInstance] showAlertWithTitle:@"ご注意" message:@"Filter条件を選ばなければ、ランダムのラキー数字を生じてよろしいでようか？" ok:^{
            [self doFilter];
        } cancel:^{
        }];
        return;
    }
    [self doFilter];
}

- (void)doFilter {
    ApiManager *manager = [[ApiManager alloc] init];
    [[AlertHelper sharedInstance] showHud];
    __weak CheckDetailFilterViewController *weakSelf = self;
    [manager getLotterysWithCount:5
                     conditionDic:[SelectedFilterManager sharedInstance].allSelectedConditions sucess:^(NSArray *models) {
                         ResultViewController *resultController = (ResultViewController *)[UIStoryboard createVCWithStroyboardName:@"Main" identifier:@"ResultViewController"];
                         [resultController updateWithDatasource:models];
                         [weakSelf.navigationController pushViewController:resultController animated:YES];
                         [[AlertHelper sharedInstance] dismissHud];
                     } failed:^(NSURLSessionDataTask *task) {
                         [[AlertHelper sharedInstance] dismissHud];
                         
                     }];
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
    
    BOOL isLuckyNbrField = textField.tag >= LuckNumberTagPrefix;
    if (isLuckyNbrField) {
        NSInteger index = textField.tag - LuckNumberTagPrefix - FilterNumber1;
        
            if (index >= LuckNumberMaxPrefix) {
                index -= LuckNumberMaxPrefix;
                FilterCellModel *model = [SelectedFilterManager sharedInstance].allLucknumbers[index];
                model.max = [resultString integerValue];
            } else {
                FilterCellModel *model = [SelectedFilterManager sharedInstance].allLucknumbers[index];
                if (model.type == FilterLuckyCount) {
                    model.min = [resultString integerValue];
                } else {
                    model.fixedValue = [resultString integerValue];
                }
            }
        return YES;
    }
    
    BOOL isMaxTextField = (textField.tag - TextFieldTagMinPrefix) >= 10;
    NSInteger index = isMaxTextField ?
        textField.tag - TextFieldTagMaxPrefix - FilterNumber1 :
        textField.tag - TextFieldTagMinPrefix - FilterNumber1;
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

// Override BaseviewController
- (void)keyboardWillHideIn:(NSTimeInterval)timeInterval {
    [super keyboardWillHideIn:timeInterval];
    [UIView animateWithDuration:timeInterval animations:^{
        self.tableViewBottom.constant = 50;
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillShowIn:(NSTimeInterval)timeInterval rect:(CGRect)rect{
    [super keyboardWillShowIn:timeInterval rect:rect];
    [UIView animateWithDuration:timeInterval animations:^{
        self.tableViewBottom.constant = 50 + CGRectGetHeight(rect);
        [self.view layoutIfNeeded];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
