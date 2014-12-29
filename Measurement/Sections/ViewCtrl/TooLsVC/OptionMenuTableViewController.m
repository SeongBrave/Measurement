//
//  OptionMenuTableViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/28.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "OptionMenuTableViewController.h"
#import "SelectValueTableViewController.h"
#import "SelectValue_XCRY_TableViewController.h"
#import "SelectValue_XCKS_TableViewController.h"
@interface OptionMenuTableViewController ()<DidSelectedValueDelegate,DidSelectedValue_XCRY_Delegate,DidSelectedValue_XCKS_Delegate>

@property (weak, nonatomic) IBOutlet UITextField *m_companyTF;

@property (weak, nonatomic) IBOutlet UILabel *m_finishStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_factoryDepartmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_factoryCommissionerLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_sortingWayLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_sortingFieldLabel;

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
   
    
    NSIndexPath *indexPath = (NSIndexPath*)sender;
    if ([segue.identifier isEqualToString:@"ToSelectDetailVC"] )
    {
        SelectValueTableViewController *selectedValueTVC = (SelectValueTableViewController*)[segue destinationViewController]
        ;
        if (indexPath.section == 0 &&indexPath.row == 0) {
            //        ToSelectDetail_XCKS_VC
            /**
             *  显示的数据格式为:@{@"text":@"显示的数据",@"data":@"保存的值"}
             */
            selectedValueTVC.m_selectValueTVCType = selectValueFinishState;
            selectedValueTVC.m_dataSourceArr =@[@{@"text":@"全部",@"data":@""},@{@"text":@"已完成",@"data":@"1"},@{@"text":@"未完成",@"data":@"0"}];
            //排序字段
        }else if (indexPath.section == 1 &&indexPath.row == 0) {
            //        ToSelectDetail_XCKS_VC
            /**
             *  显示的数据格式为:@{@"text":@"显示的数据",@"data":@"保存的值"}
             */
            selectedValueTVC.m_dataSourceArr =@[@{@"text":@"全部",@"data":@""},@{@"text":@"已完成",@"data":@""},@{@"text":@"未完成",@"data":@""}];
             selectedValueTVC.m_selectValueTVCType = selectValueSortingfield;
            
            
            //排序
        }else if (indexPath.section == 1 &&indexPath.row == 1) {
            
            //getKsryjhn.do
            selectedValueTVC.m_dataSourceArr =@[@{@"text":@"升序",@"data":@"sx"},@{@"text":@"降序",@"data":@"jx"}];
            selectedValueTVC.m_selectValueTVCType = selectValueSortingWay;
            
        }
        selectedValueTVC.selectedDelegate = self;
        
        
    }else if ([segue.identifier isEqualToString:@"ToSelectDetail_XCKS_VC"] )
    {
        SelectValue_XCKS_TableViewController *selectedValueTVC = (SelectValue_XCKS_TableViewController*)[segue destinationViewController];
        
        selectedValueTVC.selectedDelegate = self;
        
        
        
    }else if ([segue.identifier isEqualToString:@"ToSelectDetail_XCRY_VC"] )
    {
        SelectValue_XCKS_TableViewController *selectedValueTVC = (SelectValue_XCKS_TableViewController*)[segue destinationViewController];
        selectedValueTVC.selectedDelegate = self;
        
    }

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
    self.m_relValue = [NSMutableDictionary dictionary];
    
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
    
//   dismissPopoverAnimated
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
    
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

    
    if ((indexPath.section == 0 &&indexPath.row == 0)||(indexPath.section == 1 &&(indexPath.row == 0||indexPath.row == 1))) {
        
        [self performSegueWithIdentifier:@"ToSelectDetailVC" sender:indexPath];

        //下厂科室
    }else if (indexPath.section == 0 &&indexPath.row == 1) {
        //        ToSelectDetail_XCKS_VC
       [self performSegueWithIdentifier:@"ToSelectDetail_XCKS_VC" sender:indexPath];
 
        
        //下厂检定员
    }else if (indexPath.section == 0 &&indexPath.row == 2) {
        
        //  ToSelectDetail_XCKS_VC
        [self performSegueWithIdentifier:@"ToSelectDetail_XCRY_VC" sender:indexPath];

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
    
    debug_object(self.m_relValue);
    
    
}

/**
 *  查询
 *
 *  @param sender
 */
- (IBAction)queryClick:(id)sender {
    
    if ([self.m_optionMenuDelegate respondsToSelector:@selector(OptionMenu:DidsaveValue:)]) {
        
        
        [self.m_optionMenuDelegate OptionMenu:self DidsaveValue:self.m_relValue];
    }
    
    @weakify(self)
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        @strongify(self)
        if ([self.m_optionMenuDelegate respondsToSelector:@selector(OptionMenu:DidsaveValue:)]) {
            
            
            [self.m_optionMenuDelegate OptionMenu:self DidsaveValue:self.m_relValue];
        }

        
    }];
    
    
    
}
/**
 *  重置
 *
 *  @param sender
 */
- (IBAction)resetClick:(id)sender {
}

#pragma mark - DidSelectedValueDelegate
-(void)SelectValueTVC:(SelectValueTableViewController*) selectValueTVC DidSelectedValue:(id)selectedValue
{
      NSDictionary *relDict = (NSDictionary *)selectedValue;
    switch (selectValueTVC.m_selectValueTVCType) {
        case selectValueFinishState:
        {
            self.m_finishStateLabel.text = [NSString stringWithFormat:@"%@",relDict[@"text"]];
            [self.m_relValue setObject:relDict[@"data"] forKey:@"rwwcqk"];
            
            //rwwcqk
        }
            break;
        case selectValueSortingfield:
        {
            self.m_sortingFieldLabel.text = [NSString stringWithFormat:@"%@",relDict[@"text"]];
        }
            break;
        case selectValueSortingWay:
        {
            self.m_sortingWayLabel.text = [NSString stringWithFormat:@"%@",relDict[@"text"]];
            [self.m_relValue setObject:relDict[@"data"] forKey:@"rwwcqk"];
        }
            break;
            
        default:
            break;
    }


}

#pragma mark - DidSelectedValue_XCKS_Delegate
-(void)SelectValue_XCKS_TVC:(SelectValue_XCKS_TableViewController*) selectValueTVC DidSelectedValue:(id)selectedValue
{
    
    
    
    NSDictionary *relDict = (NSDictionary *)selectedValue;
    
    self.m_factoryDepartmentLabel.text = [NSString stringWithFormat:@"%@",relDict[@"comcname"]];
    
    [self.m_relValue setObject:relDict[@"comcode"] forKey:@"xcksbh"];
    
    
}

#pragma mark - DidSelectedValue_XCKS_Delegate  //检定员
-(void)SelectValue_XCRY_TVC:(SelectValue_XCRY_TableViewController*) selectValueTVC DidSelectedValue:(id)selectedValue
{
    NSDictionary *relDict = (NSDictionary *)selectedValue;
    
    self.m_factoryCommissionerLabel.text = [NSString stringWithFormat:@"%@",relDict[@"username"]];
    
    [self.m_relValue setObject:relDict[@"usercode"] forKey:@"xcrybh"];
}


@end
