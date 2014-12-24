//
//  CommonLogicViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/22.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "CommonLogicViewController.h"
#import "CommonLogicCell.h"
#import "BaseNetWork.h"
#import "MJRefresh.h"
#import "CompanyCollectionViewCell.h"

@interface CommonLogicViewController ()<MJRefreshBaseViewDelegate,SwipeCellDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
     CommonLogicCell *oldCell;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;

}
@property (weak, nonatomic) IBOutlet UICollectionView *m_CollectionView;
@end

@implementation CommonLogicViewController

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
    header.scrollView = self.m_CollectionView;
    header.delegate = self;
    // 自动刷新
    [header beginRefreshing];
    _header = header;
    
    // 3.2.上拉加载更多
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.m_CollectionView;
    footer.delegate = self;
    _footer = footer;
    
    self.m_tableName = @"CommonLogicViewController";
    
    self.m_store = [[YTKKeyValueStore alloc] initDBWithName:@"Measurement.db"];
    
//    [self loadNetData];
    
}
-(void)loadNetData
{
    NSDictionary *dict = [[NSDictionary alloc]init];
    [[[[BaseNetWork getInstance] rac_getPath:@"http://192.168.10.169:8080/mbs/convey/findJhzl.do" parameters:dict]map:^(id responseData)
    {
          NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
        
 
        return [dict valueForKeyPath:@"page.result"];
    }]subscribeNext:^(NSArray *arr){
        
        [self.m_store createTableWithName:self.m_tableName];
        [self.m_store putObject:arr withId:@"page.result" intoTable:self.m_tableName];
        self.m_DataSourceArr = arr;
        
        [self.m_CollectionView reloadData];
        
        
    }error:^(NSError *error){
        
        NSArray *arr = [self.m_store getObjectById:@"page.result" fromTable:self.m_tableName];
        self.m_DataSourceArr = arr;
        
        [self.m_CollectionView reloadData];
    
    
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

#pragma mark - 代理协议方法*
#pragma mark - UIPopoverControllerDelegate

//- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
//{
//    return YES;
//}
//
//- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
//{
//    //    [dictPopoverTVC.searchDisplayController setActive:NO animated:YES];
//    //    [dictPopoverTVC.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];//CGRectMake(0, 0, 1, 1)
//    //    dictPopoverTVC.selectedObject = nil;
//}


#pragma mark - UICollectionViewDataSource
// TODO:定义展示的UICollectionViewCell的个数
#pragma mark - UICollectionView Delegate Method

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.m_DataSourceArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CompanyCell";
    CompanyCollectionViewCell *cell = (CompanyCollectionViewCell  *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configureCellWithItem:self.m_DataSourceArr[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate

//TODO: UICollectionView被选中时调用的方法

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//
//{
//
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.selected = YES;
//
//
//}

//返回这个UICollectionView是否可以被选择
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return YES;
//
//}

//
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//
//    cell.backgroundColor = [UIColor colorWithRed:121/255.0 green:180/255.0 blue:221/255.0 alpha:1];
//
//    [collectionView reloadData];
//
//}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (oldCell == nil) {
//        CommonLogicCell * cell = (CommonLogicCell *)[collectionView cellForItemAtIndexPath:indexPath];
//        oldCell = cell;
//        // cell.contentView.layer.cornerRadius = 10.0;
//        cell.contentView.layer.borderWidth = 5.0f;
//        cell.contentView.layer.borderColor = [UIColor colorWithRed:121/255.0 green:180/255.0 blue:221/255.0 alpha:1].CGColor;
//        
//        
//    }else
//    {
//        [oldCell updateOldCollectionCell];
//        CommonLogicCell * cell = (CommonLogicCell *)[collectionView cellForItemAtIndexPath:indexPath];
//        // cell.contentView.layer.cornerRadius = 10.0;
//        cell.contentView.layer.borderWidth = 5.0f;
//        cell.contentView.layer.borderColor = [UIColor colorWithRed:121/255.0 green:180/255.0 blue:221/255.0 alpha:1].CGColor;
//        oldCell = cell;
//        
//        
//    }
    
    
    
}
//返回这个UICollectionView是否可以被选择

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
    
}

// 开始进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
}
// 刷新完毕就会调用
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"%@----刷新完毕", refreshView.class);
}
// 刷新状态变更就会调用
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    switch (state) {
        case MJRefreshStateNormal:
            NSLog(@"%@----切换到：普通状态", refreshView.class);
            break;
            
        case MJRefreshStatePulling:
            NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
            break;
            
        case MJRefreshStateRefreshing:
            NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
            break;
        default:
            break;
    }
}

@end
