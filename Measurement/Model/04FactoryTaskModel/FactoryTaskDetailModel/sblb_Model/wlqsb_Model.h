//
//  wlqsb_Model.h
//  Measurement
//
//  Created by DTSoft on 15/2/9.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  未领取设备
 http://192.168.10.169:8080/mbs/convey/findShebei.do?rwbh=5dce769b2f9e46a3b3a2c194f46eb80b
 */
#import <Mantle.h>

@interface wlqsb_Model : MTLModel<MTLJSONSerializing>


/**
 *  by1
 */
@property (nonatomic, copy) NSString *by1;

/**
 * by2
 */
@property (nonatomic, copy) NSString *by2;

/**
 * by3
 */
@property (nonatomic, copy) NSString *by3;

/**
 *  by4
 */
@property (nonatomic, copy) NSString *by4;

/**
 * by5
 */
@property (nonatomic, copy) NSString *by5;

/**
 *  bz
 */
@property (nonatomic, copy) NSString *bz;

/**
 * bzsf
 */
@property (nonatomic, copy) NSNumber *bzsf;


/**
 * bzsfbh
 */
@property (nonatomic, copy) NSString *bzsfbh;

/**
 *  ccbh
 */
@property (nonatomic, copy) NSString *ccbh;


/**
 *  cjr
 */
@property (nonatomic, copy) NSString *cjr;

/**
 *  cjsj
 */
@property (nonatomic, copy) NSString *cjsj;

/**
 *  dwbh
 */
@property (nonatomic, copy) NSString *dwbh;

/**
 * ggxh
 */
@property (nonatomic, copy) NSString *ggxh;

/**
 * jcfw
 */
@property (nonatomic, copy) NSString *jcfw;

/**
 *  jclx
 */
@property (nonatomic, copy) NSString *jclx;

/**
 * jclxbh
 */
@property (nonatomic, copy) NSString *jclxbh;

/**
 *  jdjg
 */
@property (nonatomic, copy) NSString *jdjg;

/**
 * jdzqbh
 */
@property (nonatomic, copy) NSString *jdzqbh;


/**
 * jlbh
 */
@property (nonatomic, copy) NSString *jlbh;

/**
 *  jltx
 */
@property (nonatomic, copy) NSString *jltx;


/**
 *  ks
 */
@property (nonatomic, copy) NSString *ks;

/**
 *  ksbh
 */
@property (nonatomic, copy) NSString *ksbh;











/**
 *  pj
 */
@property (nonatomic, copy) NSString *pj;

/**
 * qjytbh
 */
@property (nonatomic, copy) NSString *qjytbh;

/**
 * rwbh
 */
@property (nonatomic, copy) NSString *rwbh;

/**
 *  sbztbh
 */
@property (nonatomic, copy) NSString *sbztbh;

/**
 * sccj
 */
@property (nonatomic, copy) NSString *sccj;

/**
 *  sfsq
 */
@property (nonatomic, copy) NSString *sfsq;

/**
 * sfyc
 */
@property (nonatomic, copy) NSString *sfyc;


/**
 * sl
 */
@property (nonatomic, copy) NSString *sl;

/**
 *  txm
 */
@property (nonatomic, copy) NSString *txm;


/**
 *  wg
 */
@property (nonatomic, copy) NSString *wg;

/**
 *  wtdw
 */
@property (nonatomic, copy) NSString *wtdw;

/**
 *  xmbh
 */
@property (nonatomic, copy) NSString *xmbh;

/**
 * yqid
 */
@property (nonatomic, copy) NSString *yqid;

/**
 * yqmc
 */
@property (nonatomic, copy) NSString *yqmc;

/**
 *  zkl
 */
@property (nonatomic, copy) NSString *zkl;

/**
 * zsbh
 */
@property (nonatomic, copy) NSString *zsbh;

/**
 *  表示是否被选中
 */
@property(nonatomic , assign)BOOL isSelected;
@end
