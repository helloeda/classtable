//
//  LEGradeHeaderView.m
//  ZJUTHelp
//
//  Created by Eda on 16/2/4.
//  Copyright © 2016年 Eda. All rights reserved.
//

#import "LEGradeHeaderView.h"
@interface LEGradeHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *lblGPA;

@end
@implementation LEGradeHeaderView


+(instancetype)gradeHeaderView
{
    LEGradeHeaderView *gradeHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"LEGradeHeaderView" owner:nil options:nil]lastObject];
    return gradeHeaderView;
}

- (void)setGPA:(NSString *)GPA
{
    _GPA = GPA;
    self.lblGPA.text = GPA;
}

@end
