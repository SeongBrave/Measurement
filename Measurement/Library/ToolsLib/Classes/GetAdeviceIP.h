//
//  GetAdeviceIP.h
//  MClinicalNursing
//
//  Created by 成勇 on 14-4-21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GetAdeviceIP : NSObject


//TODO: 是否是ipv4
+(NSString *)getIPAddress:(BOOL)preferIPv4;

@end
