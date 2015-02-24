//
//  xmbh_Auto_Model.h
//  Measurement
//
//  Created by DTSoft on 15/2/24.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  项目模糊查询得到的数据
 *接口为：http://IPaddress:port/mbs/convey/findXmxx.do
 */
#import <Mantle.h>
#import "AutoCompletionObject.h"

@interface xmbh_Auto_Model : MTLModel<MTLJSONSerializing ,AutoCompletionObject>


/**
 *  xmdm
 */
@property (nonatomic, copy) NSString *xmdm;

/**
 * xmmc
 */
@property (nonatomic, copy) NSString *xmmc;


@end
