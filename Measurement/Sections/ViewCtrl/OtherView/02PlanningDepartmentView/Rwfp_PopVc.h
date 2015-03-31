//
//  Rwfp_PopVc.h
//  Measurement
//
//  Created by DTSoft on 15/3/31.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "BaseViewController.h"
#import "rwfp_Model.h"


@class Rwfp_PopVc;

@protocol Rwfp_PopVcDelegate <NSObject>

-(void)Rwfp_PopVc:(Rwfp_PopVc *)depManVC didSelectedArr:(NSArray *) selectedArr;
@end


@interface Rwfp_PopVc : BaseViewController


/**
 *  需要修改的数据
 */
@property(nonatomic , strong)rwfp_model *rwfpmodel;

@property(nonatomic , strong)NSDictionary *m_shaowDict;

@property(nonatomic , assign)id<Rwfp_PopVcDelegate> m_delegate;

@property(nonatomic , strong)NSArray *m_dataSourceArr;

@end
