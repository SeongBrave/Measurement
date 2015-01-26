//
//  TemplatesListViewController.h
//  Measurement
//
//  Created by DTSoft on 15/1/23.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  模版列表
 */
#import "BaseViewController.h"


typedef enum
{
    CertificateType = 0,
    RecordType,
    
} TemplatesListType;

@interface TemplatesListViewController : BaseViewController


@property(nonatomic , assign)TemplatesListType m_templatesType;




@end
