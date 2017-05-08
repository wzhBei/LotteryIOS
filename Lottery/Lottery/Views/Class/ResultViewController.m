//
//  ResultViewController.m
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultTableDatasource.h"

@interface ResultViewController ()

@property (strong, nonatomic) ResultTableDatasource *datasource;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) NSArray *models;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.dataSource = self.datasource;
    self.tableview.delegate = self.datasource;
    [self.datasource updateDatasource:self.models];
    [self.tableview reloadData];

    
    
    // Do any additional setup after loading the view.
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)updateWithDatasource:(NSArray *)datasource {
    self.models = datasource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ResultTableDatasource *)datasource {
    if (!_datasource) {
        _datasource = [[ResultTableDatasource alloc] init];
    }
    return _datasource;
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
