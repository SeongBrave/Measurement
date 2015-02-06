//
//  sblb_Model.h
//  Measurement
//
//  Created by DTSoft on 15/1/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  设备列表
 */
#import <Mantle.h>

@interface sblb_Model : MTLModel<MTLJSONSerializing>


/**
 *  bzsf
 */
@property (nonatomic, copy) NSString *bzsf;

/**
 * ggxh
 */
@property (nonatomic, copy) NSString *ggxh;

/**
 * yqmc
 */
@property (nonatomic, copy) NSString *yqmc;

/**
 *  jcfw
 */
@property (nonatomic, copy) NSString *jcfw;

/**
 * jclx
 */
@property (nonatomic, copy) NSString *jclx;

/**
 *  jltx
 */
@property (nonatomic, copy) NSString *jltx;

/**
 * sccj
 */
@property (nonatomic, copy) NSString *sccj;


/**
 * sfsczs
 */
@property (nonatomic, copy) NSString *sfsczs;

/**
 *  zsbh
 */
@property (nonatomic, copy) NSString *zsbh;


/**
 *  zsbh
 */
@property (nonatomic, copy) NSString *txm;

/**
 *  yqid
 */
@property (nonatomic, copy) NSString *yqid;





@end
