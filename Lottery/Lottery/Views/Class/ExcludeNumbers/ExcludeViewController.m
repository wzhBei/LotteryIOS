//
//  ExcludeViewController.m
//  Lottery
//
//  Created by wzhnopc on 2017/5/29.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "ExcludeViewController.h"
#import "NGNumbersAddCell.h"
#import "NGNumbersContentCell.h"

@interface ExcludeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *minCountTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *datasource;
@end

@implementation ExcludeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // datasource 初始化
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selecteAll:(id)sender {
}

- (IBAction)unselectAll:(id)sender {
}

#pragma mark - Delegate && Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.datasource.count) {
        NGNumbersAddCell *cell = tableView dequeueReusableCellWithIdentifier:NGNumbersContentCellIdentifier
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 216;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
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
