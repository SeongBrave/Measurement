//
//  SelectValue_XCRY_TableViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/29.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "SelectValue_XCRY_TableViewController.h"
#import "NSDictionary+LinqExtensions.h"
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>
@interface SelectValue_XCRY_TableViewController ()
{
    NSIndexPath  *lastIndexPath;
}

@end

@implementation SelectValue_XCRY_TableViewController

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

    [self loadNetData];
   
    
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
    
}

-(void)SetUpData
{
    [self layoutMainCustomView];
    [self AddNavgationBarItem];
    //    隐藏多余行的分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    lastIndexPath = nil;
        self.tableView.tintColor = UIColorFromRGB(9, 187, 143);
    //     [self setExtraCellLineHidden:self.tableView];
}

-(void)loadNetData
{
    
    /**
     *  设置加载时显示提示
     */
    [[BaseNetWork getInstance] showDialog];
    @weakify(self)
    [[[[BaseNetWork getInstance] rac_postPath:@"getKsry.do" parameters:@{@"comCode":self.m_comCode}]map:^(id responseData)
      {
          NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
          
          return [dict valueForKeyPath:@"ksry"];
          
      }]subscribeNext:^(NSArray *arr)
     {
         
         //comcname
         @strongify(self)
         self.m_dataSourceArr = arr;
         
         [self.tableView reloadData];
     }error:^(NSError *error){
         
         //          [self.m_collectionView reloadData];
         
         
     }];
    
    
}

-(void)AddNavgationBarItem
{
    
    //    UIBarButtonItem *leftBtn =[[UIBarButtonItem alloc] initWithTitle:@"群组" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBtnClick:)];
    //    [leftBtn setImage:[UIImage imageNamed:@"nav_Call"]];
    //    self.navigationItem.leftBarButtonItem=leftBtn;
    
    //    UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc] initWithTitle:@"群组" style:UIBarButtonItemStyleBordered target:self action:@selector(rightBtnClick:)];
    //    [rightBtn setImage:[UIImage imageNamed:@"nav_MultipartyCalls"]];
    //    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
}
-(void)leftBtnClick:(id)sender
{
    [Dialog toast:@"left"];
}

-(void)rightBtnClick:(id)sender
{
    [Dialog toast:@"right"];
}

/**
 *  隐藏多余行的分割线
 *
 *  @param tableView
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    
    
}

#pragma mark - 代理协议方法*

#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_dataSourceArr.count;
}
/*
 -(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 
 return nil;
 }
 
 -(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
 {
 
 return nil;
 }
 -(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
 {
 return 0;
 }
 */

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    /selectValueTableViewCell
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectValue_XCRY_TableViewCell" forIndexPath:indexPath];

    cell.textLabel.font  = [UIFont systemFontOfSize:18];
    cell.textLabel.textColor = UIColorFromRGB(76, 93, 111);
    
    cell.textLabel.text =self.m_dataSourceArr[indexPath.row][@"username"];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (lastIndexPath == nil) {
        
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:
                                    indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:
                                    lastIndexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        
        lastIndexPath = indexPath;
        
    }else
    {
        
        int newRow = [indexPath row];
        int oldRow = [lastIndexPath row];
        
        
        if (newRow != oldRow)
        {
            UITableViewCell *newCell = [tableView cellForRowAtIndexPath:
                                        indexPath];
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:
                                        lastIndexPath];
            oldCell.accessoryType = UITableViewCellAccessoryNone;
            
            lastIndexPath = indexPath;
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.selectedDelegate respondsToSelector:@selector(SelectValue_XCRY_TVC:DidSelectedValue:)]) {
        [self.selectedDelegate SelectValue_XCRY_TVC:self DidSelectedValue:self.m_dataSourceArr[indexPath.row]];
    }
}
/*
 //设置cell的行高
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return 70;
 }
 
 //设置cell的隔行换色
 - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if ([indexPath row] % 2 == 0) {
 cell.backgroundColor = [UIColor blueColor];
 } else {
 cell.backgroundColor = [UIColor greenColor];
 }
 }
 //滑动选择的行后删除
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 NSLog(@"执行删除操作");
 }
 
 */

@end
