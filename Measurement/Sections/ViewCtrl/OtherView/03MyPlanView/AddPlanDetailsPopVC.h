//
//  AddPlanDetailsPopVC.h
//  Measurement
//
//  Created by DTSoft on 15/1/4.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "BaseViewController.h"
#import "PopViewDelegate.h"
#import "MyPlanViewController.h"
@interface AddPlanDetailsPopVC : BaseViewController

@property(nonatomic , assign)id<PopViewDelegate> m_popDelegate;


@property(nonatomic , strong)MyPlanViewController *m_superView;
@end
