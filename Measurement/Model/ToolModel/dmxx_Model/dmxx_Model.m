//
//  dmxx_Model.m
//  Measurement
//
//  Created by DTSoft on 15/1/29.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "dmxx_Model.h"

@implementation dmxx_Model

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"cjr" : @"CJR",
             @"cjsj" : @"CJSJ",
             @"dmbm":@"DMBM",
             @"dmxxmc" : @"DMXXMC",
             @"m_id" : @"ID",
             @"zdbm":@"ZDBM",
             @"zdmc" : @"ZDMC"
             
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
