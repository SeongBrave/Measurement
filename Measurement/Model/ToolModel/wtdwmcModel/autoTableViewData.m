//
//  autoTableViewData.m
//  Measurement
//
//  Created by DTSoft on 15/1/5.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "autoTableViewData.h"

@implementation autoTableViewData



/**
 *  用于显示tableviewcell的数据，光显示一个text
 *
 *  @return textlabel要显示的数据
 */
- (NSString *)autocompleteString
{
    //返回dict中需要显示的数据
    return self.m_dict[@"WTDWMC"];
}
@end
