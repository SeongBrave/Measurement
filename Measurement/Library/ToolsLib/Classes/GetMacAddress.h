//
//  GetMacAddress.h
//  WirelessApp
//
//  Created by 成勇 on 14-5-26.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMacAddress : NSObject


//获取mac地址
+ (NSString *)getMacAddress;

//TODO: 得到连接的wifi名
+ (NSString *)getCurrentWifiSSID;
@end
