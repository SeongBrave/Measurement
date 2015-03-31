//
//  rwfp_model.h
//  Measurement
//
//  Created by DTSoft on 15/3/31.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 * 计划总揽 -> 任务分配
 */
#import <Mantle.h>

@interface rwfp_model : MTLModel<MTLJSONSerializing>

@property(nonatomic , copy)NSString *sffp;

@property(nonatomic , copy)NSString *username;

@property(nonatomic , copy)NSString *usercode;

@property(nonatomic , copy)NSString *comcode;


@end
