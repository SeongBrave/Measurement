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
 *  取得一个字符串，该字符串不可能为nil或NSNULL 等
 *
 *  @return 
 */
-(NSString *)GetNotNullStr;

@end
