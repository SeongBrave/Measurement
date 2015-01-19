//
//  NSMutableArray+AddDictToArr.h
//  MClinicalNursing
//
//  Created by 成勇 on 14-4-4.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (AddDictToArr)

/**
 *  字典扩充，自动把obj与key加入字典
 *
 *  @param _obj 值
 *  @param _key key
 */
-(void)AddDictToArrWithObj:(id)_obj andKey:(NSString*) _key;

@end
