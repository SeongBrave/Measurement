//
//  AddPlanDetailsPopVC.m
//  Measurement
//
//  Created by DTSoft on 15/1/4.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "AddPlanDetailsPopVC.h"
#import "AutoCompleteTextFieldDataSource.h"
#import "AutoCompleteTextFieldDelegate.h"
#import "AutoCompleteTextField.h"
#import "autoTableViewData.h"
#import "DatePickerViewController.h"
#import "CustomButton.h"
#import "DropDownTextField.h"

@interface AddPlanDetailsPopVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,AutoCompleteTextFieldDataSource,AutoCompleteTextFieldDelegate,DatePickerDelegate,DropDownTextFieldDataSource,DropDownTextFieldDelegate,DropDownTextFieldShowCellTextLabel>


@property(nonatomic , strong)NSArray *m_autoTFArr;


/**
 *  科室负责人
 */
@property (weak, nonatomic) IBOutlet UITableView *headTableView;
/**
 *  科室人员
 */
@property (weak, nonatomic) IBOutlet UITableView *mansTableView;


/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet UITextView *noteTF;
/**
 *  单位名称
 */
@property (weak, nonatomic) IBOutlet AutoCompleteTextField *nameOFEntityTF;

/**
 *  单位地址
 */
@property (weak, nonatomic) IBOutlet UITextField *addrOFEntity;
/**
 *  联系人
 */
@property (weak, nonatomic) IBOutlet UITextField *contactTF;

/**
 *  联系电话
 */
@property (weak, nonatomic) IBOutlet UITextField *ContactTELTF;

/**
 *  所在区
 */
@property (weak, nonatomic) IBOutlet DropDownTextField *districtTF;

/**
 *  行业类别
 */
@property (weak, nonatomic) IBOutlet DropDownTextField *IndustryCategoriesTF;

/**
 *  邮编
 */
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTF;

/**
 *  业务负责科室
 */
@property (weak, nonatomic) IBOutlet DropDownTextField *responsibleDepTF;

/**
 *  业务负责人
 */
@property (weak, nonatomic) IBOutlet DropDownTextField *headOFTF;

/**
 *  取证日期
 */
@property (weak, nonatomic) IBOutlet UITextField *evidenceDateTF;

/**
 *  特殊要求
 */
@property (weak, nonatomic) IBOutlet UITextField *specialReqTF;
@property (weak, nonatomic) IBOutlet UIView *fromDateView;

@property (weak, nonatomic) IBOutlet UIView *toDateView;
@property (weak, nonatomic) IBOutlet CustomButton *fromDatePickerBtn;
@property (weak, nonatomic) IBOutlet CustomButton *toDatePickerBtn;

@end

@implementation AddPlanDetailsPopVC
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

    if ([segue.identifier isEqualToString:@"toDatePicker"] )
    {
    
        DatePickerViewController *datePickerVC = (DatePickerViewController*)[segue destinationViewController];
        datePickerVC.dateDelegate = self;
        datePickerVC.m_clickBtn = self.toDatePickerBtn;
        
    }
    if ([segue.identifier isEqualToString:@"fromDatePicker"] )
    {
        
        DatePickerViewController *datePickerVC = (DatePickerViewController*)[segue destinationViewController];
        datePickerVC.dateDelegate = self;
        datePickerVC.m_clickBtn = self.fromDatePickerBtn;
        
    }
    
    
    
    
}

#pragma mark - 自定义方法

