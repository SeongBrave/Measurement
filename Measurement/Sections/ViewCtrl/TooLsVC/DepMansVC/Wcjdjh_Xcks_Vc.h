//
//  Wcjdjh_Xcks_Vc.h
//  Measurement
//
//  Created by DTSoft on 15/3/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "BaseViewController.h"
#import "Wcjdjh_Xcks_Model.h"

@class Wcjdjh_Xcks_Vc;

@protocol Wcjdjh_Xcks_VcDelegate <NSObject>

-(void)Wcjdjh_Xcks_Vc:(Wcjdjh_Xcks_Vc *)depManVC didSelectedArr:(NSArray *) selectedArr;
@end


@interface Wcjdjh_Xcks_Vc : BaseViewController

/**
 *  需要修改的数据
 */
@property(nonatomic , strong)Wcjdjh_Xcks_Model *m_model;

@property(nonatomic , assign)id<Wcjdjh_Xcks_VcDelegate> m_delegate;

@property(nonatomic , strong)NSArray *m_dataSourceArr;

@end
