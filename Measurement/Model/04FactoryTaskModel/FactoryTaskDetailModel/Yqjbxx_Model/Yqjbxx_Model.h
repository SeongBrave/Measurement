//
//  Yqjbxx_Model.h
//  Measurement
//
//  Created by DTSoft on 15/1/28.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  仪器名称 模糊查询 得到的数据
 *  接口为： http://192.168.10.169:8080/mbs/convey/getYqbjxx.do?sfbzid=C093514EFF574625A5CEC5462385B346
 *
 */
#import <Mantle.h>
@interface Yqjbxx_Model : MTLModel<MTLJSONSerializing>


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
 * DWBH
 */
@property (nonatomic, copy) NSString *dwbh;


/**
 *  GGXH
 */
@property (nonatomic, copy) NSString *ggxh;

/**
 * JCLX
 */
@property (nonatomic, copy) NSString *jclx;


/**
 * JCLXBH
 */
@property (nonatomic, copy) NSString *jclxbh;

/**
 * JLQJBH
 */
@property (nonatomic, copy) NSString *jlqjbh;

/**
 * SFSQ
 */
@property (nonatomic, copy) NSString *sfsq;


/**
 *  JLQJMC
 */
@property (nonatomic, copy) NSString *jlqjmc;

/**
 *  SSKSBH
 */
@property (nonatomic, copy) NSString *ssksbh;

/**
 *  XMBH
 */
@property (nonatomic, copy) NSString *xmbh;


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
