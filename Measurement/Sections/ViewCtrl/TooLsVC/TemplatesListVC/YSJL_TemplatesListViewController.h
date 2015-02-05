//
//  YSJL_TemplatesListViewController.h
//  Measurement
//
//  Created by DTSoft on 15/2/5.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "BaseViewController.h"


@class YSJL_TemplatesListViewController;

@protocol YSJL_TemplatesListVCDelegate <NSObject>

-(void)YSJL_TemplatesListVC:(YSJL_TemplatesListViewController *) templatestVC didSelectedOKByObj:(id ) data;

@end



@interface YSJL_TemplatesListViewController : BaseViewController

@property(nonatomic , strong)NSDictionary *m_ysjlParameterDict;
@property(nonatomic , assign)id<YSJL_TemplatesListVCDelegate> m_delegate;

@end
