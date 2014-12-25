//
//  ProgramOverviewViewController.h
//  Measurement
//
//  Created by DTSoft on 14/12/21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//


/**
 *  计划总览
 */

#import "CommonLogicViewController.h"


@interface ProgramOverviewViewController : UIViewController

@property(nonatomic , strong)NSArray * m_DataSourceArr;

/**
 *  本地数据库
 */
@property(nonatomic , strong)YTKKeyValueStore *m_store;

/**
 *  保存数据的表名
 */
@property(nonatomic , strong)NSString *m_tableName;
@end
