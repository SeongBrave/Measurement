//
//  MenuModel.m
//  Measurement
//
//  Created by DTSoft on 15/2/25.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"des" : @"des",
             @"flag" : @"flag",
             @"isasmenu" : @"isasmenu",
             @"isvalidate" : @"isvalidate",
             @"menuname" : @"menuname",
             @"menuurl" : @"menuurl",
             @"name" : @"name",
             @"parentid" : @"parentid",
             @"sysflag" : @"sysflag",
             @"taskid" : @"taskid",
             };
}

@end
