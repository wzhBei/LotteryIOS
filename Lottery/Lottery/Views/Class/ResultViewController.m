//
//  ResultViewController.m
//  Lottery
//
//  Created by wzhnopc on 2017/4/23.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultTableDatasource.h"
#import "SelectedConditionDatasource.h"
#import "SelectedFilterManager.h"

static const NSInteger ConditionTableMinHeight = 50;
static const NSInteger ConditionTableMaxHeight = 200;
static const NSTimeInterval AnimationInterval = 0.35;
static const float MaskAlpha = 0.2;

@interface ResultViewController ()

@property (strong, nonatomic) ResultTableDatasource *datasource;
@property (strong, nonatomic) SelectedConditionDatasource *conditionDatasource;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITableView *conditionTableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conditionTableHeight;
@property (weak, nonatomic) IBOutlet UIView *conditionMaskView;
@property (weak, nonatomic) IBOutlet UIView *resultTableMask;

@property (strong, nonatomic) NSArray *models;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"結果";
    self.tableview.dataSource = self.datasource;
    self.tableview.delegate = self.datasource;
    [self.datasource updateDatasource:self.models];
    [self.tableview reloadData];

    self.conditionDatasource = [[SelectedConditionDatasource alloc] init];
    self.conditionTableview.dataSource = self.conditionDatasource;
    self.conditionTableview.delegate = self.conditionDatasource;
    [self.conditionDatasource updateDatasource:[[SelectedFilterManager sharedInstance] toSelectedModels]];
    
    UITapGestureRecognizer *conditionTapGs = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideOrShowConditionTable:)];
    [self.conditionMaskView addGestureRecognizer:conditionTapGs];
    
    UITapGestureRecognizer *resultMaskTapGs = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideResutlMask)];
    [self.resultTableMask addGestureRecognizer:resultMaskTapGs];
    // Do any additional setup after loading the view.
}

- (void)hideOrShowConditionTable:(UITapGestureRecognizer *)gs {
    NSInteger conditionTableHeight = [self showingConditionTable] ? ConditionTableMinHeight : ConditionTableMaxHeight;
    double conditionMaskAlpha = [self showingConditionTable] ? 0 : MaskAlpha;
    self.conditionMaskView.hidden = ![self showingConditionTable];

    [UIView animateWithDuration:AnimationInterval animations:^{
        self.conditionTableHeight.constant = conditionTableHeight;
        self.resultTableMask.alpha = conditionMaskAlpha;
        [self.view layoutIfNeeded];
    }];
    
    
}

- (void)hideResutlMask {
    [UIView animateWithDuration:AnimationInterval animations:^{
        self.conditionMaskView.hidden = NO;
        self.resultTableMask.alpha = 0;
        self.conditionTableHeight.constant = ConditionTableMinHeight;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (BOOL)showingConditionTable {
    return self.conditionTableHeight.constant > ConditionTableMinHeight;
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
