//
//  LEGradeCell.m
//  ZJUTHelp
//
//  Created by Eda on 16/2/4.
//  Copyright © 2016年 Eda. All rights reserved.
//

#import "LEGradeCell.h"
#import "LEGrade.h"
@interface LEGradeCell()
@property (weak, nonatomic) IBOutlet UILabel *lblCourseName;
@property (weak, nonatomic) IBOutlet UILabel *lblProperties;
@property (weak, nonatomic) IBOutlet UILabel *lblGrade;
@property (weak, nonatomic) IBOutlet UILabel *lblCredit;

@end
@implementation LEGradeCell


- (void)setGrades:(LEGrade *)grades
{
    
    
    _grades = grades;
    self.lblCourseName.text = grades.courseName;
    self.lblProperties.text = grades.properties;
    self.lblGrade.text = [NSString stringWithFormat:@"%@",grades.grade];
    self.lblCredit.text = [NSString stringWithFormat:@"%.1f",grades.credit];
}


+(instancetype)gradeCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"grades_cell";
    LEGradeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LEGradeCell" owner:nil options:nil] firstObject];
    }
    return cell;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
