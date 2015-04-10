//
//  AppMacro.h
//  MClinicalNursing
//
//  Created by 成勇 on 14-4-4.
//  Copyright (c) 2014年 成勇. All rights reserved.
//


//放app相关的宏定义

#ifndef MClinicalNursing_AppMacro_h
#define MClinicalNursing_AppMacro_h

//登录界面标题
#define  LoginView_mainView_Title  @"床边护理工作站"

#define ISDEBUG   YES

#define WEBURLKEY @"WebUrlKey"

#define WEBCLASSNAME @"Transfusion.asmx"

//系统标示(本院:by/精仪:jy)

#define MBS_XTBS @"by"

#define WEBURL [NSString stringWithFormat:@"%@:%@",[[FileHelpers readPreferences][@"name_preference"] isEqualToString:@""]?@"192.168.10.169":[FileHelpers readPreferences][@"name_preference"] ,[[FileHelpers readPreferences][@"port_preference"]isEqualToString:@""]?@"8080":[FileHelpers readPreferences][@"port_preference"]]


//webservice配置 主
#define defaultWebServiceUrl [NSString stringWithFormat:@"http://%@/mbs/convey/",WEBURL]


typedef enum
{
    TxmDataSourceType = 0,
    TxmNotDataSourceType,
    YqidDataSourceType,
    NullDataSourceType,
    
} DataSourceType;

//webservice配置 默认是这样的
//#define defaultWebServiceUrl @"http://192.168.10.169:8080/mbs/convey/"



//DaoTongHttpManager





#endif
