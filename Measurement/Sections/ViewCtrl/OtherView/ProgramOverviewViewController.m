//
//  ProgramOverviewViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "ProgramOverviewViewController.h"
#import "ProgramOverviewCell.h"
#import "BaseNetWork.h"


@interface ProgramOverviewViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *m_flowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *m_collectionView;
@end

@implementation ProgramOverviewViewController




#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUpData];
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
    [self loadNetData];
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
    
    
    [self layoutMainCustomView];
    [self AddNavgationBarItem];
    
    // 3.集成刷新控件
    // 3.1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.m_collectionView;
    header.delegate = self;
    // 自动刷新
    [header beginRefreshing];
    _header = header;
    
    // 3.2.上拉加载更多
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.m_collectionView;
    footer.delegate = self;
    _footer = footer;
    
    self.m_tableName = @"CommonLogicViewController";
    
    self.m_store = [[YTKKeyValueStore alloc] initDBWithName:@"Measurement.db"];
    
    /**
     *  横向每个cell的间距
     */
    [self.m_flowLayout setMinimumInteritemSpacing:15];
    /**
     *  纵向每个cell的间距
     */
    [self.m_flowLayout setMinimumLineSpacing:25];
    
    [self.m_flowLayout setSectionInset:UIEdgeInsetsMake(10, 40, 10, 40)];
    
    self.title = @"计划总览";
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)loadNetData
{
    
    
    NSDictionary *dict = [[NSDictionary alloc]init];
    @weakify(self)
    [[[[BaseNetWork getInstance] rac_getPath:@"findJhzl.do" parameters:dict]map:^(id responseData)
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
          [self.m_collectionView reloadData];
          
          
      }error:^(NSError *error){
          @strongify(self)
          NSArray *arr = [self.m_store getObjectById:@"page.result" fromTable:self.m_tableName];
          self.m_DataSourceArr = arr;
          [_header endRefreshing];
          [_footer endRefreshing];
          [self.m_collectionView reloadData];
          
          
      }];
    
}
-(void)AddNavgationBarItem
{
    
    UIBarButtonItem *leftBtn =[[UIBarButtonItem alloc] initWithTitle:@"群组" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBtnClick:)];
    [leftBtn setImage:[UIImage imageNamed:@"nav_Call"]];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc] initWithTitle:@"群组" style:UIBarButtonItemStyleBordered target:self action:@selector(rightBtnClick:)];
    [rightBtn setImage:[UIImage imageNamed:@"nav_MultipartyCalls"]];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
}
-(void)leftBtnClick:(id)sender
{
    [Dialog toast:@"left"];
}

-(void)rightBtnClick:(id)sender
{
    [Dialog toast:@"right"];
}



#pragma mark - UICollectionViewDataSource
// TODO:定义展示的UICollectionViewCell的个数
#pragma mark - UICollectionView Delegate Method

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ProgramOverview";
    ProgramOverviewCell *cell = (ProgramOverviewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configureCellWithItem:self.m_DataSourceArr[indexPath.row]];
//    cell.delegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate



@end
