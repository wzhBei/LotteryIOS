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
#import "RLMManager.h"
#import "RLMResults+Utils.h"
#import "AddExcludedViewController.h"
#import "UIStoryboard+Utils.h"

@interface ExcludeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *minCountTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *datasource;
@end

@implementation ExcludeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // datasource 初始化
    self.datasource = [NSMutableArray arrayWithArray:[[RLMNGNumber allObjects] toArray]];
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selecteAll:(id)sender {
}

- (IBAction)unselectAll:(id)sender {
}

- (IBAction)showResult:(id)sender {
}

#pragma mark - Delegate && Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count + 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NGNumbersContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NGNumbersContentCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (self.datasource.count == 0 || indexPath.row > self.datasource.count) {
        NGNumbersAddCell *cell = [tableView dequeueReusableCellWithIdentifier:NGNumbersAddCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    NGNumbersContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NGNumbersContentCellIdentifier];
    [cell updateWithModel:self.datasource[indexPath.row - 1]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return;
    }
    if (self.datasource.count == 0 || indexPath.row > self.datasource.count) {
        AddExcludedViewController *vc = (AddExcludedViewController *)[UIStoryboard createVCWithStroyboardName:@"Main" identifier:@"AddExcludedViewController"];
        [self.navigationController presentViewController:vc animated:YES completion:nil];
        return;
    }
    RLMNGNumber *nbrNumber = self.datasource[indexPath.row - 1];
    nbrNumber.isChecked = !nbrNumber.isChecked;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 50;
    }
    if (self.datasource.count == 0 || indexPath.row > self.datasource.count) {
        return 50;
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[RLMManager sharedInstance] removeNGModel:self.datasource[indexPath.row - 1]];
        [self.datasource removeObjectAtIndex:indexPath.row - 1];
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
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
