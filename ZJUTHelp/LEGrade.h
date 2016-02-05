//
//  LEGrade.h
//  ZJUTHelp
//
//  Created by Eda on 16/2/4.
//  Copyright © 2016年 Eda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEGrade : NSObject

@property (nonatomic, copy) NSString *courseName;
@property (nonatomic, copy) NSString *courseTerm;
@property (nonatomic, copy) NSString *properties;
@property (nonatomic, copy) NSString *grade;
@property (atomic,assign) float credit;

-(instancetype) initWithDict:(NSDictionary *)dict;
+(instancetype) gradeWithDict:(NSDictionary *)dict;
@end

