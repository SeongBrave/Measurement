//
//  Jcrwcx_OptionMenuTVc.h
//  Measurement
//
//  Created by DTSoft on 15/4/9.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  点击选项弹出的视图 检测任务查询类型模块的弹出列表
 */
#import "BaseTableViewController.h"


@class Jcrwcx_OptionMenuTVc;

@protocol DidOptionMenuTVcDelegate <NSObject>

-(void)OptionMenuTVc:(Jcrwcx_OptionMenuTVc*) selectValueTVC DidsaveValue:(id)saveValue;

@end

@interface Jcrwcx_OptionMenuTVc : BaseTableViewController

@property(nonatomic , assign)id<DidOptionMenuTVcDelegate> m_optionMenuDelegate;


/**
 *  保存用于请求的参数数据
 */
@property(nonatomic , strong)NSMutableDictionary *m_relValue;


@end
