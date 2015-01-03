//
//  MyPlanPopVC.h
//  Measurement
//
//  Created by DTSoft on 15/1/3.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "BaseViewController.h"
#import "PopViewDelegate.h"


@interface MyPlanPopVC : BaseViewController

@property(nonatomic , assign)id<PopViewDelegate> m_popDelegate;

@end
