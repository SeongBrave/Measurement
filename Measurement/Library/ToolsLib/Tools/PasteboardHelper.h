//
//  PasteboardHelper.h
//  ToolsLib
//
//  Created by DTSoft on 15/3/17.
//  Copyright (c) 2015年 ISoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PasteboardHelper : NSObject

/**
 *  将str 设置为粘贴项目 主要为了调试
 *
 *  @param str
 */
+(void)SetPasteboardByStr:(NSString *) str;

/**
 *  将dict 设置为粘贴项目 主要为了调试
 *
 *  @param str
 */
+(void)SetPasteboardByDict:(NSDictionary *) dict;
@end
