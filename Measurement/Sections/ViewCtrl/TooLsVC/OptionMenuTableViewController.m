//
//  OptionMenuTableViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/28.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "OptionMenuTableViewController.h"

@interface OptionMenuTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *m_companyTF;

@end

@implementation OptionMenuTableViewController

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
    
}

-(void)SetUpData
{
    
    self.title = @"选项";
    [self layoutMainCustomView];
    [self AddNavgationBarItem];
    
}
-(void)AddNavgationBarItem
{
    

    
    
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
 *  筛选查询
 *
 *  @param sender
 */
- (IBAction)filtrateClick:(id)sender {
    
    self.m_companyTF.text = @"呵呵";
}

#pragma mark - 代理协议方法*

#pragma mark Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 27;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 1;
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 0;
//}
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
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//    
//      cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
//    
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ((indexPath.section == 0&&(indexPath.row ==3 ||indexPath.row ==3 ))||(indexPath.section == 1&&indexPath.row ==2)) {
        
    }else
    {
        [self performSegueWithIdentifier:@"ToSelectDetailVC" sender:indexPath];
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


- (IBAction)showDateDialog:(id)sender {
    
    
}



@end
