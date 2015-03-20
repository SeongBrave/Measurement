//
//  Wcjdjh_ksry_Model.h
//  Measurement
//
//  Created by DTSoft on 15/3/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  我创建的计划 -> 更新计划 ->计划详情 ->科室人员
 */
#import <Mantle.h>

@interface Wcjdjh_ksry_Model : MTLModel<MTLJSONSerializing>

/**
 *  comcode
 */
@property (nonatomic, copy) NSString *usercode;

/**
 * comcname
 */
@property (nonatomic, copy) NSString *username;


/**
 * state
 */
@property (nonatomic, copy) NSNumber *state;


@end
