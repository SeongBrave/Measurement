//
//  OptionMenuTableViewController.h
//  Measurement
//
//  Created by DTSoft on 14/12/28.
//  Copyright (c) 2014年 成勇. All rights reserved.
//


/**
 *  点击选项弹出的视图
 */
#import "BaseTableViewController.h"


@class OptionMenuTableViewController;

@protocol DidOptionMenuDelegate <NSObject>

-(void)OptionMenu:(OptionMenuTableViewController*) selectValueTVC DidsaveValue:(id)saveValue;

@end



@interface OptionMenuTableViewController : BaseTableViewController


@property(nonatomic , assign)id<DidOptionMenuDelegate> m_optionMenuDelegate;


/**
 *  保存用于请求的参数数据
 */
@property(nonatomic , strong)NSMutableDictionary *m_relValue;

@end
