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
#import "DatePickerViewController.h"


@interface OptionMenuTableViewController ()<DidSelectedValueDelegate,DidSelectedValue_XCRY_Delegate,DidSelectedValue_XCKS_Delegate,DatePickerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *m_companyTF;

/**
 *  完成状态
 */
@property (weak, nonatomic) IBOutlet UILabel *m_finishStateLabel;

/**
 *  部门
 */
@property (weak, nonatomic) IBOutlet UILabel *m_factoryDepartmentLabel;

/**
 *  专员
 */
@property (weak, nonatomic) IBOutlet UILabel *m_factoryCommissionerLabel;


/**
 *  排序方式
 */
@property (weak, nonatomic) IBOutlet UILabel *m_sortingWayLabel;

/**
 *  排序字段
 */
@property (weak, nonatomic) IBOutlet UILabel *m_sortingFieldLabel;

@property (weak, nonatomic) IBOutlet CustomButton *fromDateBtn;
@property (weak, nonatomic) IBOutlet CustomButton *toDateBtn;
@property (weak, nonatomic) IBOutlet UIView *fromBorderView;
@property (weak, nonatomic) IBOutlet UIView *toBorderView;

@property(nonatomic , strong)DatePickerViewController *fromDatePickerVC;
@property(nonatomic , strong)DatePickerViewController *toDatePickerVC;

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
    
    [self updateTableViewWithData:_m_relValue];
    
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
            
            debug_object(self.m_relValue[@"rwwcqk"]);
            
            NSString *rwwcqkStr = self.m_relValue[@"rwwcqk"];
//            self.m_relValue
            ///如果没有值则说明显示全部
            selectedValueTVC.m_selectedItem = rwwcqkStr.length>0?rwwcqkStr:@"";
            selectedValueTVC.m_dataSourceArr =@[@{@"text":@"全部",@"data":@""},@{@"text":@"已完成",@"data":@"1"},@{@"text":@"未完成",@"data":@"0"}];
            //排序字段
        }else if (indexPath.section == 1 &&indexPath.row == 0) {
            //        ToSelectDetail_XCKS_VC
            /**
             *  显示的数据格式为:@{@"text":@"显示的数据",@"data":@"保存的值"}
             */
             NSString *pxzdStr = self.m_relValue[@"pxzd"];
            selectedValueTVC.m_dataSourceArr =@[@{@"text":@"创建时间",@"data":@"CJSJ"},@{@"text":@"下厂时间",@"data":@"XCSJQ"}];
             selectedValueTVC.m_selectValueTVCType = selectValueSortingfield;
            selectedValueTVC.m_selectedItem = pxzdStr.length>0?pxzdStr:@"CJSJ";
            
            //排序
        }else if (indexPath.section == 1 &&indexPath.row == 1) {
            
             NSString *pxfsStr = self.m_relValue[@"pxfs"];
            //getKsryjhn.do
            selectedValueTVC.m_dataSourceArr =@[@{@"text":@"升序",@"data":@"sx"},@{@"text":@"降序",@"data":@"jx"}];
            selectedValueTVC.m_selectedItem = pxfsStr.length>0?pxfsStr:@"jx";
            selectedValueTVC.m_selectValueTVCType = selectValueSortingWay;
            
        }
        selectedValueTVC.selectedDelegate = self;
        
        
    }else if ([segue.identifier isEqualToString:@"ToSelectDetail_XCKS_VC"] )
    {
        SelectValue_XCKS_TableViewController *selectedValueTVC = (SelectValue_XCKS_TableViewController*)[segue destinationViewController];
        
//         [self.m_relValue setObject:relDict[@"comcode"] forKey:@"xcksbh"];
        
        NSString *xcksbh = self.m_relValue[@"xcksbh"];
        selectedValueTVC.m_selectedItem = xcksbh.length>0?xcksbh:@"";
        selectedValueTVC.selectedDelegate = self;
        
        
        
    }else if ([segue.identifier isEqualToString:@"ToSelectDetail_XCRY_VC"] )
    {
        SelectValue_XCRY_TableViewController *selectedValueTVC = (SelectValue_XCRY_TableViewController*)[segue destinationViewController];
        selectedValueTVC.selectedDelegate = self;
        
        NSString *xcrybhStr = self.m_relValue[@"xcrybh"];
        if ([self.m_relValue[@"xcksbh"] isNotNull]) {
            selectedValueTVC.m_comCode = self.m_relValue[@"xcksbh"];
            selectedValueTVC.m_selectedItem = xcrybhStr;
        }else
        {
            LoginedUser *usr = [LoginedUser sharedInstance];
            selectedValueTVC.m_comCode = usr.comcode;
            
            selectedValueTVC.m_selectedItem = usr.comcode;
        }
      
//        self.m_relValue
        //xcksbh
        
    }else if ([segue.identifier isEqualToString:@"FromDatePicker"] )
    {
        DatePickerViewController *pickerVC = (DatePickerViewController*)[segue destinationViewController];
        /**
         *  必须给了属性然后再viewwillappear中设置给datepicker才行，否则设置不成功
         */
        
        pickerVC.m_date = self.fromDateBtn.m_info[@"data"];
        pickerVC.m_clickBtn = self.fromDateBtn;
        
        pickerVC.dateDelegate = self;
         self.fromDatePickerVC = pickerVC;
        
    }else if ([segue.identifier isEqualToString:@"ToDatePicker"] )
    {
        DatePickerViewController *pickerVC = (DatePickerViewController*)[segue destinationViewController];
         pickerVC.m_clickBtn = self.toDateBtn;
        pickerVC.dateDelegate = self;
        /**
         *  必须给了属性然后再viewwillappear中设置给datepicker才行，否则设置不成功
         */
        pickerVC.m_date = self.toDateBtn.m_info[@"data"];
        self.toDatePickerVC = pickerVC;
        
    }
    
    

}

