//
//  SelectedFilterCellModel.m
//  Lottery
//
//  Created by wangzh on 2017/05/18.
//  Copyright © 2017年 wzh.personally. All rights reserved.
//

#import "SelectedFilterCellModel.h"

@implementation SelectedFilterCellModel

- (CGFloat)height {

    switch (self.cellType) {
        case SelectedFilterCellTypeTitle:
            return 20.f;
;
            break;
        case SelectedFilterCellTypeTitleBase:
            return 40.f;
            break;
        case SelectedFilterCellTypeTitleEach:
        {
            if (self.selectedEacheNumbers.count > 3) {
                return 70.f;
            }
            return 40.f;
        }
            break;
        case SelectedFilterCellTypeTitleLuckNumber:
            return 100.f;
            break;
    }
}

@end
