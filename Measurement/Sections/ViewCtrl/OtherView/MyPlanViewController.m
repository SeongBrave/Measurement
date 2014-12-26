//
//  MyPlanViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/22.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "MyPlanViewController.h"

@interface MyPlanViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *m_flowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *m_collectionView;
@end

@implementation MyPlanViewController

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadNetData];
}

#pragma mark - 自定义方法


#pragma mark - 必须重载的方法
/**
 *  初始化界面
 */
-(void)SetUpData
{
    [super SetUpData];
    
    self.m_tableName = @"CommonLogicViewController";
    self.title = @"我的创建计划";
    
    /**
     *  横向每个cell的间距
     */
    [self.m_flowLayout setMinimumInteritemSpacing:15];
    /**
     *  纵向每个cell的间距
     */
    [self.m_flowLayout setMinimumLineSpacing:25];
    
    [self.m_flowLayout setSectionInset:UIEdgeInsetsMake(10, 40, 10, 40)];
    
}

/**
 *  添加视图
 */
-(void)layoutMainCustomView
{
    [super layoutMainCustomView];
}

/**
 *  加载数据
 */
-(void)loadNetData
{
    [super loadNetData];
}


//TODO:必须重载的方法

/**
 *  设置为collection的加载
 */
-(void)setCollectionToRefreshDelegate
{
    _header.scrollView = self.m_collectionView;
    _footer.scrollView = self.m_collectionView;
}

/**
 *  设置请求网络的参数
 */
-(void)setBaseNetWorkParameters
{
    self.m_netParamDict = [[NSDictionary alloc]init];
    
    self.m_netFunctionStr = @"findJhzl.do";
    
}

/**
 *  请求成功后调用的方法
 *
 *  @param responseData
 */
-(void)successGetDataWithResponseData:(id)responseData
{
    [self.m_collectionView reloadData];
}

/**
 *  请求成功后调用的方法
 *
 *  @param responseData
 */
-(void)failedGetDataWithResponseData:(id)responseData
{
    [self.m_collectionView reloadData];
}
#pragma mark - 代理协议方法*

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentifier = @"ProgramOverview";
//    ProgramOverviewCell *cell = (ProgramOverviewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    [cell configureCellWithItem:self.m_DataSourceArr[indexPath.row]];
//    //    cell.delegate = self;
    return nil;
}

@end
