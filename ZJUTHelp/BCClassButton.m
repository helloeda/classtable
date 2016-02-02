//
//  BCClassButton.m
//  MUSTBEE
//
//  Created by zbc on 15/10/19.
//  Copyright © 2015年 zbc. All rights reserved.
//

#import "BCClassButton.h"

@implementation BCClassButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

- (void) DrawButton:(NSString *)className ClassRoom:(NSString *)ClassRoom{
    UILabel *ClassNameLabel;
    UILabel *PlaceLabel;
    ClassNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10,40)];
    [ClassNameLabel setNumberOfLines:3];
    ClassNameLabel.textAlignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont boldSystemFontOfSize:11];
    ClassNameLabel.font = font;
    ClassNameLabel.text = className;
    ClassNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:ClassNameLabel];
    
    PlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,self.frame.size.height - 40, self.frame.size.width-10,40)];
    [PlaceLabel setNumberOfLines:2];
    PlaceLabel.font = font;
    PlaceLabel.text = ClassRoom;
    PlaceLabel.textAlignment = NSTextAlignmentCenter;
    PlaceLabel.textColor = [UIColor whiteColor];
    [self addSubview:PlaceLabel];

}

@end
