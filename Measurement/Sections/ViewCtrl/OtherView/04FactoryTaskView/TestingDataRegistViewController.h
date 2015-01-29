//
//  TestingDataRegistViewController.h
//  Measurement
//
//  Created by DTSoft on 15/1/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  检测数据登记
 */
#import "BaseViewController.h"


@interface TestingDataRegistViewController : BaseViewController


/**
 *  用于保存上一级界面传递过来的数据
 */
@property(nonatomic , strong)NSDictionary *m_showDict;

/**
 *  用于显示设备详情界面的数据
 */
@property(nonatomic , strong)NSDictionary *m_qjxxDict;

/**
 *  用于保存最后确定时传的参数
 */
@property(nonatomic ,strong)NSMutableDictionary *m_saveDataDict;

@end
