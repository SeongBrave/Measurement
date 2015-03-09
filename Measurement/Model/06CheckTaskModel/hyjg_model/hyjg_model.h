//
//  hyjg_model.h
//  Measurement
//
//  Created by DTSoft on 15/3/9.
//  Copyright (c) 2015年 成勇. All rights reserved.
//


/**
 *  核验结果 核验结果(0 未核验 核验备注
 1 核验通过 2 核验未通过)
 */
#import "MTLModel.h"
#import "DropDownTextField.h"
@interface hyjg_model : MTLModel<DropDownTextFieldShowCellTextLabel>

/**
 *  
 */
@property (nonatomic, copy) NSString *m_showTitle;

/**
 *
 */
@property (nonatomic, copy) NSString *m_code;


@end
