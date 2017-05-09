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

@interface CheckFilterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) FilterTableDatasource *datasource;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonBottom;

@end

@implementation CheckFilterViewController

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.datasource dismissKeyboard];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Loto6";
    self.navigationController.navigationBarHidden = NO;
     self.automaticallyAdjustsScrollViewInsets = NO;
    self.datasource = [[FilterTableDatasource alloc] initWithTableView:self.tableview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)keyboardWillShow:(NSNotification *)notification {
    if (self.buttonBottom.constant > 0) {
        return;
    }
    // 获取通知的信息字典
    NSDictionary *userInfo = [notification userInfo];
    
    // 获取键盘弹出后的rect
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    // 获取键盘弹出动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.buttonBottom.constant = CGRectGetHeight(keyboardRect);
        [self.view layoutIfNeeded];
    }];

    // do something...
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    // 获取通知信息字典
    NSDictionary* userInfo = [notification userInfo];
    
    // 获取键盘隐藏动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.buttonBottom.constant = 0;
        [self.view layoutIfNeeded];
    }];
    
}

- (IBAction)showMultipleResult:(id)sender {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
