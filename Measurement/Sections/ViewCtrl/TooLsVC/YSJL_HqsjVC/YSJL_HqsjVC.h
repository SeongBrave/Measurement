//
//  YSJL_HqsjVC.h
//  Measurement
//
//  Created by DTSoft on 15/2/24.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "BaseTableViewController.h"


@class YSJL_HqsjVC;

@protocol DidSelectedValue_XCRY_Delegate <NSObject>

-(void)SelectValue_YSJL_HqsjVC:(YSJL_HqsjVC*) selectValueTVC DidSelectedValue:(id)selectedValue;

@end

@interface YSJL_HqsjVC : BaseTableViewController

@property(nonatomic , assign)id<DidSelectedValue_XCRY_Delegate> selectedDelegate;

@end
