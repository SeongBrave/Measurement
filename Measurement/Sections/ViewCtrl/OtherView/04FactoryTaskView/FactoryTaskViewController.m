//
//  FactoryTaskViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/22.
//  Copyright (c) 2014年 成勇. All rights r    eserved.
//

#import "FactoryTaskViewController.h"
#import "FactoryTaskCell.h"
#import <UIColor+HexString.h>
#import "CompanyCollectionViewCell.h"
#import "OptionMenuTableViewController.h"
#import "FactoryTaskDetailViewPopVC.h"
#import "AddPlanDetailsPopVC.h"
#import "backgroundV.h"
#import "DropDownListView.h"


@interface FactoryTaskViewController ()<UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate, SwipeCompanyCollectionViewCellDelegate,UIPopoverControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,DidOptionMenuDelegate,PopViewDelegate,DropDownChooseDelegate,DropDownChooseDataSource>
{
    NSArray *chooseArray ;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UICollectionView *m_collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *m_flowLayout;

@property (nonatomic, strong) IBOutlet UIView *menuView;
@property (nonatomic, strong) NSIndexPath *lastIndex;
@property (nonatomic, strong) NSIndexPath *currentIndex;

@property (weak, nonatomic) IBOutlet DropDownListView *dropDownDateList;


@property(nonatomic , strong)FactoryTaskDetailViewPopVC *m_factoryc;


@end

@implementation FactoryTaskViewController


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
    
    

    self.title = @"下厂任务";
    self.m_tableName = @"CommonLogicViewController";

    
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
    
    [self Add_RAC_Attention];
    
}

/**
 *  添加视图
 */
-(void)layoutMainCustomView
{
    [super layoutMainCustomView];
}
/**
 *  添加rac检测
 */
-(void)Add_RAC_Attention
{
//    NSDictionary *dict = @{@"userCode":@"1257"};
//    [[BaseNetWork getInstance] showDialog];
//    @weakify(self)
//    [[[[BaseNetWork getInstance] rac_postPath:@"loadcDuty.do" parameters:dict]map:^(id responseData)
//      {
//          NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
//          
//          return [dict valueForKeyPath:@"page.result"];
//      }]subscribeNext:^(NSArray *arr){
//          @strongify(self)
//          
//          
//          self.dataArray = arr;
//          [self.tableView reloadData];
//          [self.m_collectionView reloadData];
//          
//          
//      }error:^(NSError *error){
//          
//          
//      }];

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
    
    LoginedUser *usr = [LoginedUser sharedInstance];
    
    self.m_netFunctionStr = @"loadcDuty.do";
    //pxfs
    [self.m_netParamDict setObject:usr.usercode forKey:@"userCode"];
    [self.m_netParamDict setObject:[NSString stringWithFormat:@"%d",pageNo] forKey:@"pageNo"];
    [self.m_netParamDict setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"pageSize"];
    
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
//      [self.tableView reloadData];
}

/**
 *  请求成功后调用的方法
 *
 *  @param responseData
 */
-(void)failedGetDataWithResponseData:(id)responseData
{
    
}
#pragma mark - 代理协议方法*

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




///**
// *  删除
// *
// *  @param cell
// */
//- (void)deletePress:(MyPlanViewCell *)cell
//{
//    
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
//}



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


- (IBAction)optionsButtonPress:(id)sender{
    if (self.tableView.hidden) {
        self.m_collectionView.hidden = YES;
        self.tableView.hidden = NO;
        
    }
    else{
        self.m_collectionView.hidden = NO;
        self.tableView.hidden = YES;

    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithHexString:@"99958a"] title:@"检测"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithHexString:@"99958a"] title:@"驳回"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithHexString:@"99958a"] title:@"标记完成"];
    
    return rightUtilityButtons;
}


