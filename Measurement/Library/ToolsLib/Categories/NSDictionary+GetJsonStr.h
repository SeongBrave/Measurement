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

-(NSString *)GetLabelWithKey:(NSString *) key;

@end
