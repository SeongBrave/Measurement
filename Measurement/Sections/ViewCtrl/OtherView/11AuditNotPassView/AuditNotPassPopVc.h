//
//  AuditNotPassPopVc.h
//  Measurement
//
//  Created by DTSoft on 15/3/6.
//  Copyright (c) 2015年 成勇. All rights reserved.
//
/**
 *  审核未通过的弹出视图
 */

#import "BaseViewController.h"
#import "Jcrwcx_Model.h"
@interface AuditNotPassPopVc : BaseViewController
@property(nonatomic , strong)UIPopoverController *m_popVC;

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

/**
 *  显示DropDownTableView
 */
-(void)showDropDownTableView;
@end
