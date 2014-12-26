//
//  BaseViewController.h
//  FoodDelivery
//
//  Created by DTSoft on 14-10-14.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface BaseViewController : UIViewController<MJRefreshBaseViewDelegate>
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    
}

/**
 *  表示请求网络的方法
 */
@property(nonatomic , strong)NSString *m_netFunctionStr;

/**
 *  表示请求网络的参数
 */
@property(nonatomic , strong)NSDictionary *m_netParamDict;



@property(nonatomic , strong)NSArray * m_DataSourceArr;

/**
 *  本地数据库
 */
@property(nonatomic , strong)YTKKeyValueStore *m_store;

/**
 *  保存数据的表名
 */
@property(nonatomic , strong)NSString *m_tableName;


/**
 *  添加视图
 */
-(void)layoutMainCustomView;

/**
 *  初始化界面
 */
-(void)SetUpData;

/**
 *  加载数据
 */
-(void)loadNetData;

#pragma mark --必须被重载

/**
 *  设置为collection的加载
 */
-(void)setCollectionToRefreshDelegate;

/**
 *  设置请求网络的参数
 */
-(void)setBaseNetWorkParameters;

/**
 *  请求成功后调用的方法
 *
 *  @param responseData
 */
-(void)successGetDataWithResponseData:(id)responseData;

/**
 *  请求成功后调用的方法
 *
 *  @param responseData
 */
-(void)failedGetDataWithResponseData:(id)responseData;




@end
