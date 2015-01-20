//
//  ks_Model.h
//  Measurement
//
//  Created by DTSoft on 15/1/8.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <Mantle.h>
#import "ry_Model.h"

@interface ks_Model : MTLModel<MTLJSONSerializing>


/**
 *  科室名字
 */
@property (nonatomic, copy) NSString *comcname;

/**
 * 科室编号
 */
@property (nonatomic, copy) NSString *comcode;

/**
 *  表示是否被选中
 */
@property(nonatomic , assign)BOOL isSelected;

/**
 * 选中的人员
 */
@property (nonatomic, copy) ry_Model *selected_ryModel;


/**
 *  是否是复选框
 */
@property (nonatomic, assign) BOOL isCheckBox;




/**
 *  保存科室下科室人员的数据
 */
@property(nonatomic , strong)NSArray *ryArr;

/**
 *  保存科选中的
 */
@property(nonatomic , strong)NSArray *selected_RYArr;

@end
