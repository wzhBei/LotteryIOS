//
//  ViewController.m
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "CheckFilterViewController.h"
#import "FilterTableDatasource.h"

@interface CheckFilterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
    @property (strong, nonatomic) FilterTableDatasource *datasource;

@end

@implementation CheckFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    self.datasource = [[FilterTableDatasource alloc] initWithTableView:self.tableview];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showMultipleResult:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
