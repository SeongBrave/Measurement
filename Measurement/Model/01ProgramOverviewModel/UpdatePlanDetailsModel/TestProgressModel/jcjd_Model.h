//
//  jcjd_Model.h
//  Measurement
//
//  Created by DTSoft on 15/1/10.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <Mantle.h>

@interface jcjd_Model : MTLModel<MTLJSONSerializing>


/**
 *  共计金额
 */
@property (nonatomic, copy) NSString *gjje;

/**
 * 共计台件数
 */
@property (nonatomic, copy) NSString *gjtjs;

/**
 *  科室
 */
@property (nonatomic, copy) NSString *ks;

/**
 * 人员
 */
@property (nonatomic, copy) NSString *ry;

/**
 *  人员编号
 */
@property (nonatomic, copy) NSString *rybh;

/**
 * 完成状态
 */
@property (nonatomic, copy) NSString *wczt;


/**
 *  label显示的数据
 */
@property(nonatomic , strong)NSString *showStr;
/**
 *  检测进度详细信息
 */
@property(nonatomic , strong)NSArray *jcjdDetailArr;


@end