-(void)awakeFromNib
{
    
}
//TODO: 添加视图
-(void)layoutMainCustomView
{
    /**
     *  绘制分割线
     *
     */
    self.headTableView.layer.borderWidth = 2.0;
    self.headTableView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;

    self.mansTableView.layer.borderWidth = 2.0;
    self.mansTableView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;

    self.noteTF.layer.borderWidth = 2.0;
    self.noteTF.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
    
    
    self.toDateView.layer.borderWidth = 2.0;
    self.toDateView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
    
    self.fromDateView.layer.borderWidth = 2.0;
    self.fromDateView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
    

    
    /**
     *  所在区
     */
    self.districtTF.dropDownDelegate = self;
    self.districtTF.dropDownDataSource = self;
    
    /**
     *  行业类别
     */
    self.IndustryCategoriesTF.dropDownDelegate = self;
    self.IndustryCategoriesTF.dropDownDataSource = self;
    
    /**
     *  业务负责人
     */
    self.headOFTF.dropDownDelegate = self;
    self.headOFTF.dropDownDataSource = self;
    
    /**
     *  业务负责科室
     */
    self.responsibleDepTF.dropDownDelegate = self;
    self.responsibleDepTF.dropDownDataSource = self;
    
 
    
    /**
     *  ios7以后需要专门设置下分割线要不然不是从每行的开始绘制的
     *
     */
//    [self.headTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [self.mansTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//    
}

-(void)SetUpData
{
    [self layoutMainCustomView];
    
  
    [self Add_RAC_Attention];
    
}

