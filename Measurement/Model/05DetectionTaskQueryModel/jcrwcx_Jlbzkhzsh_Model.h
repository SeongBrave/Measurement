//
//  jcrwcx_Jlbzkhzsh_Model.h
//  Measurement
//
//  Created by DTSoft on 15/3/10.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <Mantle.h>

@interface jcrwcx_Jlbzkhzsh_Model : MTLModel<MTLJSONSerializing>


/**
 *  BZXH
 */
@property (nonatomic, copy) NSString *bzxh;

/**
 * ID
 */
@property (nonatomic, copy) NSString *m_id;

/**
 *  JLBZKHZSH
 */
@property (nonatomic, copy) NSString *jlbzkhzsh;
/**
 * SHGYZSH
 */
@property (nonatomic, copy) NSString *shgyzsh;

/**
 *  表示是否被选中
 */
@property(nonatomic , assign)BOOL isSelected;
@end
