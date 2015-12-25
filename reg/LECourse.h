//
//  LECourse.h
//  reg
//
//  Created by Eda on 15/12/22.
//  Copyright © 2015年 Eda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LECourse : NSObject
@property (atomic,assign) int classNo;
@property (nonatomic, copy) NSString *courseName;
@property (nonatomic, copy) NSString *coursePeriod;
@property (nonatomic, copy) NSString *classRoom;
@property (nonatomic, copy) NSString *teacher;

-(instancetype) initWithDict:(NSDictionary *)dict;
+(instancetype) CourseWithDict:(NSDictionary *)dict;
@end
