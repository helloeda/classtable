//
//  LEGradeViewController.m
//  ZJUTHelp
//
//  Created by Eda on 16/2/4.
//  Copyright © 2016年 Eda. All rights reserved.
//

#import "LEGradeViewController.h"
#import "LEGrade.h"
#import "LEGradeCell.h"
#import "LEGradeHeaderView.h"
@interface LEGradeViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *gradeTableView;
@property (nonatomic, strong) NSMutableArray *grades;

@end

@implementation LEGradeViewController

#pragma mark - 懒加载数据

- (NSMutableArray *)grades
{
    if(_grades == nil)
    {
        // 1.获得沙盒根路径
        NSString *home = NSHomeDirectory();
        // 2.document路径
        NSString *docPath = [home stringByAppendingPathComponent:@"tmp"];
        // 3.文件路径
        NSString *filepath = [docPath stringByAppendingPathComponent:@"grade.plist"];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:filepath];
        NSMutableArray *arrayModel = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            if ((![dict[@"courseName"] isEqual: @""])&&(![dict[@"grade"] isEqual: @""])&&(![dict[@"credit"] isEqual: @""])) {
                LEGrade *model = [LEGrade gradeWithDict:dict];
                [arrayModel addObject:model];
            }
        }
        _grades = arrayModel;
    }
    return _grades;
    
}

- (NSString *)CalGPA{
    float sumGradePoint=0;
    float GradePoint=0;
    float sumCredit=0;
    for (LEGrade *oneGrade in self.grades) {
        
        if ([oneGrade.grade isEqual:@"优秀"]) {
            GradePoint = 4.5;
        }
        else if ([oneGrade.grade isEqual:@"良好"]) {
            GradePoint = 3.5;
        }
        else if ([oneGrade.grade isEqual:@"中等"]) {
            GradePoint = 2.5;
        }
        else if ([oneGrade.grade isEqual:@"及格"]) {
            GradePoint = 1.5;
        }
        else if ([oneGrade.grade isEqual:@"不及格"]) {
            GradePoint = 0;
        }
        else {
            GradePoint = ([oneGrade.grade intValue] <60 ? 0:([oneGrade.grade intValue]-50.0)/10);
        }
        sumGradePoint += GradePoint * oneGrade.credit;
        sumCredit += oneGrade.credit;
    }
    
    NSString *GPA = [NSString stringWithFormat:@"%.3f",sumGradePoint/sumCredit];
    return GPA;
}
#pragma mark - 加载控制器方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat: @"%@学期成绩",[[self.grades firstObject] courseTerm]];
    self.gradeTableView.showsVerticalScrollIndicator = FALSE;
    self.gradeTableView.rowHeight = 110;
    LEGradeHeaderView *gradeHeaderView =[LEGradeHeaderView gradeHeaderView];
    gradeHeaderView.GPA = [self CalGPA];
    self.gradeTableView.tableHeaderView = gradeHeaderView;
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.grades.count;
  
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. 获取数据模型
    LEGrade *model = self.grades[indexPath.row];
    //2. 通过xib方式创建单元格
    LEGradeCell *cell = [LEGradeCell gradeCellWithTableView:tableView];
    //3. 把模型数据设置给单元格
    cell.grades= model;
    //4. 返回cell
    return cell;
    
}

@end