#pragma mark - 自定义方法


-(void)updateTableViewWithData:(NSDictionary *) dict
{
    
    self.m_companyTF.text = [dict GetLabelWithKey:@"wtdwmc"];
    
    NSString *rwwcqkStr = [dict GetLabelWithKey:@"rwwcqk"];
    
    if (rwwcqkStr.length >0) {
        int code = [rwwcqkStr intValue];
        
        switch (code) {
            case 0:
            {
                self.m_finishStateLabel.text = @"未完成";
            }
                break;
            case 1:
            {
                self.m_finishStateLabel.text = @"已完成";
            }
                break;
            default:
                break;
        }
        
    }else
    {
        self.m_finishStateLabel.text = @"全部";
    }

    
    NSString *pxfsStr = [dict GetLabelWithKey:@"pxfs"];
    
    if (pxfsStr.length >0) {
        int code = [pxfsStr intValue];
        
        switch (code) {
            case 0:
            {
                self.m_sortingWayLabel.text = @"降序";
            }
                break;
            case 1:
            {
                self.m_sortingWayLabel.text = @"升序";
            }
                break;
            default:
                break;
        }
        
    }else
    {
        self.m_sortingWayLabel.text = @"降序";
    }
    
    
    NSString *pxzdStr = [dict GetLabelWithKey:@"pxzd"];
    
    if (pxzdStr.length >0) {
        int code = [pxzdStr intValue];
        
        switch (code) {
            case 0:
            {
                self.m_sortingFieldLabel.text = @"创建时间";
            }
                break;
            case 1:
            {
                self.m_sortingFieldLabel.text = @"下厂时间";
            }
                break;
            default:
                break;
        }
        
    }else
    {
        self.m_sortingFieldLabel.text = @"创建时间";
    }
    
    
    
    NSString *xcksbhStr = [dict GetLabelWithKey:@"xcksbh"];
    
    if (xcksbhStr.length >0) {
       
        [self search_xcks_Byxcksbh:xcksbhStr];
        
    }else
    {
        self.m_factoryDepartmentLabel.text = @"全部";
    }
    
    
    
    NSString *xcrybhStr = [dict GetLabelWithKey:@"xcrybh"];
    
    if (xcrybhStr.length >0) {
        
        [self search_xcry_Byxcrybh:xcrybhStr andxcksbh:xcksbhStr];
        
    }else
    {
        self.m_factoryCommissionerLabel.text = @"全部";
    }
    
    
    
    // 将NSDate格式装换成NSString类型
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    // 设置日历显示格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    
    
    
    NSString *xcsjqStr = dict[@"xcsjq"];
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromdate=[format dateFromString:xcsjqStr];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    
    
    NSString *xcsjzStr = dict[@"xcsjz"];
    NSDate *todate=[format dateFromString:xcsjzStr];
    NSInteger tointerval = [fromzone secondsFromGMTForDate: todate];
    NSDate *toDate = [fromdate  dateByAddingTimeInterval: tointerval];
    
    
    if (xcsjqStr.length>0) {
        
        [self.fromDateBtn setTitle:xcsjqStr forState:UIControlStateNormal];
        
        [self.fromDateBtn.m_info setObject:fromDate forKey:@"data"];
        
        
    }else
    {
        // 把日历时间传给字符串
        
        NSString *strDate = [dateFormatter stringFromDate:[NSDate new]];
        [self.fromDateBtn setTitle:strDate forState:UIControlStateNormal];
        [self.fromDateBtn.m_info setObject:[[NSDate new] sameTimeOfDate] forKey:@"data"];
    }
    
    
    if (xcsjzStr.length>0) {
        
        [self.toDateBtn setTitle:xcsjzStr forState:UIControlStateNormal];
        [self.toDateBtn.m_info setObject:toDate forKey:@"data"];
    }else
    {
        // 把日历时间传给字符串
        
        NSString *strDate = [dateFormatter stringFromDate:[NSDate new]];
        [self.toDateBtn setTitle:strDate forState:UIControlStateNormal];
        [self.toDateBtn.m_info setObject:[NSDate new] forKey:@"data"];
        
    }
    
                                    
                                    
}

