//
//  DepMansViewController.h
//  Measurement
//
//  Created by DTSoft on 15/1/9.
//  Copyright (c) 2015年 成勇. All rights reserved.
//


/**
 *  科室人员(多选)
 */

#import "BaseViewController.h"
#import "ks_Model.h"


@class DepMansViewController;

@protocol DepMansVCDelegate <NSObject>

-(void)DepMansVC:(DepMansViewController *)depManVC didSelectedArr:(NSArray *) selectedArr;
@end

@interface DepMansViewController : BaseViewController

/**
 *  需要修改的数据
 */
@property(nonatomic , strong)ks_Model *ksModel;

@property(nonatomic , assign)id<DepMansVCDelegate> m_delegate;

@property(nonatomic , strong)NSArray *m_dataSourceArr;


@end
