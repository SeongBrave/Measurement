//
//  Qjyt_dmxx_Model.m
//  Measurement
//
//  Created by DTSoft on 15/3/16.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "Qjyt_dmxx_Model.h"

@implementation Qjyt_dmxx_Model


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"cjr" : @"cjr",
             @"cjsj" : @"cjsj",
             @"dmbm":@"dmbm",
             @"dmxxmc" : @"dmxxmc",
             @"m_id" : @"id",
             @"zdbm":@"zdbm",
             @"zdmc" : @"zdmc"
             
             };
}

/**
 *  用于显示tableviewcell的数据，光显示一个text
 *
 *  @return textlabel要显示的数据
 */
- (NSString *)getShowCellForTextLabel
{
    return self.dmxxmc;
}

@end
