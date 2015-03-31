//
//  PlanningDepartmentViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/22.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "PlanningDepartmentViewController.h"
#import "MyPlanViewCell.h"
#import "OptionMenuTableViewController.h"
#import "UpdatePlanDetailsPopVC.h"
#import "AddPlanDetailsPopVC.h"
#import "backgroundV.h"
#import "DropDownListView.h"
#import "PlanningDepartmentDidHYPopViewController.h"
#import "DepManViewController.h"
#import "Rwfp_PopVc.h"
#import "rwfp_model.h"

@interface PlanningDepartmentViewController ()<UIPopoverControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,DidOptionMenuDelegate,SwipeMyPlanViewCellDelegate,PopViewDelegate,DropDownChooseDelegate,DropDownChooseDataSource,Rwfp_PopVcDelegate>
{
    NSArray *chooseArray ;
}

/**
 *  分配任务时的科室人员数组
 */
@property(nonatomic , strong)NSArray *m_ksry_Arr;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *m_flowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *m_collectionView;

@property (nonatomic, strong) NSIndexPath *lastIndex;
@property (nonatomic, strong) NSIndexPath *currentIndex;
@property (weak, nonatomic) IBOutlet DropDownListView *dropDownDateList;

@end

@implementation PlanningDepartmentViewController

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

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
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
    
    
//    LoginedUser *usr = [LoginedUser sharedInstance];
//    
//    
//    
//    /**
//     *  设置加载时显示提示
//     */
//    [[BaseNetWork getInstance] hideDialog];
//    @weakify(self)
//    [[[[BaseNetWork getInstance] rac_postPath:@"getKsry.do" parameters:@{@"comCode":usr.comcode}]map:^(id responseData)
//      {
//          NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
//          
//          return [dict valueForKeyPath:@"ksry"];
//          
//      }]subscribeNext:^(NSArray *arr)
//     {
//         
//         //comcname
//         @strongify(self)
//         self.m_ksry_Arr =[arr linq_select:^id(NSDictionary *dict){
//             
//             ry_Model *ryModel = [MTLJSONAdapter modelOfClass:[ry_Model class] fromJSONDictionary:dict error:nil];
//             ryModel.isSelected = NO;
//             ryModel.isCheckBox = YES;
//             
//             
//             return ryModel;
//         }];
//  
//     }error:^(NSError *error){
//         
//         //          [self.m_collectionView reloadData];
//         
//         
//     }];
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
    
    self.m_netFunctionStr = @"findKsjh.do";
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
-(void)Get_findDutyRwfpByRwbh:(NSString *) rwbhStr
{
    
//    findDutyRwfp.do
    
    LoginedUser *usr = [LoginedUser sharedInstance];
    @weakify(self)
    /**
     *  获取任务分配
     */
    [[BaseNetWork getInstance] showDialogWithVC:self];
    [[[[[BaseNetWork getInstance] rac_postPath:@"findDutyRwfp.do" parameters:@{@"rwbh":rwbhStr,@"userCode":usr.usercode}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary *retDict) {
         
         
         if ([retDict[@"ret"]intValue] == 1) {
             
             NSArray *ksryArr = retDict[@"ksry"];
             
             //comcname
             @strongify(self)
             self.m_ksry_Arr =[ksryArr linq_select:^id(NSDictionary *dict){
                 
                 rwfp_model *ryModel = [MTLJSONAdapter modelOfClass:[rwfp_model class] fromJSONDictionary:dict error:nil];
                 
                 return ryModel;
             }];
             
             
             Rwfp_PopVc *depManVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Rwfp_PopVc"];
             
             depManVC.m_delegate = self;
             depManVC.m_shaowDict = @{@"rwbh":rwbhStr};
             depManVC.modalPresentationStyle = UIModalPresentationFormSheet;
             depManVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
             depManVC.m_dataSourceArr = self.m_ksry_Arr;
             [self presentViewController:depManVC animated:YES completion:nil];
             //    depManVC.view.superview.bounds = CGRectMake(0, 0, 529, 279);
             depManVC.view.superview.frame = CGRectMake(100, 200, 529, 279);//it's important to do this after presentModalViewController
             depManVC.view.superview.center = self.view.center;
         }else
         {
             [Dialog toastError:@"没有数据!"];
         }
       

         
         
     }error:^(NSError *error){
         
         
     }];

    
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
    
    
    
    return self.m_DataSourceArr.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"MyPlanViewCell";
    
        MyPlanViewCell *cell = (MyPlanViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell configureCellWithItem:self.m_DataSourceArr[indexPath.row]];
        cell.delegate = self;
        return cell;

    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.m_DataSourceArr.count) {
        
        
        [self showPopVC];
        
    }
    
    
}

-(void)showPopVC
{
    AddPlanDetailsPopVC *popVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPlanDetailsPopVC"];;
    popVc.m_popDelegate = self;
    self.m_popVC = [[UIPopoverController alloc] initWithContentViewController:popVc];
    self.m_popVC.delegate = self;
    
    //TODO:popoverLayoutMargins是指你的popover相对于整个window上下左右的margin
    self.m_popVC.popoverLayoutMargins = UIEdgeInsetsMake(20,0,0,0);
    
    self.m_popVC.popoverBackgroundViewClass = [backgroundV class];
    // 设定展示区域的大小
    // 从这个按钮点击的位置弹出，并且popVC的指向为这个按钮的中心。
    //    曾有段时间纠结于这个popVC的指向， 真是麻烦得很
    [self.m_popVC presentPopoverFromRect:self.m_collectionView.bounds
                                  inView:self.m_collectionView
                permittedArrowDirections:0
                                animated:YES];
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
        
        
        PlanningDepartmentDidHYPopViewController *popVc = [self.storyboard instantiateViewControllerWithIdentifier:@"PlanningDepartmentDidHYPopViewController"];;
        popVc.m_showDict = self.m_DataSourceArr[indexPath.row];
        popVc.modalPresentationStyle = UIModalPresentationFormSheet;
        popVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        [self presentViewController:popVc animated:YES completion:nil];
        
//        UpdatePlanDetailsPopVC *popVc = [self.storyboard instantiateViewControllerWithIdentifier:@"UpdatePlanDetailsPopVC"];;
//        popVc.m_showDict = self.m_DataSourceArr[indexPath.row];
//        
//        debug_object(popVc.m_showDict);
//        self.m_popVC = [[UIPopoverController alloc] initWithContentViewController:popVc];
//        self.m_popVC.delegate = self;
//        
//        //TODO:popoverLayoutMargins是指你的popover相对于整个window上下左右的margin
//        self.m_popVC.popoverLayoutMargins = UIEdgeInsetsMake(20,0,0,0);
//        
//        self.m_popVC.popoverBackgroundViewClass = [backgroundV class];
//        // 设定展示区域的大小
//        // 从这个按钮点击的位置弹出，并且popVC的指向为这个按钮的中心。
//        //    曾有段时间纠结于这个popVC的指向， 真是麻烦得很
//        [self.m_popVC presentPopoverFromRect:collectionView.bounds
//                                      inView:collectionView
//                    permittedArrowDirections:0
//                                    animated:YES];
        
        
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
    
    
    
    NSDictionary *dict = self.m_DataSourceArr[indexPath.row];
    
    [self Get_findDutyRwfpByRwbh:dict[@"RWBH"]];


    
    
    
//    
//    NSIndexPath *indexPath = [self.m_collectionView indexPathForCell:cell];
//    
//    
//    [self.m_DataSourceArr removeObjectAtIndex:indexPath.row];
//    //    /**
//    //     *  第一种办法 删除cell
//    //     */
//    //    [self.m_collectionView deleteItemsAtIndexPaths:@[indexPath]];
//    
//    /**
//     *   第二种办法 删除cell
//     */
//    [self.m_collectionView performBatchUpdates:^{
//        [self.m_collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
//        
//    } completion:nil];
//    //    [self.photoImages removeObjectAtIndex:row];
//    //    NSArray *deleteItems = @[indexPath];
//    //    [self.m_collectionView moveItemAtIndexPath:indexPath toIndexPath];
//    //
//    //    - (void)moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath;
}

/**
 *  编辑
 *
 *  @param cell
 */
- (void)editorPress:(MyPlanViewCell *)cell
{
    
    NSIndexPath *indexPath = [self.m_collectionView indexPathForCell:cell];
    
    debug_int(indexPath.row);
    
    NSDictionary *dict = [self.m_DataSourceArr objectAtIndex:indexPath.row];
    
    
    LoginedUser *usr = [LoginedUser sharedInstance];
    /**
     *  设置加载时显示提示
     */
    [[BaseNetWork getInstance] hideDialog];
    [[[[BaseNetWork getInstance] rac_postPath:@"dutyRwlq.do" parameters:@{@"rwbh":dict[@"RWBH"],@"userCode":usr.usercode}]map:^(id responseData)
      {
          NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
          
          return dict;
          
      }]subscribeNext:^(NSDictionary *retDict)
     {
         if ([retDict[@"ret"] intValue] ==1) {
             
             [Dialog toast:self withMessage:@"领取成功!"];
         }else
         {
             [Dialog toast:self withMessage:retDict[@"message"]];
         }

     }error:^(NSError *error){
         
         //          [self.m_collectionView reloadData];
         
         
     }];
//    http://IPaddress:port/mbs/convey/dutyRwlq.do
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

#pragma  mark - Rwfp_PopVcDelegate

-(void)Rwfp_PopVc:(Rwfp_PopVc *)depManVC didSelectedArr:(NSArray *) selectedArr
{
    
}
@end
