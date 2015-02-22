//
//  ProgramOverviewDidHYPopViewController.h
//  Measurement
//
//  Created by DTSoft on 15/2/22.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  计划总览 弹出框
 */
#import "CommonLogicViewController.h"

@interface ProgramOverviewDidHYPopViewController : CommonLogicViewController

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
