//
//  SelectValue_XCKS_TableViewController.h
//  Measurement
//
//  Created by DTSoft on 14/12/29.
//  Copyright (c) 2014年 成勇. All rights reserved.
//


/**
 *  下厂科室
 */
#import "BaseTableViewController.h"


@class SelectValue_XCKS_TableViewController;

@protocol DidSelectedValue_XCKS_Delegate <NSObject>

-(void)SelectValue_XCKS_TVC:(SelectValue_XCKS_TableViewController*) selectValueTVC DidSelectedValue:(id)selectedValue;

@end

@interface SelectValue_XCKS_TableViewController : BaseTableViewController


@property(nonatomic , assign)id<DidSelectedValue_XCKS_Delegate> selectedDelegate;


@property(nonatomic , strong)NSArray *m_dataSourceArr;

@end
