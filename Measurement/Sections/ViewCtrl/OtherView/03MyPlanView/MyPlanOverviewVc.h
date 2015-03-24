//
//  MyPlanOverviewVc.h
//  Measurement
//
//  Created by DTSoft on 15/3/24.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  我创建的计划弹出预览界面
 */

#import "CommonLogicViewController.h"

@interface MyPlanOverviewVc : CommonLogicViewController

@property(nonatomic , strong)UIPopoverController *m_popVC;
/**
 *  用于显示的数据
 */
@property(nonatomic , strong)NSDictionary *m_showDict;


/**
 *  用于更新界面数据
 *
 *  @param showDict
 */
-(void)updateViewDataWithShowDict:(NSDictionary *)showDict;
@end
