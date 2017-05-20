//
//  ViewController.m
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "CheckFilterViewController.h"
#import "FilterTableDatasource.h"
#import "ApiManager.h"
#import "UIStoryboard+Utils.h"
#import "AlertHelper.h"
#import "ResultViewController.h"
#import "AppSetting.h"
#import "CheckDetailFilterViewController.h"
#import "SelectedFilterManager.h"

@interface CheckFilterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) FilterTableDatasource *datasource;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewBottom;

@end

@implementation CheckFilterViewController

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.datasource dismissKeyboard];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeBackbar];
    self.title = @"loto6 確率条件";
    self.navigationController.navigationBarHidden = NO;
     self.automaticallyAdjustsScrollViewInsets = NO;
    self.datasource = [[FilterTableDatasource alloc] initWithTableView:self.tableview];
    self.datasource.delegateController = self;
    

    
    // Do any additional setup after loading the view, typically from a nib.
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
    [[SelectedFilterManager sharedInstance] resetAllSelections];
    [self.navigationController popViewControllerAnimated:YES];
    
}

// Override BaseviewController
- (void)keyboardWillHideIn:(NSTimeInterval)timeInterval {
    [super keyboardWillHideIn:timeInterval];
    self.datasource.isShowingKeyboard = self.isShowingKeyboard;
    [UIView animateWithDuration:timeInterval animations:^{
        self.tableviewBottom.constant = 50;
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillShowIn:(NSTimeInterval)timeInterval rect:(CGRect)rect{
    [super keyboardWillShowIn:timeInterval rect:rect];
    self.datasource.isShowingKeyboard = self.isShowingKeyboard;
    [UIView animateWithDuration:timeInterval animations:^{
        self.tableviewBottom.constant = CGRectGetHeight(rect) + 50;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)showMultipleResult:(id)sender {
    if (self.datasource.selectedConditions.count == 0) {
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
    __weak CheckFilterViewController *weakSelf = self;
    [manager getLotterysWithCount:5
                     conditionDic:self.datasource.selectedConditions sucess:^(NSArray *models) {
                         ResultViewController *resultController = (ResultViewController *)[UIStoryboard createVCWithStroyboardName:@"Main" identifier:@"ResultViewController"];
                         [resultController updateWithDatasource:models];
                         [weakSelf.navigationController pushViewController:resultController animated:YES];
                         [[AlertHelper sharedInstance] dismissHud];
                     } failed:^(NSURLSessionDataTask *task) {
                         [[AlertHelper sharedInstance] dismissHud];
                         
                     }];
}

- (IBAction)toDetailFiters:(id)sender {
    CheckDetailFilterViewController *detailVC = (CheckDetailFilterViewController *)[UIStoryboard createVCWithStroyboardName:@"Main" identifier:@"CheckDetailFilterViewController"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
