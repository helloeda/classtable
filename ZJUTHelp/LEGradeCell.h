//
//  LEGradeCell.h
//  ZJUTHelp
//
//  Created by Eda on 16/2/4.
//  Copyright © 2016年 Eda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEGrade.h"
@class LEGrade;
@interface LEGradeCell : UITableViewCell
+ (instancetype)gradeCellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) LEGrade *grades;
@end
