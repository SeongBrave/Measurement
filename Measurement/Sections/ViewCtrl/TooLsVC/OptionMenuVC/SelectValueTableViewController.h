//
//  SelectValueTableViewController.h
//  Measurement
//
//  Created by DTSoft on 14/12/28.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "BaseTableViewController.h"


typedef enum
{
    selectValueFinishState = 0,
    selectValueSortingfield,
    selectValueSortingWay
    
    
    
} SelectValueTVCType;

@class SelectValueTableViewController;

@protocol DidSelectedValueDelegate <NSObject>

-(void)SelectValueTVC:(SelectValueTableViewController*) selectValueTVC DidSelectedValue:(id)selectedValue;

@end

@interface SelectValueTableViewController : BaseTableViewController


@property(nonatomic , assign)SelectValueTVCType m_selectValueTVCType;
/**
 *  表示请求网络的方法
 */
@property(nonatomic , strong)NSString *m_netFunctionStr;

/**
 *  表示请求网络的参数
 */
@property(nonatomic , strong)NSDictionary *m_netParamDict;

@property(nonatomic , assign)id<DidSelectedValueDelegate> selectedDelegate;
/**
 *  显示的数据格式为:@{@"text":@"显示的数据",@"data":@"保存的值"}
 */
@property(nonatomic , strong)NSArray *m_dataSourceArr;
@end
