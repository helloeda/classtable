//
//  ViewController.h
//  ZJUTHelp
//
//  Created by Eda on 16/1/28.
//  Copyright © 2016年 Eda. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>



@interface LECourseViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIScrollView *titleWeekView;
@property (nonatomic,strong) UIScrollView *LeftTimeView;
@property float KYScrollView;
@property float KXScrollView;
@property float KX_AVG_View;

@end
