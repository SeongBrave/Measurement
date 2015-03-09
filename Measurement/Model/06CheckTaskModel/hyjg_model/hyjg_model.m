//
//  hyjg_model.m
//  Measurement
//
//  Created by DTSoft on 15/3/9.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "hyjg_model.h"

@implementation hyjg_model


/**
 *  用于显示tableviewcell的数据，光显示一个text
 *
 *  @return textlabel要显示的数据
 */
- (NSString *)getShowCellForTextLabel
{
    return self.m_showTitle;
}

@end
