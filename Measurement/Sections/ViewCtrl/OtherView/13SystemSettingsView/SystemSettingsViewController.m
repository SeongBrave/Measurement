//
//  SystemSettingsViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/23.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "SystemSettingsViewController.h"
#import"MMPlaceHolder.h"

@interface SystemSettingsViewController ()

@end

@implementation SystemSettingsViewController

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"系统设置";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.view  showPlaceHolder];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark - 自定义方法


- (IBAction)backToVCBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}
- (IBAction)exitBtnClick:(id)sender {
    
    
    
    
    
    [self dismissViewControllerAnimated:NO completion:^(void){
        
        
        NSNotification *notification = [NSNotification notificationWithName:@"TCDL" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
    
    
    
}
/**
 *  初始化一些数据 父类中调用了
 */
-(void)SetUpData
{
    [self layoutMainCustomView];
    
    
    [self Add_RAC_Attention];
    
    [self loadNetData];
}


/**
 *  添加视图
 */
-(void)layoutMainCustomView
{
    
    //    隐藏多余行的分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
//     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"popup-ret1urn"] landscapeImagePhone:[UIImage imageNamed:@"popup-retu1rn"] style:UIBarButtonItemStylePlain target:self action:@selector(backToVCBtnClick:)];
    
    
    UIButton *backButton = [UIButton buttonWithType:101];
    [backButton addTarget:self action:@selector(backToVCBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setFrame:CGRectMake(0, 0, 45, 15)];
//    [backButton setImage:[UIImage imageNamed:@"popup-return"] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;

    
    self.tableView.allowsSelection = NO;
}

/**
 *  添加rac检测
 */
-(void)Add_RAC_Attention
{
    
    
    
}

/**
 *  获取  的数据
 */
-(void)loadNetData
{
    
    
}

#pragma mark - 代理协议方法*
/**
 *  超级牛x的隐藏 键盘的方法
 *
 *  @param touches
 *  @param event
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


//#pragma mark Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//    return 0;
//}
///*
// -(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
// {
// 
// return nil;
// }
// 
// -(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
// {
// 
// return nil;
// }
// -(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
// {
// return 0;
// }
// 
// 
// - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
// 
// return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
// 
// }
// 
// 
// - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
// {
// return @"";
// 
// }*/
//#pragma mark - UITableView Delegate
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    
//    static NSString *cellIdentifier = @"certificate_TableViewCellTitle";
//    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//    return cell;
//    
//    
//    
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    
//    return 0;
//}
///*
// //设置cell的行高
// - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
// {
// return 70;
// }
// 
// //设置cell的隔行换色
// - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
// {
// if ([indexPath row] % 2 == 0) {
// cell.backgroundColor = [UIColor blueColor];
// } else {
// cell.backgroundColor = [UIColor greenColor];
// }
// }
// //滑动选择的行后删除
// - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
// {
// NSLog(@"执行删除操作");
// }
// 
// */


@end
