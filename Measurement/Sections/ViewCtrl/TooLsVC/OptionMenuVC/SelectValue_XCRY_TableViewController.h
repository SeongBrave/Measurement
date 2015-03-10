//
//  SelectValue_XCRY_TableViewController.h
//  Measurement
//
//  Created by DTSoft on 14/12/29.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

/**
 *  科室人员 
 */
#import "BaseTableViewController.h"

@class SelectValue_XCRY_TableViewController;

@protocol DidSelectedValue_XCRY_Delegate <NSObject>

-(void)SelectValue_XCRY_TVC:(SelectValue_XCRY_TableViewController*) selectValueTVC DidSelectedValue:(id)selectedValue;

@end


@interface SelectValue_XCRY_TableViewController : BaseTableViewController
@property(nonatomic , assign)BOOL isLoadData;
/**
 *  表示请求网络的方法
 */
@property(nonatomic , strong)NSString *m_netFunctionStr;

/**
 *  表示请求网络的参数
 */
@property(nonatomic , strong)NSDictionary *m_netParamDict;


@property(nonatomic , strong)NSString *m_comCode;

@property(nonatomic , assign)id<DidSelectedValue_XCRY_Delegate> selectedDelegate;

@property(nonatomic , strong)NSString *m_selectedItem;

/**
 *  显示的数据格式为:@{@"text":@"显示的数据",@"data":@"保存的值"}
 */
@property(nonatomic , strong)NSArray *m_dataSourceArr;

@end
