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
#import "OptionMenuTableViewController.h"
#import "PopViewDelegate.h"
#import "backgroundV.h"
#import "ProgramOverviewDidHYPopViewController.h"

@interface ProgramOverviewViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,DidOptionMenuDelegate,PopViewDelegate,UIPopoverControllerDelegate>
{
    OptionMenuTableViewController *OptionMenuTVC;
}


@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *m_flowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *m_collectionView;
@end

@implementation ProgramOverviewViewController



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
        
        OptionMenuTVC = (OptionMenuTableViewController*)[nav topViewController];
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
    
    self.m_netFunctionStr = @"findJhzl.do";
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
    return self.m_DataSourceArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *cellIdentifier = @"ProgramOverviewCell";

    if (indexPath.row == self.m_DataSourceArr.count) {
        
        UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"OpenMyPlanViewCell" forIndexPath:indexPath];
        //        [cell configureCellWithItem:self.m_DataSourceArr[indexPath.row]];
        //    cell.delegate = self;
        return cell;
        
    }else
    {
        ProgramOverviewCell *cell = (ProgramOverviewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell configureCellWithItem:self.m_DataSourceArr[indexPath.row]];
        //    cell.delegate = self;
        return cell;
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row  < self.m_DataSourceArr.count) {
        
        
        ProgramOverviewDidHYPopViewController *popVc = (ProgramOverviewDidHYPopViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ProgramOverviewDidHYPopViewController"];
        popVc.m_superView = self;
//        popVc.m_popDelegate = self;
        popVc.m_showDict = self.m_DataSourceArr[indexPath.row];
        popVc.modalPresentationStyle = UIModalPresentationFormSheet;
        popVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        //        @weakify(self)
        [self presentViewController:popVc animated:YES completion:^(void){
            
        }];
        
    }
    
    
}

#pragma mark -  DidOptionMenuDelegate

-(void)OptionMenu:(OptionMenuTableViewController*) selectValueTVC DidsaveValue:(id)saveValue{
    

    NSDictionary *dict = (NSDictionary *)saveValue;

    [self.m_netParamDict setValuesForKeysWithDictionary:dict];

    
    [self loadNetData];
    
}
#pragma mark - UIPopoverControllerDelegate
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return NO;
}

#pragma mark - PopViewDelegate
-(void)dismissPopoverSelected
{
    [self.m_popVC dismissPopoverAnimated:YES];
}
@end
