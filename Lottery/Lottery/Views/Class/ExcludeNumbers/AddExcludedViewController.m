//
//  AddExcludedViewController.m
//  Lottery
//
//  Created by wzhnopc on 2017/6/4.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "AddExcludedViewController.h"
#import "RLMNGNumber.h"
#import "RLMManager.h"
#import "AlertHelper.h"

const NSInteger TagPrefix = 3000;

@interface AddExcludedViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfiled1;
@property (weak, nonatomic) IBOutlet UITextField *textfiled2;
@property (weak, nonatomic) IBOutlet UITextField *textfiled3;
@property (weak, nonatomic) IBOutlet UITextField *textfiled4;
@property (weak, nonatomic) IBOutlet UITextField *textfiled5;
@property (weak, nonatomic) IBOutlet UITextField *textfiled6;

@end

@implementation AddExcludedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    if (![self isvalid]) {
        [self presentViewController:[[AlertHelper sharedInstance] oldNuberValidAlertOk:^{
        }] animated:YES completion:nil]; ;
        return;
    }
    RLMNGNumber *nbr = [[RLMNGNumber alloc] init];
    nbr.n1 = self.textfiled1.text;
    nbr.n2 = self.textfiled2.text;
    nbr.n3 = self.textfiled3.text;
    nbr.n4 = self.textfiled4.text;
    nbr.n5 = self.textfiled5.text;
    nbr.n6 = self.textfiled6.text;
    [[RLMManager sharedInstance] saveNGModel:nbr];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)isvalid {
    NSArray *tfAry = @[self.textfiled1,self.textfiled2,
                         self.textfiled3,self.textfiled4,
                         self.textfiled5,self.textfiled6];
    for (UITextField *tf in tfAry) {
        if (tf.text.length == 0) {
            return NO;
        }
    }
    for (int i = 1; i < tfAry.count; i ++) {
        UITextField *old = tfAry[i -1];
        UITextField *new = tfAry[i];
        if (old.text.integerValue >= new.text.integerValue) {
            return NO;
        }
    }
    return YES;
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
