//
//  zsmb_Model.h
//  Measurement
//
//  Created by DTSoft on 15/2/5.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  证书模版列表
 */
#import <Mantle.h>

@interface zsmb_Model : MTLModel<MTLJSONSerializing>
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
 *  ZSMBBH
 */
@property (nonatomic, copy) NSString *zsmbbh;

/**
 * ZSMBLX
 */
@property (nonatomic, copy) NSString *zsmblx;

/**
 *  ZSMBMC
 */
@property (nonatomic, copy) NSString *zsmbmc;

/**
 * ZSSYFW
 */
@property (nonatomic, copy) NSString *zssyfw;

/**
 *  ZSSKH
 */
@property (nonatomic, copy) NSString *zsskh;


@property(nonatomic , assign)BOOL isSelected;
@end
