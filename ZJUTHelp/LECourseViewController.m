//
//  ViewController.m
//  ZJUTHelp
//
//  Created by Eda on 16/1/28.
//  Copyright © 2016年 Eda. All rights reserved.
//

#import "LECourseViewController.h"
#import "BCClassButton.h"
#include "LECourse.h"
#import "LELoginViewController.h"
@interface LECourseViewController ()
@property (nonatomic, strong) NSMutableArray *courses;

@end

@implementation LECourseViewController

const float KX = 30;
const float KXInScrollView = 0;
const float KX_5s_ScrollView = 340;


#pragma mark - 懒加载数据

- (NSMutableArray *)courses
{
    if(_courses == nil)
    {
        // 1.获得沙盒根路径
        NSString *home = NSHomeDirectory();
        // 2.document路径
        NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
        // 3.文件路径
        NSString *filepath = [docPath stringByAppendingPathComponent:@"course.plist"];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:filepath];
        NSMutableArray *arrayModel = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            if (![dict[@"courseName"] isEqual: @""]) {
                LECourse *model = [LECourse courseWithDict:dict];
                [arrayModel addObject:model];
            }
        }
        _courses = arrayModel;
    }
    return _courses;
    
}


#pragma mark - 加载控制器方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    if([self judgeMent] == 0){
        self.KYScrollView = 736-64-49-45;
        self.KXScrollView = self.view.bounds.size.width - KX;//显示日期
    }
    else if([self judgeMent] == 1){
        self.KYScrollView = 667-64-49-45;
        self.KXScrollView = self.view.bounds.size.width - KX;//显示日期
    }
    else{
        self.KYScrollView = 667-64-49-45;
        self.KXScrollView = KX_5s_ScrollView;
    }
    self.KX_AVG_View = self.KXScrollView/7.0;
}

-(void) viewWillAppear:(BOOL)animated{
    [self draw];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 课程表绘制方法

- (void)draw{
    [self drawMianScreen];
    [self drawLeftTimeView];
    [self addClassToSchedule];
    [self drawTitleWeek];
}

-(void) drawMianScreen{
    const float OneClass = (self.KYScrollView)/11;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(KX,45,self.KXScrollView, self.KYScrollView)];
    
    int judgeNumber = [self judgeMent];
    if(judgeNumber == 2){
        self.scrollView.contentSize = CGSizeMake(KX_5s_ScrollView+50,self.KYScrollView+99);//5s
    }
    else if(judgeNumber == 3){
        self.scrollView.contentSize = CGSizeMake(self.KXScrollView+50,self.KYScrollView+99+88);//4s
    }
    else{
        self.scrollView.contentSize = CGSizeMake(self.KXScrollView,0);//6,6p
    }
    
    [self.scrollView setBounces:false];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor colorWithRed:244.0f/255.0f
                                                      green:246.0f/255.0f
                                                       blue:246.0f/255.0f
                                                      alpha:1.0f];
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    
    
    UILabel *SeparateLine;
    float x = 0;
    for(int i=0;i<15;i++){
        SeparateLine = [[UILabel alloc] initWithFrame:CGRectMake(0, x , 444, 0.5)];
        SeparateLine.layer.borderWidth = 1;
        SeparateLine.layer.borderColor = [[UIColor colorWithRed:0.0f/255.0f
                                                          green:0.0f/255.0f
                                                           blue:0.0f/255.0f
                                                          alpha:0.1f] CGColor];
        x+=OneClass;
        [self.scrollView addSubview:SeparateLine];
    }
    
}

//显示课程节数
-(void) drawLeftTimeView{
    
    const float OneClass = (self.KYScrollView)/11;
    self.LeftTimeView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, KX,self.KYScrollView)];
    self.LeftTimeView.backgroundColor = [UIColor colorWithRed:244.0f/255.0f
                                                        green:246.0f/255.0f
                                                         blue:246.0f/255.0f
                                                        alpha:1.0f];
    [self.view addSubview:self.LeftTimeView];
    
    UILabel *SeparateLine;
    float x = 0;
    for(int i=0;i<15;i++){
        SeparateLine = [[UILabel alloc] initWithFrame:CGRectMake(0,x,444,0.5)];
        SeparateLine.layer.borderWidth = 1;
        SeparateLine.layer.borderColor = [[UIColor colorWithRed:0.0f/255.0f
                                                          green:0.0f/255.0f
                                                           blue:0.0f/255.0f
                                                          alpha:0.1f] CGColor];
        x+=OneClass;
        [self.LeftTimeView addSubview:SeparateLine];
    }
    
    
    UILabel *HourLabel;
    x=0;
    for(int i=1;i<13;i++){
        HourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,x,30,OneClass)];
        HourLabel.textAlignment = NSTextAlignmentCenter;
        HourLabel.text = [NSString stringWithFormat:@"%d",i];
        HourLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        HourLabel.textColor = [UIColor colorWithRed:0.0f/255.0f
                                              green:0.0f/255.0f
                                               blue:0.0f/255.0f
                                              alpha:0.2f];
        x+=OneClass;
        [self.LeftTimeView addSubview:HourLabel];
    }
}

