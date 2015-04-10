//
//  PinYinForObjc.h
//  TransfusionManagerApp
//
//  Created by 成勇 on 14-4-25.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HanyuPinyinOutputFormat.h"
#import "PinyinHelper.h"

@interface PinYinForObjc : NSObject


+ (NSString*)chineseConvertToPinYin:(NSString*)chinese;//转换为拼音
+ (NSString*)chineseConvertToPinYinHead:(NSString *)chinese;//转换为拼音首字母


@end
