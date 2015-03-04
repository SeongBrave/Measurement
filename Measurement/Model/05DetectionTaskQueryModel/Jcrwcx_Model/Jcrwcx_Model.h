//
//  Jcrwcx_Model.h
//  Measurement
//
//  Created by DTSoft on 15/3/4.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  检测任务查询 卡片显示
 */
#import <Mantle.h>

@interface Jcrwcx_Model : MTLModel<MTLJSONSerializing>

/**
 *  BY1
 */
@property (nonatomic, copy) NSString *by1;

/**
 * BY2
 */
@property (nonatomic, copy) NSString *by2;

/**
 *  CCBH
 */
@property (nonatomic, copy) NSString *ccbh;

/**
 * CJSJ
 */
@property (nonatomic, copy) NSString *cjsj;


/**
 *  DWDZ
 */
@property (nonatomic, copy) NSString *dwdz;

/**
 * GGXH
 */
@property (nonatomic, copy) NSString *ggxh;

/**
 *  JCLX
 */
@property (nonatomic, copy) NSString *jclx;

/**
 *  JCLXBH
 */
@property (nonatomic, copy) NSString *jclxbh;

/**
 * JDJG
 */
@property (nonatomic, copy) NSString *jdjg;

/**
 *  JLLX
 */
@property (nonatomic, copy) NSString *jllx;

/**
 * SFHY
 */
@property (nonatomic, copy) NSString *sfhy;


/**
 *  SFLZ
 */
@property (nonatomic, copy) NSString *sflz;

/**
 * SFPZ
 */
@property (nonatomic, copy) NSString *sfpz;

/**
 *  TXM
 */
@property (nonatomic, copy) NSString *txm;

/**
 *  ZSBH
 */
@property (nonatomic, copy) NSString *zsbh;

/**
 *  YSJLH
 */
@property (nonatomic, copy) NSString *ysjlh;

/**
 *  YQMC
 */
@property (nonatomic, copy) NSString *yqmc;

/**
 *  YQID
 */
@property (nonatomic, copy) NSString *yqid;

/**
 *  WTDW
 */
@property (nonatomic, copy) NSString *wtdw;

/**
 *  WTDBH
 */
@property (nonatomic, copy) NSString *wtdbh;

@end
