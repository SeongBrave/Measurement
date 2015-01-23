//
//  jlmb_Model.h
//  Measurement
//
//  Created by DTSoft on 15/1/23.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  原始记录模版列表
 */
#import <Mantle.h>

@interface jlmb_Model : MTLModel<MTLJSONSerializing>

/**
 *  CJR
 */
@property (nonatomic, copy) NSString *cjr;

/**
 * CJRBH
 */
@property (nonatomic, copy) NSString *cjrbh;

/**
 *  CJSJ
 */
@property (nonatomic, copy) NSString *cjsj;

/**
 * ID
 */
@property (nonatomic, copy) NSString *m_id;


/**
 *  JLMBBH
 */
@property (nonatomic, copy) NSString *jlmbbh;

/**
 * JLMBLX
 */
@property (nonatomic, copy) NSString *jlmblx;

/**
 *  JLMBMC
 */
@property (nonatomic, copy) NSString *jlmbmc;

/**
 * JLSYFW
 */
@property (nonatomic, copy) NSString *jlsyfw;

@end
