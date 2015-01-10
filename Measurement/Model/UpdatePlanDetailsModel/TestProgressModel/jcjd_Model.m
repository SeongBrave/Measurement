//
//  jcjd_Model.m
//  Measurement
//
//  Created by DTSoft on 15/1/10.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "jcjd_Model.h"

@implementation jcjd_Model


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"gjje" : @"gjje",
             @"gjtjs" : @"gjtjs",
             @"ks" : @"ks",
             @"ry" : @"ry",
             @"rybh" : @"rybh",
             @"wczt" : @"wczt"
             };
}

-(NSString*)showStr
{
    return [NSString stringWithFormat:@"%@科室-,共计台件数%@,共计金额%@",_ks,_gjtjs,_gjje];
}





















@end
