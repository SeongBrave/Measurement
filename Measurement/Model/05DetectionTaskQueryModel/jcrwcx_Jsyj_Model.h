//
//  jcrwcx_Jsyj_Model.h
//  Measurement
//
//  Created by DTSoft on 15/3/10.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <Mantle.h>

@interface jcrwcx_Jsyj_Model : MTLModel<MTLJSONSerializing>


/**
 * ID
 */
@property (nonatomic, copy) NSString *m_id;

/**
 *  YJDM
 */
@property (nonatomic, copy) NSString *yjdm;
/**
 * YJMC
 */
@property (nonatomic, copy) NSString *yjmc;


/**
 *  表示是否被选中
 */
@property(nonatomic , assign)BOOL isSelected;

@end
