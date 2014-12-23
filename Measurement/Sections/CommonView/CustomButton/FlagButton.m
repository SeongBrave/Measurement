//
//  FlagButton.m
//  BedsNursingApp
//
//  Created by dt on 14-6-21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "FlagButton.h"

@implementation FlagButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.layer.cornerRadius = 10.0f;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        self.layer.cornerRadius = 10.0f;
        [self setBackgroundColor:[UIColor colorWithRed:233.0/255 green:233.0/255 blue:233.0/255 alpha:1]];
    }
    return self;
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
