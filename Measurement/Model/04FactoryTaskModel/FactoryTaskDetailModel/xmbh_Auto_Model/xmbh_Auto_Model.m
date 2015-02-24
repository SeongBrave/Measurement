//
//  xmbh_Auto_Model.m
//  Measurement
//
//  Created by DTSoft on 15/2/24.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "xmbh_Auto_Model.h"

@implementation xmbh_Auto_Model


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"xmdm" : @"xmdm",
             @"xmmc" : @"xmmc",
             };
}

/**
 *  用于显示tableviewcell的数据，光显示一个text
 *
 *  @return textlabel要显示的数据
 */
- (NSString *)autocompleteString
{
    return self.xmmc;
}
@end
