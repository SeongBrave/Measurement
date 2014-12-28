//
//  SelectValueTableViewController.h
//  Measurement
//
//  Created by DTSoft on 14/12/28.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "BaseTableViewController.h"

@class SelectValueTableViewController;

@protocol DidSelectedValueDelegate <NSObject>

-(void)SelectValueTVC:(SelectValueTableViewController*) selectValueTVC DidSelectedValue:(id)selectedValue;

@end

@interface SelectValueTableViewController : BaseTableViewController


@property(nonatomic , strong)NSArray *m_dataSourceArr;
@end
