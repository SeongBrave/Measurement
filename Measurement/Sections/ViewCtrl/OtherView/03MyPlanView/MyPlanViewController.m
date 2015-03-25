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
#import "AddPlanDetailsPopVC.h"
#import "backgroundV.h"
#import "DropDownListView.h"
#import "MyPlanOverviewVc.h"

@interface MyPlanViewController ()<UIPopoverControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,DidOptionMenuDelegate,SwipeMyPlanViewCellDelegate,PopViewDelegate,DropDownChooseDelegate,DropDownChooseDataSource>
{
    NSArray *chooseArray ;
}


@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *m_flowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *m_collectionView;

@property (nonatomic, strong) NSIndexPath *lastIndex;
@property (nonatomic, strong) NSIndexPath *currentIndex;
@property (weak, nonatomic) IBOutlet DropDownListView *dropDownDateList;

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
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.m_netParamDict];
        
        OptionMenuTVC.m_relValue = dict;
    
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
     *  jt今天/bz本周/by dwsjfw
     */
    chooseArray = @[ @{@"text":@"今日计划",@"code":@"jt"},@{@"text":@"本周计划",@"code":@"bz"},@{@"text":@"本月计划",@"code":@"by"},@{@"text":@"不传参",@"code":@""}];
    
    self.dropDownDateList.dropDownDelegate = self;
    self.dropDownDateList.dropDownDataSource = self;
    self.dropDownDateList.mSuperView = self.view;
    
    [self.dropDownDateList InitUI];
    
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
    self.m_superCollectionView = self.m_collectionView;
}

/**
 *  设置请求网络的参数
 */
-(void)setBaseNetWorkParameters
{
    
    LoginedUser *usr = [LoginedUser sharedInstance];
    
    self.m_netFunctionStr = @"loadcDuty.do";
    //pxfs
    [self.m_netParamDict setObject:usr.usercode forKey:@"userCode"];
    [self.m_netParamDict setObject:[NSString stringWithFormat:@"%d",pageNo] forKey:@"pageNo"];
    [self.m_netParamDict setObject:[NSString stringWithFormat:@"%d", self.pageSize] forKey:@"pageSize"];
    
    /**
     *  排序字段
     */
    [self.m_netParamDict setObject:@"cjsj" forKey:@"pxzd"];
    /**
     *  排序方式
     */
    [self.m_netParamDict setObject:@"jx" forKey:@"pxfs"];
    
}
- (IBAction)CreatePlanClick:(id)sender {
    
     [self showPopVC];
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
        
        
        [self showPopVC];
        
    }


}

-(void)showPopVC
{
//    AddPlanDetailsPopVC *popVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPlanDetailsPopVC"];;
//    popVc.m_popDelegate = self;
//    self.m_popVC = [[UIPopoverController alloc] initWithContentViewController:popVc];
//    self.m_popVC.delegate = self;
//    
//    //TODO:popoverLayoutMargins是指你的popover相对于整个window上下左右的margin
//    self.m_popVC.popoverLayoutMargins = UIEdgeInsetsMake(20,0,0,0);
//    
//    self.m_popVC.popoverBackgroundViewClass = [backgroundV class];
//    // 设定展示区域的大小
//    // 从这个按钮点击的位置弹出，并且popVC的指向为这个按钮的中心。
//    //    曾有段时间纠结于这个popVC的指向， 真是麻烦得很
//    [self.m_popVC presentPopoverFromRect:self.m_collectionView.bounds
//                                  inView:self.m_collectionView
//                permittedArrowDirections:0
//                                animated:YES];
    
    
    AddPlanDetailsPopVC *popVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPlanDetailsPopVC"];;
    popVc.m_popDelegate = self;
    popVc.m_superView = self;
    popVc.modalPresentationStyle = UIModalPresentationFormSheet;
    popVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:popVc animated:YES completion:nil];
    
}
#pragma mark -  DidOptionMenuDelegate

-(void)OptionMenu:(OptionMenuTableViewController*) selectValueTVC DidsaveValue:(id)saveValue{
    
    debug_object(self.m_netParamDict);
    NSDictionary *dict = (NSDictionary *)saveValue;
    for(NSString *key in [dict allKeys])
    {
        [self.m_netParamDict setObject:dict[key] forKey:key];
    }

    
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


        [self popProgramOverviewVcByIndexPath:indexPath];
        
    }
}
/**
 *  弹出预览界面
 *
 *  @param indexPath
 */
-(void)popProgramOverviewVcByIndexPath:(NSIndexPath *)indexPath
{
    MyPlanOverviewVc *popVc = (MyPlanOverviewVc*)[self.storyboard instantiateViewControllerWithIdentifier:@"MyPlanOverviewVc"];
    
    //        popVc.m_popDelegate = self;
    popVc.m_showDict = self.m_DataSourceArr[indexPath.row];
    popVc.modalPresentationStyle = UIModalPresentationFormSheet;
    popVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //        @weakify(self)
    [self presentViewController:popVc animated:YES completion:^(void){
        
    }];
}
/**
 *  弹出编辑界面
 *
 *  @param indexPath
 */
-(void)popUpdatePlanDetailVcByIndexPath:(NSIndexPath *)indexPath
{
    UpdatePlanDetailsPopVC *popVc = [self.storyboard instantiateViewControllerWithIdentifier:@"UpdatePlanDetailsPopVC"];;
    popVc.m_showDict = self.m_DataSourceArr[indexPath.row];
    popVc.modalPresentationStyle = UIModalPresentationFormSheet;
    popVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:popVc animated:YES completion:nil];
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
     NSIndexPath *indexPath = [self.m_collectionView indexPathForCell:cell];
    
    [self popUpdatePlanDetailVcByIndexPath:indexPath];
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


#pragma mark -- dropDownListDelegate
-(void)dismissPopoverSelected
{

    [self.m_popVC dismissPopoverAnimated:YES];
}

-(void) chooseAtindex:(NSInteger)index
{
    
    [self.m_netParamDict setObject:chooseArray[index][@"code"] forKey:@"dwsjfw"];
    
    [self loadNetData];

    
}
#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfindex
{
    return [chooseArray count];
}
-(NSString *)titleInindex:(NSInteger) index
{
    return chooseArray[index][@"text"];
}
-(NSInteger)defaultShowInindex
{
    return 0;
}



@end
