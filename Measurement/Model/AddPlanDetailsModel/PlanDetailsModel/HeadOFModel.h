//
//  HeadOFModel.h
//  Measurement
//
//  Created by DTSoft on 15/1/7.
//  Copyright (c) 2015年 成勇. All rights reserved.
//


/**
 *  业务负责人
 */

#import <Foundation/Foundation.h>
#import "DropDownTextField.h"

@interface HeadOFModel : NSObject<DropDownTextFieldShowCellTextLabel>

@property(nonatomic , strong)NSDictionary *m_data;

@end
