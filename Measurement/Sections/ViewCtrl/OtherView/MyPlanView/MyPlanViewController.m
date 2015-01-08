//
//  MyPlanViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/22.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "MyPlanViewController.h"
#import "MyPlanViewCell.h"
#import "OptionMenuTableViewController.h"
#import "UpdatePlanDetailsPopVC.h"
#import "MyPlanPopVC.h"
#import "backgroundV.h"
@interface MyPlanViewController ()<UIPopoverControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,DidOptionMenuDelegate,SwipeMyPlanViewCellDelegate,PopViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *m_flowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *m_collectionView;

@property (nonatomic, strong) NSIndexPath *lastIndex;
@property (nonatomic, strong) NSIndexPath *currentIndex;

@end

@implementation MyPlanViewController

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.m_netParamDict = [[NSMutableDictionary alloc]init];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"ToOptionMenuVC"] )
    {
        UINavigationController *nav = (UINavigationController*)[segue destinationViewController];
    
        OptionMenuTableViewController *OptionMenuTVC = (OptionMenuTableViewController*)[nav topViewController];
        OptionMenuTVC.m_optionMenuDelegate = self;
    
    }
    
    
    
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
    
    /**
     *  UICollectionView如果在数据不够一屏时上下滚动
     */
    self.m_collectionView.alwaysBounceVertical = YES;
    
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
    
    self.m_netFunctionStr = @"loadcDuty.do";
    
    [self.m_netParamDict setObject:@"1257" forKey:@"userCode"];
    [self.m_netParamDict setObject:[NSString stringWithFormat:@"%d",pageNo] forKey:@"pageNo"];
    [self.m_netParamDict setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"pageSize"];
    
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
    
    
    
    return self.m_DataSourceArr.count +1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"MyPlanViewCell";
    
    if (indexPath.row == self.m_DataSourceArr.count) {
        
        UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"OpenMyPlanViewCell" forIndexPath:indexPath];
//        [cell configureCellWithItem:self.m_DataSourceArr[indexPath.row]];
        //    cell.delegate = self;
        return cell;
        
    }else
    {
        MyPlanViewCell *cell = (MyPlanViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell configureCellWithItem:self.m_DataSourceArr[indexPath.row]];
        cell.delegate = self;
        return cell;
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.row == self.m_DataSourceArr.count) {
        
        MyPlanPopVC *popVc = [self.storyboard instantiateViewControllerWithIdentifier:@"popVC"];;
        popVc.m_popDelegate = self;
        self.m_popVC = [[UIPopoverController alloc] initWithContentViewController:popVc];
        self.m_popVC.delegate = self;
        
        //TODO:popoverLayoutMargins是指你的popover相对于整个window上下左右的margin
        self.m_popVC.popoverLayoutMargins = UIEdgeInsetsMake(20,0,0,0);
        
        self.m_popVC.popoverBackgroundViewClass = [backgroundV class];
        // 设定展示区域的大小
        // 从这个按钮点击的位置弹出，并且popVC的指向为这个按钮的中心。
        //    曾有段时间纠结于这个popVC的指向， 真是麻烦得很
        [self.m_popVC presentPopoverFromRect:collectionView.bounds
                                      inView:collectionView
                    permittedArrowDirections:0
                                    animated:YES];
        
        
    }


}
#pragma mark -  DidOptionMenuDelegate

-(void)OptionMenu:(OptionMenuTableViewController*) selectValueTVC DidsaveValue:(id)saveValue{
    
    debug_object(self.m_netParamDict);
    NSDictionary *dict = (NSDictionary *)saveValue;
    for(NSString *key in [dict allKeys])
    {
        [self.m_netParamDict setObject:dict[key] forKey:key];
    }
  debug_object(self.m_netParamDict);
    
    [self loadNetData];
    
}

#pragma mark - SwipeForOptionsCellDelegate Methods


- (void)MyPlanViewCell:(MyPlanViewCell *)cell didShowMenu:(BOOL)isShowingMenu
{
    if (isShowingMenu) {
        self.lastIndex = [self.m_collectionView indexPathForCell:cell];
    }
}

- (void)MyPlanViewCellDidEndScrolling:(MyPlanViewCell *)cell
{
    if (_lastIndex && _lastIndex.row != [self.m_collectionView indexPathForCell:cell].row) {
        cell = (MyPlanViewCell *)[self.m_collectionView cellForItemAtIndexPath:_lastIndex];
        [cell hideUtilityButtonsAnimated:YES];
    }
}

- (void)MyPlanViewcollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row  < self.m_DataSourceArr.count) {
        
        MyPlanPopVC *popVc = [self.storyboard instantiateViewControllerWithIdentifier:@"UpdatePlanDetailsPopVC"];;
//        popVc.m_popDelegate = self;
        self.m_popVC = [[UIPopoverController alloc] initWithContentViewController:popVc];
        self.m_popVC.delegate = self;
        
        //TODO:popoverLayoutMargins是指你的popover相对于整个window上下左右的margin
        self.m_popVC.popoverLayoutMargins = UIEdgeInsetsMake(20,0,0,0);
        
        self.m_popVC.popoverBackgroundViewClass = [backgroundV class];
        // 设定展示区域的大小
        // 从这个按钮点击的位置弹出，并且popVC的指向为这个按钮的中心。
        //    曾有段时间纠结于这个popVC的指向， 真是麻烦得很
        [self.m_popVC presentPopoverFromRect:collectionView.bounds
                                      inView:collectionView
                    permittedArrowDirections:0
                                    animated:YES];
        
        
    }
}

/**
 *  删除
 *
 *  @param cell
 */
- (void)deletePress:(MyPlanViewCell *)cell
{
    
    
     NSIndexPath *indexPath = [self.m_collectionView indexPathForCell:cell];

    
    [self.m_DataSourceArr removeObjectAtIndex:indexPath.row];
//    /**
//     *  第一种办法 删除cell
//     */
//    [self.m_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
    /**
     *   第二种办法 删除cell
     */
    [self.m_collectionView performBatchUpdates:^{
        [self.m_collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        
    } completion:nil];
//    [self.photoImages removeObjectAtIndex:row];
//    NSArray *deleteItems = @[indexPath];
//    [self.m_collectionView moveItemAtIndexPath:indexPath toIndexPath];
//    
//    - (void)moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath;
}

/**
 *  编辑
 *
 *  @param cell
 */
- (void)editorPress:(MyPlanViewCell *)cell
{
     [Dialog toast:@"editorPress"];
}

/**
 *  标记完成
 *
 *  @param cell
 */
- (void)markCompletedPress:(MyPlanViewCell *)cell
{
     [Dialog toast:@"markCompletedPress"];
}


#pragma mark - PopViewDelegate
-(void)dismissPopoverSelected
{

    [self.m_popVC dismissPopoverAnimated:YES];
}

@end
