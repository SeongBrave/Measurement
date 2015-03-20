//
//  Wcjdjh_Xcks_Model.h
//  Measurement
//
//  Created by DTSoft on 15/3/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  我创建的计划 -> 更新计划 ->计划详情 ->下厂科室
 */
#import <Mantle.h>

@interface Wcjdjh_Xcks_Model : MTLModel<MTLJSONSerializing>


/**
 *  comcode
 */
@property (nonatomic, copy) NSString *comcode;

/**
 * comcname
 */
@property (nonatomic, copy) NSString *comcname;


/**
 * state
 */
@property (nonatomic, copy) NSNumber *state;


@property(nonatomic , strong)NSArray *m_ksryArr;


@end
