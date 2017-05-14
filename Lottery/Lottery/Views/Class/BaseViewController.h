//
//  BaseViewController.h
//  Lottery
//
//  Created by wzhnopc on 2017/5/14.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

// Override
- (void)keyboardWillHideIn:(NSTimeInterval)timeInterval;
- (void)keyboardWillShowIn:(NSTimeInterval)timeInterval rect:(CGRect)rect;

@end
