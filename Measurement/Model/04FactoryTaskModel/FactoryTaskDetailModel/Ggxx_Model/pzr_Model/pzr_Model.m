//
//  pzr_Model.m
//  Measurement
//
//  Created by DTSoft on 15/1/31.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "pzr_Model.h"

@implementation pzr_Model

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"username" : @"USERNAME",
             @"usercode" : @"USERCODE",
             };
}

/**
 *  用于显示tableviewcell的数据，光显示一个text
 *
 *  @return textlabel要显示的数据
 */
- (NSString *)autocompleteString
{
    return self.username;
}
@end
