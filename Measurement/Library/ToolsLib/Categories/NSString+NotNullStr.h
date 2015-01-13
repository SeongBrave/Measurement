//
//  NSString+NotNullStr.h
//  ToolsLib
//
//  Created by DTSoft on 15/1/13.
//  Copyright (c) 2015年 ISoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NotNullStr)

/**
 *  如果字符串为nil或null等就返回@""
 *
 *  @return
 */
-(NSString *)GetNotNullStr;

@end
