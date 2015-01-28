//
//  Yqmc_Auto_Model.m
//  Measurement
//
//  Created by DTSoft on 15/1/28.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "Yqmc_Auto_Model.h"

@implementation Yqmc_Auto_Model


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"bj" : @"BJ",
             @"by5" : @"BY5",
             @"clfw":@"CLFW",
             @"dw" : @"DW",
             @"ggxh" : @"GGXH",
             @"jclx":@"JCLX",
             @"jlqjbh" : @"JLQJBH",
             @"jlqjmc" : @"JLQJMC",
             @"jltx":@"JLTX",
             @"sfbzid" : @"SFBZID",
             @"ssks" : @"SSKS"
             
             };
}

/**
 *  用于显示tableviewcell的数据，光显示一个text
 *
 *  @return textlabel要显示的数据
 */
- (NSString *)autocompleteString
{
    return self.jlqjmc;
}

@end
