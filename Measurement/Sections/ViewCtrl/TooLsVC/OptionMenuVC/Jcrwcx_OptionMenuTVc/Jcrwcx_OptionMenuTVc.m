//
//  Jcrwcx_OptionMenuTVc.m
//  Measurement
//
//  Created by DTSoft on 15/4/9.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "Jcrwcx_OptionMenuTVc.h"
#import "SelectValueTableViewController.h"
#import "DatePickerViewController.h"

@interface Jcrwcx_OptionMenuTVc ()<DidSelectedValueDelegate,DatePickerDelegate>

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


@property (weak, nonatomic) IBOutlet UITextField *m_yqmc_TF;
@property (weak, nonatomic) IBOutlet UITextField *m_txm_TF;

@property (weak, nonatomic) IBOutlet UITextField *m_zsbh_TF;

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
@implementation Jcrwcx_OptionMenuTVc
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
         if (indexPath.section == 1 &&indexPath.row == 0) {
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
        
        
    }else if ([segue.identifier isEqualToString:@"FromDatePicker"] )
    {
        DatePickerViewController *pickerVC = (DatePickerViewController*)[segue destinationViewController];
        /**
         *  必须给了属性然后再viewwillappear中设置给datepicker才行，否则设置不成功
         */
        
        pickerVC.m_date = self.fromDateBtn.m_info[@"data"];
        pickerVC.m_clickBtn = self.fromDateBtn;
        pickerVC.datePickerMode = UIDatePickerModeDate;
        pickerVC.dateDelegate = self;
        self.fromDatePickerVC = pickerVC;
        
    }else if ([segue.identifier isEqualToString:@"ToDatePicker"] )
    {
        DatePickerViewController *pickerVC = (DatePickerViewController*)[segue destinationViewController];
        pickerVC.m_clickBtn = self.toDateBtn;
        pickerVC.datePickerMode = UIDatePickerModeDate;
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
    
    self.m_yqmc_TF.text = [dict GetLabelWithKey:@"yqmc"];
    
    self.m_txm_TF.text = [dict GetLabelWithKey:@"txm"];
    
    self.m_zsbh_TF.text = [dict GetLabelWithKey:@"zsbh"];
    
    
    
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
    

    
    
    // 将NSDate格式装换成NSString类型
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    // 设置日历显示格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    
    
    
    NSString *xcsjqStr = dict[@"cjsjStart"];
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromdate=[format dateFromString:xcsjqStr];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    
    
    NSString *xcsjzStr = dict[@"cjsjEnd"];
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

//TODO: 添加视图
-(void)layoutMainCustomView
{
    //    m_companyTF
    
    
    self.fromBorderView.layer.borderWidth = 2.0;
    self.fromBorderView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
    
    self.toBorderView.layer.borderWidth = 2.0;
    self.toBorderView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
    

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
    
    [[self.m_yqmc_TF.rac_textSignal
      throttle:0.5] subscribeNext:^(NSString *wtdwmcStr)
     {
         @strongify(self)
         
         [self.m_relValue setObject:wtdwmcStr forKey:@"yqmc"];
         
     }];
    
    [[self.m_txm_TF.rac_textSignal
      throttle:0.5] subscribeNext:^(NSString *wtdwmcStr)
     {
         @strongify(self)
         
         [self.m_relValue setObject:wtdwmcStr forKey:@"txm"];
         
     }];
    
    [[self.m_zsbh_TF.rac_textSignal
      throttle:0.5] subscribeNext:^(NSString *wtdwmcStr)
     {
         @strongify(self)
         
         [self.m_relValue setObject:wtdwmcStr forKey:@"zsbh"];
         
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
    
    
    if (indexPath.section == 1 &&(indexPath.row == 0||indexPath.row == 1)) {
        
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


/**
 *  查询
 *
 *  @param sender
 */
- (IBAction)queryClick:(id)sender {
    
    for(NSString *key in self.m_relValue.allKeys)
    {
        if ([self.m_relValue[key] isEqualToString:@""] || [self.m_relValue[key] length] == 0 ) {
            [self.m_relValue removeObjectForKey:key];
        }
    }
    
    if ([self.m_optionMenuDelegate respondsToSelector:@selector(OptionMenuTVc:DidsaveValue:)]) {
        
        [self.m_optionMenuDelegate OptionMenuTVc:self DidsaveValue:self.m_relValue];
    }
    
    
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
        
        [self.m_relValue setObject:strDate forKey:@"cjsjStart"];
        
    }else if (datePickerVC == _fromDatePickerVC)
    {
        [self.m_relValue setObject:strDate forKey:@"cjsjEnd"];
    }
    
}


@end















