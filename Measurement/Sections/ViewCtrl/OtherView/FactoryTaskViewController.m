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


@interface FactoryTaskViewController ()<UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate, SwipeCellDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UIView *menuView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSIndexPath *lastIndex;
@property (nonatomic, strong) NSIndexPath *currentIndex;


@end

@implementation FactoryTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSDictionary *dict = @{@"userCode":@"1257",@"ID":@"0EFCC23105C84A85AC97588889386397"};
    [[BaseNetWork getInstance] showDialog];
    @weakify(self)
    [[[[BaseNetWork getInstance] rac_getPath:@"http://192.168.10.169:8080/mbs/convey/findXcrw.do" parameters:dict]map:^(id responseData)
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
