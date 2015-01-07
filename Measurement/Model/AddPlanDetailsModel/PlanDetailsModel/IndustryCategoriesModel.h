//
//  IndustryCategoriesModel.h
//  Measurement
//
//  Created by DTSoft on 15/1/7.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  行业类别
 */

#import <Foundation/Foundation.h>
#import "DropDownTextField.h"

@interface IndustryCategoriesModel : NSObject<DropDownTextFieldShowCellTextLabel>

@property(nonatomic , strong)NSDictionary *m_data;
@end
