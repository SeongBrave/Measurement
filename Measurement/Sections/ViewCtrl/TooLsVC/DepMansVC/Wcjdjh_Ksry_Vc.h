//
//  Wcjdjh_Ksry_Vc.h
//  Measurement
//
//  Created by DTSoft on 15/3/21.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "BaseViewController.h"
#import "Wcjdjh_ksry_Model.h"
#import "Wcjdjh_Xcks_Model.h"

@class Wcjdjh_Ksry_Vc;

@protocol Wcjdjh_Ksry_VcDelegate <NSObject>

-(void)Wcjdjh_Xcks_Vc:(Wcjdjh_Ksry_Vc *)depManVC didSelectedArr:(NSArray *) selectedArr;
@end


@interface Wcjdjh_Ksry_Vc : BaseViewController

/**
 *  需要修改的数据
 */
@property(nonatomic , strong)Wcjdjh_Xcks_Model *m_model;

@property(nonatomic , assign)id<Wcjdjh_Ksry_VcDelegate> m_delegate;

@property(nonatomic , strong)NSArray *m_dataSourceArr;

@end
