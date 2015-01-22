//
//  Bzqsb_Model.h
//  Measurement
//
//  Created by DTSoft on 15/1/22.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <Mantle.h>

@interface Bzqsb_Model : MTLModel<MTLJSONSerializing>


/**
 *  BZSBBH
 */
@property (nonatomic, copy) NSString *bzsbbh;

/**
 * CLFW
 */
@property (nonatomic, copy) NSString *clfw;

/**
 *  ID
 */
@property (nonatomic, copy) NSString *m_id;
/**
 * JLTX
 */
@property (nonatomic, copy) NSString *jltx;

/**
 * SBMC
 */
@property (nonatomic, copy) NSString *sbmc;

/**
 *  SYDWMC
 */
@property (nonatomic, copy) NSString *sydwmc;
/**
 * SYZSH
 */
@property (nonatomic, copy) NSString *syzsh;

/**
 * YXQ
 */
@property (nonatomic, copy) NSString *yxq;

/**
 *  表示是否被选中
 */
@property(nonatomic , assign)BOOL isSelected;



@end
