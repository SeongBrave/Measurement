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


@interface FactoryTaskViewController ()<UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate, SwipeCellDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UIPopoverControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UIView *menuView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSIndexPath *lastIndex;
@property (nonatomic, strong) NSIndexPath *currentIndex;
@property(nonatomic , strong)UIPopoverController *m_popVC;


@end

@implementation FactoryTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSDictionary *dict = @{@"userCode":@"1257",@"ID":@"0EFCC23105C84A85AC97588889386397"};
    [[BaseNetWork getInstance] showDialog];
    @weakify(self)
    [[[[BaseNetWork getInstance] rac_postPath:@"http://192.168.10.169:8080/mbs/convey/findXcrw.do" parameters:dict]map:^(id responseData)
      {
          NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
          
          return [dict valueForKeyPath:@"page.result"];
      }]subscribeNext:^(NSArray *arr){
          @strongify(self)
          
          
          self.dataArray = arr;
          [self.tableView reloadData];
          [self.collectionView reloadData];
          
          
      }error:^(NSError *error){
//          @strongify(self)
////          NSArray *arr = [self.m_store getObjectById:@"page.result" fromTable:self.m_tableName];
////          self.m_DataSourceArr = arr;
////          [_header endRefreshing];
////          [_footer endRefreshing];
////          
////          [self failedGetDataWithResponseData:arr];
//          //          [self.m_collectionView reloadData];
          
          
      }];
}

- (IBAction)optionsButtonPress:(id)sender{
    if (self.tableView.hidden) {
        self.collectionView.hidden = YES;
        self.tableView.hidden = NO;
        self.menuView.hidden = NO;
    }
    else{
        self.collectionView.hidden = NO;
        self.tableView.hidden = YES;
        self.menuView.hidden = YES;
    }
}

//-(void)SetUpData
//{
//    [super SetUpData];
//    self.title = @"下厂任务";
//    self.view.backgroundColor = [UIColor blueColor];
//    
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"FactoryTaskCell";
    FactoryTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.rightUtilityButtons = [self rightButtons];
    [cell configureCellWithItem:_dataArray[indexPath.row] andIndex:indexPath.row + 1];
    cell.delegate = self;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    MyPlanPopVC *popVc = [self.storyboard instantiateViewControllerWithIdentifier:@"popVC"];;
//    popVc.m_popDelegate = self;
//    self.m_popVC = [[UIPopoverController alloc] initWithContentViewController:popVc];
//    self.m_popVC.delegate = self;
//    
//    //TODO:popoverLayoutMargins是指你的popover相对于整个window上下左右的margin
//    self.m_popVC.popoverLayoutMargins = UIEdgeInsetsMake(20,0,0,0);
//    
////    self.m_popVC.popoverBackgroundViewClass = [backgroundV class];
//    // 设定展示区域的大小
//    // 从这个按钮点击的位置弹出，并且popVC的指向为这个按钮的中心。
//    //    曾有段时间纠结于这个popVC的指向， 真是麻烦得很
//    [self.m_popVC presentPopoverFromRect:CGRectMake(400, 400, 20, 20)
//                                  inView:self.view
//                permittedArrowDirections:0
//                                animated:YES];
}

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
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"FactoryTaskCell";
    CompanyCollectionViewCell *cell = (CompanyCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    [cell configureCellWithItem:_dataArray[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{



}

#pragma mark - SwipeForOptionsCellDelegate Methods

- (void)cell:(CompanyCollectionViewCell *)cell didShowMenu:(BOOL)isShowingMenu {
    if (isShowingMenu) {
        self.lastIndex = [self.collectionView indexPathForCell:cell];
    }
}

- (void)cellDidEndScrolling:(CompanyCollectionViewCell *)cell{
    if (_lastIndex && _lastIndex.row != [self.collectionView indexPathForCell:cell].row) {
        cell = (CompanyCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:_lastIndex];
        [cell hideUtilityButtonsAnimated:YES];
    }
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
