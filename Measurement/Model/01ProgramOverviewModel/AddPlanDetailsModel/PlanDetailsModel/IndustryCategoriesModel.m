//
//  IndustryCategoriesModel.m
//  Measurement
//
//  Created by DTSoft on 15/1/7.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "IndustryCategoriesModel.h"

@implementation IndustryCategoriesModel


/**
 *  用于显示tableviewcell的数据，光显示一个text
 *
 *  @return textlabel要显示的数据
 */
- (NSString *)getShowCellForTextLabel
{
    return self.m_data[@"DMXXMC"];
}
@end