//显示星期
-(void) drawTitleWeek{
    
    self.titleWeekView = [[UIScrollView alloc] initWithFrame:CGRectMake(KX,0,self.KXScrollView,45)];
    self.titleWeekView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleWeekView];
    NSArray *WeekArray = [[NSArray alloc] initWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    UIButton *ButtonLabel;
    int x = 0;
    
    
    //星期下面的横线
    NSInteger week = [self getWeek];
    for(int i=0;i<7;i++){
        ButtonLabel = [[UIButton alloc] initWithFrame:CGRectMake(x,0,self.KX_AVG_View,45)];
        x+=self.KX_AVG_View;
        [ButtonLabel setTitle:[WeekArray objectAtIndex:i]forState:UIControlStateNormal];
        ButtonLabel.titleLabel.font = [UIFont fontWithName:@"yuanti" size: 8.0];
        if(week == i){
            [ButtonLabel setTitleColor:[UIColor colorWithRed:102.0f/255.0f
                                                       green:205.0f/255.0f
                                                        blue:0.0f/255.0f
                                                       alpha:1.0f]
                              forState:UIControlStateNormal];
            
        }else{
            [ButtonLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [self.titleWeekView addSubview:ButtonLabel];
    }
    
    UILabel *weekLine =  [[UILabel alloc] initWithFrame:CGRectMake(week * self.KX_AVG_View,43,self.KX_AVG_View,2)];
    
    weekLine.layer.borderWidth = 1;
    weekLine.layer.borderColor = [[UIColor colorWithRed:102.0f/255.0f
                                                  green:205.0f/255.0f
                                                   blue:0.0f/255.0f
                                                  alpha:1.0f] CGColor];
    weekLine.backgroundColor = [UIColor colorWithRed:102.0f/255.0f
                                               green:205.0f/255.0f
                                                blue:0.0f/255.0f
                                               alpha:1.0f];
    [self.titleWeekView addSubview:weekLine];
    
    int a = 0;
    for(int i=0;i<7;i++){
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *date = [NSDate date];
        long daysToAdd = 0;
        if(i-week<0){
            daysToAdd = 7-week+i;
        }
        else{
            daysToAdd = i-week;
        }
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        NSDateComponents *comps = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth  fromDate:newDate];
        NSInteger month = [comps month];
        NSInteger day = [comps day];
        UILabel *dateLine = [[UILabel alloc] initWithFrame:CGRectMake(a,33,self.KX_AVG_View,10)];
        if((long)day<10){
            dateLine.text = [NSString stringWithFormat:@"%ld-0%ld",(long)month,(long)day];
        }
        else{
            dateLine.text = [NSString stringWithFormat:@"%ld-%ld",(long)month,(long)day];
        }
        dateLine.font= [UIFont fontWithName:@"Helvetica" size: 10.0];
        if(week == i){
            dateLine.textColor = [UIColor colorWithRed:102.0f/255.0f
                                                 green:205.0f/255.0f
                                                  blue:0.0f/255.0f
                                                 alpha:1.0f];
        }else{
            dateLine.textColor = [UIColor blackColor];
        }
        dateLine.textAlignment = NSTextAlignmentCenter;
        [self.titleWeekView addSubview:dateLine];
        a+=self.KX_AVG_View;
    }
    
}


//添加课程
-(void) addClassToSchedule{
    
    const float OneClass = (self.KYScrollView)/11;
    
    for (LECourse *course in self.courses) {
        
        BCClassButton *button = [[BCClassButton alloc] initWithFrame:CGRectMake(KXInScrollView + self.KX_AVG_View * (course.classNo % 7 - 1),0 + course.classNo / 7 * OneClass,self.KX_AVG_View,course.classLong*OneClass)];

        switch(course.classNo%4)
        {
            case 0:
                button.backgroundColor = [UIColor colorWithRed:30.0f/255.0f
                                                         green:144.0f/255.0f
                                                          blue:250.0f/255.0f
                                                         alpha:1.0f];
                break;
            case 1:
                button.backgroundColor = [UIColor colorWithRed:144.0f/255.0f
                                                         green:123.0f/255.0f
                                                          blue:250.0f/255.0f
                                                         alpha:1.0f];
                break;
            case 2:
                button.backgroundColor = [UIColor colorWithRed:250.0f/255.0f
                                                         green:170.0f/255.0f
                                                          blue:9.0f/255.0f
                                                         alpha:1.0f];
                break;
            case 3:
                button.backgroundColor = [UIColor colorWithRed:255.0f/255.0f
                                                         green:105.0f/255.0f
                                                          blue:180.0f/255.0f
                                                         alpha:1.0f];
                break;
        }
        [button DrawButton:course.courseName ClassRoom:course.classRoom];
        [self.scrollView addSubview:button];

        }
}

#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.titleWeekView setContentOffset:CGPointMake(scrollView.contentOffset.x,0)];
    [self.LeftTimeView setContentOffset:CGPointMake(0,scrollView.contentOffset.y)];
}

-(void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
    [scrollView setContentOffset:scrollView.contentOffset animated:NO];
}

#pragma mark - 其他方法
-(NSInteger) getWeek{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSInteger weekday = [comps weekday];
    if(weekday == 1){
        weekday = 6;
    }
    else if(weekday == 7){
        weekday = 5;
    }
    else{
        weekday = weekday - 2;
    }
    return weekday;
}

-(int) judgeMent{
    if(self.view.bounds.size.height > 700){
        return 0;
    }
    else if(self.view.bounds.size.height > 600 && self.view.bounds.size.height < 700){
        return 1;
    }
    else if(self.view.bounds.size.height> 500 && self.view.bounds.size.height<600){
        return 2;
    }
    else{
        return 3;
    }
}




@end
