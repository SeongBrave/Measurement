//
//  DepManViewController.h
//  Measurement
//
//  Created by DTSoft on 15/1/8.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  科室人员
 */


#import "BaseViewController.h"
#import "ks_Model.h"


@class DepManViewController;

@protocol DepManVCDelegate <NSObject>

-(void)DepManVC:(DepManViewController *)depManVC didSelectedArr:(NSArray *) selectedArr;
@end



@interface DepManViewController : BaseViewController


/**
 *  需要修改的数据
 */
@property(nonatomic , strong)ks_Model *ksModel;

@property(nonatomic , assign)id<DepManVCDelegate> m_delegate;

@property(nonatomic , strong)NSArray *m_dataSourceArr;



@end
