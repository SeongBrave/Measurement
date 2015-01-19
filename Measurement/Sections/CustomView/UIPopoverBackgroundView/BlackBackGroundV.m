//
//  BlackBackGroundV.m
//  Measurement
//
//  Created by DTSoft on 15/1/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "BlackBackGroundV.h"
#define kArrowBase 0.0f
#define kArrowHeight 0.0f
#define kBorderInset 0.0f

@implementation BlackBackGroundV
@synthesize arrowDirection  = _arrowDirection;
@synthesize arrowOffset     = _arrowOffset;
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //TODO:添加背景色，在initWithFrame:方法的条件语句中添加如下代码
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

+ (UIEdgeInsets)contentViewInsets
{
    return UIEdgeInsetsMake(kBorderInset, kBorderInset, kBorderInset,       kBorderInset);
}
+ (BOOL)wantsDefaultContentAppearance
{
    return NO;
}
+ (CGFloat)arrowBase
{
    return kArrowBase;
}

/* Describes the distance between each edge of the background view and the corresponding edge of its content view (i.e. if it were strictly a rectangle).
 */


+ (CGFloat)arrowHeight
{
    return kArrowHeight;
}


@end
