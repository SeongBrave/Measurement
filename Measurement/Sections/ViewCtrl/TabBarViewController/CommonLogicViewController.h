//
//  CommonLogicViewController.h
//  Measurement
//
//  Created by DTSoft on 14/12/22.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "BaseViewController.h"

@interface CommonLogicViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic , strong) UICollectionView *m_CollectionView;

@property(nonatomic , strong) NSArray *m_DataSourceArr;  //患者信息

/**
 *  本地数据库
 */
@property(nonatomic , strong)YTKKeyValueStore *m_store;

/**
 *  保存数据的表名
 */
@property(nonatomic , strong)NSString *m_tableName;

#pragma mark - 自定义方法


-(void)SetUpData;

//TODO: 添加视图
-(void)layoutMainCustomView;

-(void)loadNetData;
@end
