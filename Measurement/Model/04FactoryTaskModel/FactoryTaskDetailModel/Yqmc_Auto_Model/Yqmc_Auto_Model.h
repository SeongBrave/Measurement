//
//  Yqmc_Auto_Model.h
//  Measurement
//
//  Created by DTSoft on 15/1/28.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  仪器名称 模糊查询 得到的数据  
 *  接口为： http://IPaddress:port/mbs/convey/getYqbj.do
 *
 */
#import <Mantle.h>
#import "AutoCompletionObject.h"

@interface Yqmc_Auto_Model : MTLModel<MTLJSONSerializing ,AutoCompletionObject>



/**
 *  BJ
 */
@property (nonatomic, copy) NSString *bj;

/**
 * BY5
 */
@property (nonatomic, copy) NSString *by5;

/**
 *  CLFW
 */
@property (nonatomic, copy) NSString *clfw;

/**
 * DW
 */
@property (nonatomic, copy) NSString *dw;

/**
 *  GGXH
 */
@property (nonatomic, copy) NSString *ggxh;

/**
 * JCLX
 */
@property (nonatomic, copy) NSString *jclx;


/**
 * JLQJBH
 */
@property (nonatomic, copy) NSString *jlqjbh;

/**
 *  JLQJMC
 */
@property (nonatomic, copy) NSString *jlqjmc;


/**
 *  JLTX
 */
@property (nonatomic, copy) NSString *jltx;

/**
 *  SFBZID
 */
@property (nonatomic, copy) NSString *sfbzid;

/**
 * SSKS
 */
@property (nonatomic, copy) NSString *ssks;



@end
