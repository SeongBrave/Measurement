//
//  NSObject+NotNull.h
//  hostel-iphone
//
//  Created by liu ding on 12-7-12.
//  Copyright 2012年 teemax. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject(NotNull)

/**
 *  该对象是否为null或者空或者NSNULL等
 *
 *  @return
 */
-(BOOL) isNotNull;

/**
 *  判断改对象是否为空（对字典数组类有效）
 *
 *  @return
 */
-(BOOL) isNotEmpty;

@end