-(void)search_xcks_Byxcksbh:(NSString *) xcksbh
{
    /**
     *  设置加载时显示提示
     */
    [[BaseNetWork getInstance] hideDialog];
    @weakify(self)
    [[[[BaseNetWork getInstance] rac_postPath:@"getKs.do" parameters:nil]map:^(id responseData)
      {
          NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
          
          return [dict valueForKeyPath:@"ks"];
          
      }]subscribeNext:^(NSArray *arr)
     {
         @strongify(self)
         for(NSDictionary *dict in arr)
         {
             if([dict[@"comcode"] isEqualToString:xcksbh])
             {
                 
                 self.m_factoryDepartmentLabel.text = dict[@"comcname"];
             }
         }

         
     }error:^(NSError *error){
         
         //          [self.m_collectionView reloadData];
         
         
     }];
}


-(void)search_xcry_Byxcrybh:(NSString *) xcrybh andxcksbh:(NSString *) xcksbh
{
    /**
     *  设置加载时显示提示
     */
    [[BaseNetWork getInstance] hideDialog];
    @weakify(self)
    [[[[BaseNetWork getInstance] rac_postPath:@"getKsry.do" parameters:@{@"comCode":xcksbh}]map:^(id responseData)
      {
          NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
          
          return [dict valueForKeyPath:@"ksry"];
          
      }]subscribeNext:^(NSArray *arr)
     {
         @strongify(self)
         for(NSDictionary *dict in arr)
         {
             if([dict[@"comcode"] isEqualToString:xcrybh])
             {

                 self.m_factoryCommissionerLabel.text = dict[@"comcname"];
             }
         }
         
         
     }error:^(NSError *error){
         
         //          [self.m_collectionView reloadData];
         
         
     }];
}
//TODO: 添加视图
-(void)layoutMainCustomView
{
//    m_companyTF
    
    
    self.fromBorderView.layer.borderWidth = 2.0;
    self.fromBorderView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
    
     self.toBorderView.layer.borderWidth = 2.0;
    self.toBorderView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;

    
    
//    // 将NSDate格式装换成NSString类型
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    // 设置日历显示格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    
//  
//    
//    
//    
//    NSString *xcsjqStr = self.m_relValue[@"xcsjq"];
//    
//    NSDateFormatter *format=[[NSDateFormatter alloc] init];
//    [format setDateFormat:@"yyyy-MM-dd"];
//    NSDate *fromdate=[format dateFromString:xcsjqStr];
//    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
//    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
//    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
//    
//
//    NSString *xcsjzStr = self.m_relValue[@"xcsjz"];
//     NSDate *todate=[format dateFromString:xcsjzStr];
//     NSInteger tointerval = [fromzone secondsFromGMTForDate: todate];
//     NSDate *toDate = [fromdate  dateByAddingTimeInterval: tointerval];
//
//    
//    if (xcsjqStr.length>0) {
//        
//        [self.fromDateBtn setTitle:xcsjqStr forState:UIControlStateNormal];
//        
//        [self.fromDateBtn.m_info setObject:fromDate forKey:@"data"];
//
//        
//    }else
//    {
//        // 把日历时间传给字符串
//        
//        NSString *strDate = [dateFormatter stringFromDate:[NSDate new]];
//        [self.fromDateBtn setTitle:strDate forState:UIControlStateNormal];
//        [self.fromDateBtn.m_info setObject:[[NSDate new] sameTimeOfDate] forKey:@"data"];
//    }
//    
//    
//    if (xcsjzStr.length>0) {
//        
//        [self.toDateBtn setTitle:xcsjzStr forState:UIControlStateNormal];
//        [self.toDateBtn.m_info setObject:toDate forKey:@"data"];
//    }else
//    {
//        // 把日历时间传给字符串
//        
//        NSString *strDate = [dateFormatter stringFromDate:[NSDate new]];
//        [self.toDateBtn setTitle:strDate forState:UIControlStateNormal];
//        [self.toDateBtn.m_info setObject:[NSDate new] forKey:@"data"];
//        
//    }
    
}

