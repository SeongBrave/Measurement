//
//  FactoryTaskDetailViewPopVC.h
//  Measurement
//
//  Created by DTSoft on 15/1/14.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  下厂任务中弹出视图 计划详情
 */
#import "BaseViewController.h"
#import "PopViewDelegate.h"

@interface FactoryTaskDetailViewPopVC : BaseViewController<UIPopoverControllerDelegate>

/**
 *  保存在那个vc上弹出的
 */
@property(nonatomic , strong)UIViewController *m_superVC;

@property(nonatomic , assign)id<PopViewDelegate> m_popDelegate;

@property(nonatomic , strong)UIPopoverController *m_popVC;

@property(nonatomic , strong)UIPopoverController *m_popSecondVC;
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