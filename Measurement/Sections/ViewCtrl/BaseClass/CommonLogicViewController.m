//
//  CommonLogicViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/22.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "CommonLogicViewController.h"


@interface CommonLogicViewController ()
{

}
@end

@implementation CommonLogicViewController

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

// TODO: 使用autolayout 布局界面
- (void)updateViewConstraints
{
    [super updateViewConstraints];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - 自定义方法

//TODO: 添加视图
-(void)layoutMainCustomView
{
    
    
}

-(void)SetUpData
{
    [super SetUpData];
    
    self.m_tableName = @"CommonLogicViewController";
    
    self.m_store = [[YTKKeyValueStore alloc] initDBWithName:@"Measurement.db"];
    
    [self layoutMainCustomView];
    
    // 3.集成刷新控件
    // 3.1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.delegate = self;
    // 自动刷新
    [header beginRefreshing];
    _header = header;
    
    // 3.2.上拉加载更多
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.delegate = self;
    _footer = footer;
    
    [self setCollectionToRefreshDelegate];
    
    pageNo = 1;
    pageSize = 10;
    
}

#pragma mark --必须被重载

/**
 *  设置为collection的加载
 */
-(void)setCollectionToRefreshDelegate
{
    
}

/**
 *  设置请求网络的参数
 */
-(void)setBaseNetWorkParameters
{
    
}

/**
 *  请求成功后调用的方法
 *
 *  @param responseData
 */
-(void)successGetDataWithResponseData:(id)responseData
{
    
}

/**
 *  请求成功后调用的方法
 *
 *  @param responseData
 */
-(void)failedGetDataWithResponseData:(id)responseData
{
    
}
-(void)loadNetData
{
    [self setBaseNetWorkParameters];
    /**
     *  设置加载时显示提示
     */
    [[BaseNetWork getInstance] showDialog];
    @weakify(self)
    [[[[BaseNetWork getInstance] rac_getPath:self.m_netFunctionStr parameters:self.m_netParamDict]map:^(id responseData)
      {
          NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
          
          return [dict valueForKeyPath:@"page.result"];
      }]subscribeNext:^(NSArray *arr){
          @strongify(self)
          [self.m_store createTableWithName:self.m_tableName];
          [self.m_store putObject:arr withId:@"page.result" intoTable:self.m_tableName];
          self.m_DataSourceArr = arr;
          [_header endRefreshing];
          [_footer endRefreshing];
          
          [self successGetDataWithResponseData:arr];
          //          [self.m_collectionView reloadData];
          
          
      }error:^(NSError *error){
          @strongify(self)
          NSArray *arr = [self.m_store getObjectById:@"page.result" fromTable:self.m_tableName];
          self.m_DataSourceArr = arr;
          [_header endRefreshing];
          [_footer endRefreshing];
          
          [self failedGetDataWithResponseData:arr];
          //          [self.m_collectionView reloadData];
          
          
      }];
    
    
}



#pragma mark - MJRefreshBaseViewDelegate

// 开始进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    //下拉加载更多
    if(refreshView == _footer)
    {
        pageSize+=5;
        [self loadNetData];
        
    }else if(refreshView == _header) //刷新
    {
        pageSize = 10;
        [self loadNetData];
        
    }
    
    
}
// 刷新完毕就会调用
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    [refreshView endRefreshing];
}
// 刷新状态变更就会调用
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    
}

@end
