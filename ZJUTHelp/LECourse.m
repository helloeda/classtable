//
//  LECourse.m
//  reg
//
//  Created by Eda on 15/12/22.
//  Copyright © 2015年 Eda. All rights reserved.
//

#import "LECourse.h"

@implementation LECourse
-(instancetype) initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        self.classNo = [dict[@"classNo"] intValue];
        self.courseName = dict[@"courseName"];
        self.classLong = [dict[@"classLong"] intValue];
        self.coursePeriod = [dict[@"coursePeriod"] isEqual:@""]?  @" ":dict[@"coursePeriod"];
        self.teacher = [dict[@"teacher"] isEqual:@""]?  @" ":dict[@"teacher"];
        self.classRoom = [dict[@"classRoom"] isEqual:@""]?  @" ":dict[@"classRoom"];
    }
    return self;
}
+(instancetype) courseWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}



@end
