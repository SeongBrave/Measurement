//
//  jcjd_Detail_Model.h
//  Measurement
//
//  Created by DTSoft on 15/1/10.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <Mantle.h>

@interface jcjd_Detail_Model : MTLModel<MTLJSONSerializing>


/**
 *  科室人员名字
 */
@property (nonatomic, copy) NSString *bzsf;

/**
 *  仪器名称
 */
@property(nonatomic , copy)NSString *yqmc;

/**
 * 规格型号
 */
@property (nonatomic, copy) NSString *ggxh;

/**
 *  检测范围
 */
@property (nonatomic, copy) NSString *jcfw;

/**
 * 科室人员编号
 */
@property (nonatomic, copy) NSString *jclx;


/**
 *  计量特性
 */
@property (nonatomic, copy) NSString *jltx;

/**
 * 生产厂家
 */
@property (nonatomic, copy) NSString *sccj;


/**
 *  科室人员名字
 */
@property (nonatomic, copy) NSString *txm;

/**
 * 科室人员编号
 */
@property (nonatomic, copy) NSString *zsbh;




































@end
