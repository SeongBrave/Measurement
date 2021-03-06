//
//  DetectionTaskQueryDidHYPopViewController.h
//  Measurement
//
//  Created by DTSoft on 15/2/15.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  已提交核验 显示检测数据修改
 */
#import "BaseViewController.h"
#import "Jcrwcx_Model.h"

@interface DetectionTaskQueryDidHYPopViewController : BaseViewController



@property(nonatomic , assign)DataSourceType m_dataSourceType;

/**
 *  用于保存上一级界面传递过来的数据
 */
@property(nonatomic , strong)NSDictionary *m_showDict;

@property(nonatomic , strong)Jcrwcx_Model *m_jcrwcx_Model;

/**
 *  用于显示设备详情界面的数据
 */
@property(nonatomic , strong)NSDictionary *m_qjxxDict;

/**
 *  用于保存设备详情最后确定时传的参数
 */
@property(nonatomic ,strong)NSMutableDictionary *m_Sbxq_saveDataDict;

/**
 *  用于保存公共信息最后确定时传的参数
 */
@property(nonatomic ,strong)NSMutableDictionary *m_Ggxx_saveDataDict;

@end
