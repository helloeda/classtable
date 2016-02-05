//
//  LEGrade.m
//  ZJUTHelp
//
//  Created by Eda on 16/2/4.
//  Copyright © 2016年 Eda. All rights reserved.
//

#import "LEGrade.h"

@implementation LEGrade
-(instancetype) initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        self.courseName = dict[@"courseName"];
        self.grade = dict[@"grade"];
        self.credit = [dict[@"credit"] floatValue];
        self.properties = [dict[@"properties"] isEqual:@""]?  @" ":dict[@"properties"];
        self.courseTerm = [dict[@"courseTerm"] isEqual:@""]?  @" ":dict[@"courseTerm"];

    }
    return self;
}
+(instancetype) gradeWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
