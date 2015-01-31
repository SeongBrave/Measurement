//
//  jdzq_Model.h
//  Measurement
//
//  Created by DTSoft on 15/1/31.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  1.14.7.1 操作信息 检定周期 全小写
 *  接口为： http://192.168.10.169:8080/mbs/convey/findDmxx.do?zdbm=dw
 *
 */
#import <Mantle.h>
#import "DropDownTextField.h"
@interface jdzq_Model : MTLModel<MTLJSONSerializing ,DropDownTextFieldShowCellTextLabel>


/**
 *  CJR
 */
@property (nonatomic, copy) NSString *cjr;

/**
 * CJSJ
 */
@property (nonatomic, copy) NSString *cjsj;

/**
 *  DMBM
 */
@property (nonatomic, copy) NSString *dmbm;

/**
 * DMXXMC
 */
@property (nonatomic, copy) NSString *dmxxmc;

/**
 *  ID
 */
@property (nonatomic, copy) NSString *m_id;

/**
 * ZDBM
 */
@property (nonatomic, copy) NSString *zdbm;


/**
 * ZDMC
 */
@property (nonatomic, copy) NSString *zdmc;


@end
