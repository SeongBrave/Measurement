//
//  ry_Model.h
//  Measurement
//
//  Created by DTSoft on 15/1/8.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <Mantle.h>

@interface ry_Model : MTLModel<MTLJSONSerializing>


/**
 *  科室人员名字
 */
@property (nonatomic, copy) NSString *username;

/**
 * 科室人员编号
 */
@property (nonatomic, copy) NSString *usercode;

/**
 *  表示是否被选中
 */
@property(nonatomic , assign)BOOL isSelected;

/**
 *  是否是复选框
 */
@property (nonatomic, assign) BOOL isCheckBox;



@end
