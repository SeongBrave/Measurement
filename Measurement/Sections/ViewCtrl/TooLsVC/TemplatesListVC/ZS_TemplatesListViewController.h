//
//  ZS_TemplatesListViewController.h
//  Measurement
//
//  Created by DTSoft on 15/2/5.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  证书模版列表
 */

#import "BaseViewController.h"


@class ZS_TemplatesListViewController;

@protocol ZS_TemplatesListVCDelegate <NSObject>

-(void)ZS_TemplatesListVC:(ZS_TemplatesListViewController *) templatestVC didSelectedOKByObj:(id ) data;

@end


@interface ZS_TemplatesListViewController : BaseViewController


@property(nonatomic , strong)NSDictionary *m_zsParameterDict;

@property(nonatomic , assign)id<ZS_TemplatesListVCDelegate> m_delegate;

@end