-(NSMutableDictionary *)m_relValue
{
    if (_m_relValue == nil) {
        self.m_relValue = [[NSMutableDictionary alloc]init];
    }
    return _m_relValue;
}

-(void)SetUpData
{
    
    self.title = @"选项";
    [self layoutMainCustomView];
    [self AddNavgationBarItem];
    
    [self Add_RAC_Attention];
    
}

-(void)Add_RAC_Attention
{

    @weakify(self)
    [[self.m_companyTF.rac_textSignal
      throttle:0.5] subscribeNext:^(NSString *wtdwmcStr)
     {
        @strongify(self)
        
         [self.m_relValue setObject:wtdwmcStr forKey:@"wtdwmc"];

     }];
    
}

/**
 *  选则是卡片模式还是时间轴模式
 *
 *  @param sender 
 */
- (IBAction)segonValueChanged:(id)sender {
    
    
    
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


/**
 *  查询
 *
 *  @param sender
 */
- (IBAction)queryClick:(id)sender {
    
    

    if ([self.m_optionMenuDelegate respondsToSelector:@selector(OptionMenu:DidsaveValue:)]) {
        
        
        [self.m_optionMenuDelegate OptionMenu:self DidsaveValue:self.m_relValue];
    }
    
//    
//    @weakify(self)
//    [self dismissViewControllerAnimated:YES completion:^(void){
//        
//        @strongify(self)
//        if ([self.m_optionMenuDelegate respondsToSelector:@selector(OptionMenu:DidsaveValue:)]) {
//            
//            
//            [self.m_optionMenuDelegate OptionMenu:self DidsaveValue:self.m_relValue];
//        }
//
//        
//    }];
    
    
    
}
/**
 *  重置
 *
 *  @param sender
 */
- (IBAction)resetClick:(id)sender {
    
    
  
    for(NSString *key in [self.m_relValue allKeys])
    {
        [self.m_relValue setObject:@"" forKey:key];
    }
    

    [self updateTableViewWithData:_m_relValue];
    
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
            [self.m_relValue setObject:relDict[@"data"] forKey:@"pxzd"];
        }
            break;
        case selectValueSortingWay:
        {
            self.m_sortingWayLabel.text = [NSString stringWithFormat:@"%@",relDict[@"text"]];
            [self.m_relValue setObject:relDict[@"data"] forKey:@"pxfs"];
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
#pragma mark -DatePickerDelegate
-(void)DatePickerVC:(DatePickerViewController*)datePickerVC DidseletedDate:(NSDate*) date
{
    // 将NSDate格式装换成NSString类型
    
    NSDateFormatter *formatterShowBtn = [[NSDateFormatter alloc]init];
    // 设置日历显示格式
    [formatterShowBtn setDateFormat:@"yyyy-MM-dd"];
    // 把日历时间传给字符串
    NSString *strDate = [formatterShowBtn stringFromDate:date];
    
    
    [datePickerVC.m_clickBtn.m_info setObject:date forKey:@"data"];

    [datePickerVC.m_clickBtn setTitle:strDate forState:UIControlStateNormal];
    
    if (datePickerVC == _toDatePickerVC) {
        
        [self.m_relValue setObject:strDate forKey:@"xcsjz"];
        
    }else if (datePickerVC == _fromDatePickerVC)
    {
        [self.m_relValue setObject:strDate forKey:@"xcsjq"];
    }
    
}


@end
