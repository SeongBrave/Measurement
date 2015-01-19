//
//  NSDictionary+GetJsonStr.h
//  BedsNursingApp
//
//  Created by fanjinhao on 14-6-4.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GetJsonStr)

- (NSString*)GetJsonStrForDict;

/**
 *  经常会将字典中得某个值赋值给label 这里处理改字符串为空或者nil或者NSNULL等
 *
 *  @param key
 *
 *  @return
 */
-(NSString *)GetLabelWithKey:(NSString *) key;

@end
