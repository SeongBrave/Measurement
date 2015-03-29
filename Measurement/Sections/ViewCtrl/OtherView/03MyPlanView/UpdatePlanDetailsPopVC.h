//
//  UpdatePlanDetailsPopVC.h
//  Measurement
//
//  Created by DTSoft on 15/1/6.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "BaseViewController.h"
#import "PopViewDelegate.h"
#import "MyPlanViewController.h"

@interface UpdatePlanDetailsPopVC : BaseViewController


@property(nonatomic , strong)UIPopoverController *m_popVC;
/**
 *  用于显示的数据
 */
@property(nonatomic , strong)NSDictionary *m_showDict;


@property(nonatomic , strong)MyPlanViewController *m_superView;
/**
 *  用于更新界面数据
 *
 *  @param showDict
 */
-(void)updateViewDataWithShowDict:(NSDictionary *)showDict;

@end
