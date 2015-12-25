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
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype) CourseWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}



@end
