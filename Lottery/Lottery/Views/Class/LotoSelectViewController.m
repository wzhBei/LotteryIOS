//
//  LotoSelectViewController.m
//  Lottery
//
//  Created by wzhnopc on 2017/5/14.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "LotoSelectViewController.h"
#import "UIStoryboard+Utils.h"
#import "CheckFilterViewController.h"

@interface LotoSelectViewController ()

@end

@implementation LotoSelectViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ToLoto6Action:(id)sender {
    CheckFilterViewController *resultController = (CheckFilterViewController *)[UIStoryboard createVCWithStroyboardName:@"Main" identifier:@"CheckFilterViewController"];
    [self.navigationController pushViewController:resultController animated:YES];
}

- (IBAction)ToLoto7Action:(id)sender {
    
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