-(void)Add_RAC_Attention
{
    
    //nameOFEntityTF
    
    @weakify(self);
    
    [[self.nameOFEntityTF.rac_textSignal
       throttle:0.5] subscribeNext:^(NSString *wtdwmcStr)
     {
         [[BaseNetWork getInstance] hideDialog];
         NSDictionary *dict =@{@"wtdwmc":wtdwmcStr,@"num":@"5"};
         [[[[[BaseNetWork getInstance] rac_getPath:@"getWtdw.do" parameters:dict]map:^(id responseData)
            {
                NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
                
                return [dict valueForKeyPath:@"wtdwList"];
            }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
          subscribeNext:^(NSArray *arr) {
              @strongify(self)
              
              self.m_autoTFArr = [arr linq_select:^id(NSDictionary *dict){
                  
                  autoTableViewData *data = [[autoTableViewData alloc]init];
                  data.m_dict = [NSDictionary dictionaryWithDictionary:dict];
                  
                  return data;
              }];
              
              [self.nameOFEntityTF reloadData];
              
              
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
     }];
    
}

/**
 *  通过查询委托单位过去的基本信息
 *
 *  @param 

 arr 更新视图 arr[0]:  委托单基本信息
        {
 
            "WTDWDZ": "安达街安达大厦 5B",
            "LXR": "林乐涛",
            "WTDWMC": "吉林省非凡消防工程检测服务有限公司", 
            "WTDWBM": "13700",
            "WTDWYB": 130011,
            "LXDH": "15543661119",
            "HYLBBM": "C025",
            "SZDQ": "220100"
        }   
 arr[1] :联系人信息
        {
            "LXR": "林乐涛",
            "LXDH": "15543661119" 
        }
 */
-(void)updateWTDWWithData:(NSArray *) arr
{
    if (arr.count >=1) {
        
        NSString *dqbhStr = nil;
        NSDictionary *dict0 = [NSDictionary dictionaryWithDictionary:arr[0][0]];
         NSDictionary *dict1 = [NSDictionary dictionaryWithDictionary:arr[1][0]];
        if ([dict0 objectForKey:@"WTDWDZ"])
        {
            self.addrOFEntity.text = [NSString stringWithFormat:@"%@",dict0[@"WTDWDZ"]];
            self.zipCodeTF.text = [NSString stringWithFormat:@"%@",dict0[@"WTDWYB"]];
            self.contactTF.text = [NSString stringWithFormat:@"%@",dict1[@"LXR"]];
            self.ContactTELTF.text = [NSString stringWithFormat:@"%@",dict1[@"LXDH"]];
            
            dqbhStr = [NSString stringWithFormat:@"%@",dict0[@"SZDQ"]];

        }else //否则说明arr[0] 是 联系人信息
        {
            self.addrOFEntity.text = [NSString stringWithFormat:@"%@",dict1[@"WTDWDZ"]];
            self.zipCodeTF.text = [NSString stringWithFormat:@"%@",dict1[@"WTDWYB"]];
            self.contactTF.text = [NSString stringWithFormat:@"%@",dict0[@"LXR"]];
            self.ContactTELTF.text = [NSString stringWithFormat:@"%@",dict0[@"LXDH"]];
            
            dqbhStr = [NSString stringWithFormat:@"%@",dict1[@"SZDQ"]];
        }

        
        
        @weakify(self)
        [[BaseNetWork getInstance] showDialog];
        NSDictionary *dict =@{@"dqbh":dqbhStr};
        [[[[[BaseNetWork getInstance] rac_getPath:@"findSzdq.do" parameters:dict]map:^(id responseData)
           {
               NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
               
               return [dict valueForKeyPath:@"szdq"];
           }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
         subscribeNext:^(NSArray *arr) {
             
             @strongify(self)
             self.districtTF.text = arr[0][@"dqmc"];
             
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
    
    
    
   
    
}
- (IBAction)dismissClick:(id)sender {
    
    if ([self.m_popDelegate respondsToSelector:@selector(dismissPopoverSelected)]) {
        [self.m_popDelegate dismissPopoverSelected];
    }
}
- (IBAction)cancleClick:(id)sender {
    
    if ([self.m_popDelegate respondsToSelector:@selector(dismissPopoverSelected)]) {
        [self.m_popDelegate dismissPopoverSelected];
    }
}
- (IBAction)okClick:(id)sender {
    
    [Dialog toast:@"确定"];
    
    
}

#pragma mark - 代理协议方法

#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier;
    if (tableView == self.headTableView) {
        cellIdentifier = @"headTableViewCell";
          UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//        radio-defauit
        
        if(indexPath.row == 0)
        {
            cell.imageView.image = [UIImage imageNamed:@"radio-selected"];
        }else
        {
            cell.imageView.image = [UIImage imageNamed:@"radio-defauit"];
        }
        
        
        cell.textLabel.text = @"检验科室A组";
        return cell;
    }else
    {
        cellIdentifier = @"mansTableView";
          UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"checkbox-selected"];
        
        cell.textLabel.text = @"检验科室A组";
        return cell;
        
    }
 
    
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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


#pragma mark - AutoCompleteTextFieldDataSource
//TODO:数据回来时必须先更新数据代理，然后再调用autotextfield 的 relodata
-(NSArray *)autoCompleteDataSourceTextField:(AutoCompleteTextField *)textField
{
    return self.m_autoTFArr;
}

#pragma mark - AutoCompleteTextFieldDelegate
- (void)autoCompleteTextField:(AutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<AutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    autoTableViewData *data = ( autoTableViewData *)selectedObject;
    
    @weakify(self)
    [[BaseNetWork getInstance] showDialog];
    NSDictionary *dict =@{@"wtdwbm":data.m_dict[@"WTDWBM"]};
    [[[[[BaseNetWork getInstance] rac_getPath:@"getWtdwjbxx.do" parameters:dict]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return [dict valueForKeyPath:@"wtdwjbxx"];
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSArray *arr) {
        
        @strongify(self)
         [self updateWTDWWithData:arr];
         
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

#pragma mark - DatePickerDelegate
-(void)DatePickerVC:(DatePickerViewController*)datePickerVC DidseletedDate:(NSDate*) date
{
    
    // 将NSDate格式装换成NSString类型
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    // 设置日历显示格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 把日历时间传给字符串
    
    NSString *strDate = [dateFormatter stringFromDate:date];

    
    CustomButton *customBtn = (CustomButton *)datePickerVC.m_clickBtn;
    
    
    [customBtn setTitle:strDate forState:UIControlStateNormal];
    
    [customBtn.m_info setObject:date forKey:@"date"];
    
}

#pragma  mark - DropDownTextFieldDataSource
-(NSArray *)dropDownTextFieldDataSourceTextField:(DropDownTextField *)textField;

{
    return @[@"sadf",@"asdf",@"asdfsadf",@"asdffdsa",@"sadf",@"asdf",@"asdfsadf",@"asdffdsa"];
}

#pragma mark - DropDownTextFieldShowCellTextLabel
- (NSString *)getShowCellForTextLabel
{
    return @"asdfsadf";
}

@end
