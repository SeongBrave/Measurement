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

@interface CommonLogicViewController ()
{
     CommonLogicCell *oldCell;

}
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
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumLineSpacing:10];
    [flowLayout setMinimumInteritemSpacing:10];
    [flowLayout setItemSize:CGSizeMake(220.0f, 200.0f)];
    [flowLayout setHeaderReferenceSize:CGSizeMake([self.view bounds].size.width, 20.0f)];
    self.m_CollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.m_CollectionView.backgroundColor = [UIColor lightGrayColor];
    self.m_CollectionView.delegate = self;
    self.m_CollectionView.dataSource = self;
    
    
    [self.view addSubview:self.m_CollectionView];
    
    [self.m_CollectionView registerClass:[CommonLogicCell class]
              forCellWithReuseIdentifier:@"CommonLogicCell"];
    
    
    /**
     *  m_companyNameL
     *
     *  @param make
     *
     *  @return
     */
    [ self.m_CollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.equalTo(@0);
        make.leading.equalTo(@0);
        make.bottom.equalTo(@0);
          make.trailing.equalTo(@0);
        
    }];
    
    self.view.backgroundColor = [UIColor redColor];
}

-(void)SetUpData
{
    
    
    [self layoutMainCustomView];
    [self AddNavgationBarItem];
    
    self.m_tableName = @"CommonLogicViewController";
    
    self.m_store = [[YTKKeyValueStore alloc] initDBWithName:@"Measurement.db"];
    
    [self loadNetData];
    
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
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.m_DataSourceArr.count;
    
}
//TODO:定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

//TODO:每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //设置cell多选功能
    //  collectionView.allowsMultipleSelection = YES;
    static NSString * CellIdentifier = @"CommonLogicCell";
    
    CommonLogicCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    [cell updateCommonLogicCellWith:self.m_DataSourceArr[indexPath.row]];
    
    
    //     cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a.jpg"]];
    //cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

//TODO:定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(230, 190);

}
//TODO:定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section

{
    return UIEdgeInsetsMake(10, 10, 10,10);
    
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
    if (oldCell == nil) {
        CommonLogicCell * cell = (CommonLogicCell *)[collectionView cellForItemAtIndexPath:indexPath];
        oldCell = cell;
        // cell.contentView.layer.cornerRadius = 10.0;
        cell.contentView.layer.borderWidth = 5.0f;
        cell.contentView.layer.borderColor = [UIColor colorWithRed:121/255.0 green:180/255.0 blue:221/255.0 alpha:1].CGColor;
        
        
    }else
    {
        [oldCell updateOldCollectionCell];
        CommonLogicCell * cell = (CommonLogicCell *)[collectionView cellForItemAtIndexPath:indexPath];
        // cell.contentView.layer.cornerRadius = 10.0;
        cell.contentView.layer.borderWidth = 5.0f;
        cell.contentView.layer.borderColor = [UIColor colorWithRed:121/255.0 green:180/255.0 blue:221/255.0 alpha:1].CGColor;
        oldCell = cell;
        
        
    }
    
    
    
}
//返回这个UICollectionView是否可以被选择

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
    
}

@end
