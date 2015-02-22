//
//  PlanningDepartmentDidHYPopViewController.h
//  Measurement
//
//  Created by DTSoft on 15/2/23.
//  Copyright (c) 2015年 成勇. All rights reserved.
//


/**
 *  科室计划 弹出框
 */
#import "CommonLogicViewController.h"

@interface PlanningDepartmentDidHYPopViewController : CommonLogicViewController

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
