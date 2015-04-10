//
//  NSMutableDictionary+SetNotNilValue.h
//  ToolsLib
//
//  Created by DTSoft on 15/3/26.
//  Copyright (c) 2015年 ISoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SetNotNilValue)

-(void)SetNotNilValueByValue:(id) value forKey:(NSString *) key;
@end
