//
//  CommonLogicViewController.h
//  Measurement
//
//  Created by DTSoft on 14/12/22.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"

@interface CommonLogicViewController : BaseViewController
{
    
    /**
     *  当前页码
     */
    int pageNo;  
    /**
     *  每页显示数
     */
    
}

@property(nonatomic , assign) __block int pageSize;

@property (nonatomic, retain) UICollectionView *m_superCollectionView;

@property(nonatomic , strong)UIPopoverController *m_popVC;

/**
 *  表示请求网络的方法
 */
@property(nonatomic , strong)NSString *m_netFunctionStr;

/**
 *  表示请求网络的参数
 */
@property(nonatomic , strong)NSMutableDictionary *m_netParamDict;



@property(nonatomic , strong)NSMutableArray * m_DataSourceArr;

/**
 *  本地数据库
 */
@property(nonatomic , strong)YTKKeyValueStore *m_store;

/**
 *  保存数据的表名
 */
@property(nonatomic , strong)NSString *m_tableName;


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
