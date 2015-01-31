//
//  pzr_Model.h
//  Measurement
//
//  Created by DTSoft on 15/1/31.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  批准人
 */
#import <Mantle.h>
#import "DropDownTextField.h"

@interface pzr_Model : MTLModel<MTLJSONSerializing,DropDownTextFieldShowCellTextLabel>


/**
 *  USERNAME
 */
@property (nonatomic, copy) NSString *username;

/**
 * USERCODE
 */
@property (nonatomic, copy) NSString *usercode;

@end
