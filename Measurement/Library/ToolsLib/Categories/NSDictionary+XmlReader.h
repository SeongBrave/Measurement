//
//  NSDictionary+XmlReader.h
//  ToolsLib
//
//  Created by DTSoft on 15/3/26.
//  Copyright (c) 2015年 ISoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XmlReader)

/**
 *  使用XMLReader 库解析xml时多余了一个text 才可以取出dict中的值
 *
 *  @return 取到得值
 */
-(NSString *)getXmlReaderValue;
@end