#pragma mark - Table view Delegate Method


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.m_DataSourceArr.count;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentifier = @"FactoryTaskCell";
//    FactoryTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//    cell.rightUtilityButtons = [self rightButtons];
//    [cell configureCellWithItem:self.m_DataSourceArr[indexPath.row] andIndex:indexPath.row + 1];
//    cell.delegate = self;
//    return cell;
//    
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
////    MyPlanPopVC *popVc = [self.storyboard instantiateViewControllerWithIdentifier:@"popVC"];;
////    popVc.m_popDelegate = self;
////    self.m_popVC = [[UIPopoverController alloc] initWithContentViewController:popVc];
////    self.m_popVC.delegate = self;
////    
////    //TODO:popoverLayoutMargins是指你的popover相对于整个window上下左右的margin
////    self.m_popVC.popoverLayoutMargins = UIEdgeInsetsMake(20,0,0,0);
////    
//////    self.m_popVC.popoverBackgroundViewClass = [backgroundV class];
////    // 设定展示区域的大小
////    // 从这个按钮点击的位置弹出，并且popVC的指向为这个按钮的中心。
////    //    曾有段时间纠结于这个popVC的指向， 真是麻烦得很
////    [self.m_popVC presentPopoverFromRect:CGRectMake(400, 400, 20, 20)
////                                  inView:self.view
////                permittedArrowDirections:0
////                                animated:YES];
//}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"More button was pressed");
            break;
        case 1:
        {
          
            break;
        }
        default:
            break;
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.m_DataSourceArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CompanyCollectionViewCell";
    CompanyCollectionViewCell *cell = (CompanyCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.m_delegate = self;
    [cell configureCellWithItem:self.m_DataSourceArr[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    if (indexPath.row  < self.m_DataSourceArr.count) {
        
        
        FactoryTaskDetailViewPopVC *popVc = (FactoryTaskDetailViewPopVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"FactoryTaskDetailViewPopVC"];
        
        popVc.m_popDelegate = self;
        popVc.m_showDict = self.m_DataSourceArr[indexPath.row];
        popVc.modalPresentationStyle = UIModalPresentationFormSheet;
        popVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//        @weakify(self)
        [self presentViewController:popVc animated:YES completion:^(void){

        }];
        
    }
    

}



#pragma mark - SwipeForOptionsCellDelegate Methods

- (void)cell:(CompanyCollectionViewCell *)cell didShowMenu:(BOOL)isShowingMenu
{
    if (isShowingMenu) {
        self.lastIndex = [self.m_collectionView indexPathForCell:cell];
    }
}

- (void)cellDidEndScrolling:(CompanyCollectionViewCell *)cell
{
    if (_lastIndex && _lastIndex.row != [self.m_collectionView indexPathForCell:cell].row) {
    cell = (CompanyCollectionViewCell *)[self.m_collectionView cellForItemAtIndexPath:_lastIndex];
    [cell hideUtilityButtonsAnimated:YES];
}
    
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

/**
 *  检测
 *
 *  @param cell
 */
- (void)cellDetectionPress:(CompanyCollectionViewCell *)cell
{
    
    
    NSIndexPath *indexPath = [self.m_collectionView indexPathForCell:cell];
    
    debug_int(indexPath.row);
    
    NSDictionary *dict = [self.m_DataSourceArr objectAtIndex:indexPath.row];
    debug_object(dict);
    
    
    NSDictionary *paraDic = @{@"usercode":[[[LoginedUser sharedInstance] usercode] GetNotNullStr],@"rwbh":[[self.m_DataSourceArr objectAtIndex:indexPath.row] objectForKey:@"RWBH"]};
    [[[[[BaseNetWork getInstance] rac_postPath:@"findWdsblb.do" parameters:paraDic]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary  *retDict) {
         if ([[retDict objectForKey:@"ret"] integerValue] == 1) {
             [Dialog toast:self withMessage:@"检测成功!"];
             [self loadNetData];
         }else{
              [Dialog toast:self withMessage:@"检测失败!"];
         }
     }error:^(NSError *error){
         
     }];

}

/**
 *  驳回
 *
 *  @param cell
 */
- (void)cellRejectedPress:(CompanyCollectionViewCell *)cell
{
    //TODO:要单独显示个驳回界面，然后再调用下面代码
    NSIndexPath *indexPath = [self.m_collectionView indexPathForCell:cell];
    
    NSDictionary *paraDic = @{@"usercode":[[[LoginedUser sharedInstance] usercode] GetNotNullStr],@"rwbh":[[self.m_DataSourceArr objectAtIndex:indexPath.row] objectForKey:@"RWBH"]};
    
    [[[[[BaseNetWork getInstance] rac_postPath:@"xcrwbh.do" parameters:paraDic]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary  *retDict) {
         if ([[retDict objectForKey:@"ret"] integerValue] == 1) {
             [Dialog toast:self withMessage:@"驳回成功!"];
             [self loadNetData];
         }else{
             [Dialog toast:self withMessage:@"驳回失败!"];

         }
     }error:^(NSError *error){
         
     }];

}

/**
 *  标记已完成
 *
 *  @param cell
 */
- (void)cellMarkCompletedPress:(CompanyCollectionViewCell *)cell
{
    //TODO:要单独显示个驳回界面，然后再调用下面代码
    NSIndexPath *indexPath = [self.m_collectionView indexPathForCell:cell];
    NSDictionary *paraDic = @{@"usercode":[[[LoginedUser sharedInstance] usercode] GetNotNullStr],@"rwbh":[[self.m_DataSourceArr objectAtIndex:indexPath.row] objectForKey:@"RWBH"]};
    [[[[[BaseNetWork getInstance] rac_postPath:@"bjwcbjry.do" parameters:paraDic]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary  *retDict) {
         if ([[retDict objectForKey:@"ret"] integerValue] == 1) {
              [Dialog toast:self withMessage:@"标记成功!"];
             
             [self loadNetData];
         }else{
               [Dialog toast:self withMessage:@"标记失败!"];
         }
     }error:^(NSError *error){
         
     }];
}


#pragma mark - UIPopoverControllerDelegate
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return NO;
}


@end
