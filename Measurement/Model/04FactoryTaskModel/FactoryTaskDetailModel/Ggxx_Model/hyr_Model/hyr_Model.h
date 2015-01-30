//
//  hyr_Model.h
//  Measurement
//
//  Created by DTSoft on 15/1/31.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  核验人
 */
#import <Mantle.h>
#import "AutoCompletionObject.h"
@interface hyr_Model : MTLModel<MTLJSONSerializing,AutoCompletionObject>


/**
 *  USERNAME
 */
@property (nonatomic, copy) NSString *m_key;

/**
 * USERCODE
 */
@property (nonatomic, copy) NSString *m_value;



@end
