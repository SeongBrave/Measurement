//
//  CustomButton.m
//  BedsNursingApp
//
//  Created by dt on 14-6-21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(NSMutableDictionary *)m_info
{
    if (_m_info == nil) {
        _m_info = [[NSMutableDictionary alloc]init];
    }
    return _m_info;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
