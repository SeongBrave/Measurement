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
#import "DistrictModel.h"
#import "HeadOFModel.h"
#import "ResponsibleDepModel.h"
#import "IndustryCategoriesModel.h"
#import "PlanDetailsHead_DepCell.h"
#import "PlanDetailsMans_DepCell.h"
#import "ks_Model.h"
#import "DepManViewController.h"
#import "DepMansViewController.h"




@interface AddPlanDetailsPopVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,AutoCompleteTextFieldDataSource,AutoCompleteTextFieldDelegate,DatePickerDelegate,DropDownTextFieldDataSource,DropDownTextFieldDelegate,PlanDetailsHead_DepCellDelegate,PlanDetailsMans_DepCellDelegate,DepManVCDelegate,DepMansVCDelegate>


@property(nonatomic , strong)NSArray *m_autoTFArr;


@property(nonatomic , strong)DepManViewController *m_head_depManVC;

@property(nonatomic , strong)DepMansViewController *m_mans_depManVC;

/**
 *  科室负责人数据
 */
@property(nonatomic, strong)NSArray *m_ks_headArr;

/**
 *  科室人员数据
 */
@property(nonatomic, strong)NSArray *m_ks_mansArr;

@property(nonatomic , strong)ks_Model *selected_ks_headModel;

@property(nonatomic , strong)ks_Model *selected_ks_MansModel;


/**
 *  科室负责人
 */
@property (weak, nonatomic) IBOutlet UITableView *headTableView;


@property (nonatomic, strong) NSIndexPath *lastIndex;

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
@property (weak, nonatomic) IBOutlet UIView *forensicsDateView;
@property (weak, nonatomic) IBOutlet CustomButton *forensicsDateBtn;

/**
 *  所在区
 */
@property (nonatomic , strong)NSArray *districtArr;

/**
 *  行业类别
 */
@property (nonatomic , strong)NSArray *industryCategoriesArr;

/**
 *  业务负责科室
 */
@property (nonatomic , strong)NSArray *responsibleDepArr;

/**
 *  业务负责人
 */
@property (nonatomic , strong)NSArray *headOFArr;



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
    
    if ([segue.identifier isEqualToString:@"forensicsDatePicker"] )
    {
        
        DatePickerViewController *datePickerVC = (DatePickerViewController*)[segue destinationViewController];
        datePickerVC.dateDelegate = self;
        datePickerVC.m_clickBtn = self.forensicsDateBtn;
        
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
    
    self.forensicsDateView.layer.borderWidth = 2.0;
    self.forensicsDateView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
    
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
    
    [self loadInitDutyc];
    
}

/**
 *  获取 进入添加计划页面 的数据
 */
-(void)loadInitDutyc
{
    
    [[BaseNetWork getInstance]hideDialog];
    @weakify(self)
    [[[[[BaseNetWork getInstance] rac_getPath:@"initDutyc.do" parameters:nil]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return [dict valueForKeyPath:@"ret"];
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary  *retDict) {
         
         @strongify(self)
        
         /**
          *  所在区
          */
           NSArray *district_Arr = retDict[@"szdq"];
         self.districtArr = [district_Arr linq_select:^id(NSDictionary *dict){
             
             DistrictModel *districtModel = [[DistrictModel alloc]init];
             districtModel.m_data = [NSDictionary dictionaryWithDictionary:dict];
             
             return districtModel;
         }];
         
         /**
          *  行业类别
          */
         NSArray *industryCategories_Arr = retDict[@"hylb"];
         self.industryCategoriesArr = [industryCategories_Arr linq_select:^id(NSDictionary *dict){
             
             IndustryCategoriesModel *industryCategoriesModel = [[IndustryCategoriesModel alloc]init];
             industryCategoriesModel.m_data = [NSDictionary dictionaryWithDictionary:dict];
             
             return industryCategoriesModel;
         }];
         
         /**
          *  业务负责科室
          */
         NSArray *responsibleDep_Arr = retDict[@"ksry"];
         self.responsibleDepArr = [responsibleDep_Arr linq_select:^id(NSDictionary *dict){
             
             ResponsibleDepModel *responsibleDepModel = [[ResponsibleDepModel alloc]init];
             responsibleDepModel.m_data = [NSDictionary dictionaryWithDictionary:dict];
             
             return responsibleDepModel;
         }];
        
         
         //TODO: 需要修改这块
         /**
          *  业务负责科室
          */
         NSArray *headOF_Arr = retDict[@"ry"];
         self.headOFArr = [headOF_Arr linq_select:^id(NSDictionary *dict){
             
             
             ResponsibleDepModel *responsibleDepModel = [[ResponsibleDepModel alloc]init];
             responsibleDepModel.m_data = [NSDictionary dictionaryWithDictionary:dict];
             
             return responsibleDepModel;
         }];
         
         /**
          *  科室人员
          *
          *  @param
          *
          *  @return
          */
         self.m_ks_mansArr = [responsibleDep_Arr linq_select:^id(NSDictionary *dict){
             
             ks_Model *model = [MTLJSONAdapter modelOfClass:[ks_Model class] fromJSONDictionary:dict error:nil];
             model.isSelected = NO;
             model.isCheckBox = YES;
             
             NSArray *myarr = dict[@"ry"];
             model.ryArr =[myarr linq_select:^id(NSDictionary *dict){
             
                 ry_Model *ryModel = [MTLJSONAdapter modelOfClass:[ry_Model class] fromJSONDictionary:dict error:nil];
                 ryModel.isSelected = NO;
                 ryModel.isCheckBox = YES;
                 
                 
                 return ryModel;
             }];
             return model;
         }];
         
         
         /**
          *  科室负责人
          *
          *  @param
          *
          *  @return
          */
         self.m_ks_headArr = [responsibleDep_Arr linq_select:^id(NSDictionary *dict){
             
             ks_Model *model = [MTLJSONAdapter modelOfClass:[ks_Model class] fromJSONDictionary:dict error:nil];
             model.isSelected = NO;
             model.isCheckBox = NO;
             NSArray *myarr = dict[@"ry"];
             model.ryArr =[myarr linq_select:^id(NSDictionary *dict){
                 
                 ry_Model *ryModel = [MTLJSONAdapter modelOfClass:[ry_Model class] fromJSONDictionary:dict error:nil];
                 ryModel.isSelected = NO;
                 ryModel.isCheckBox = NO;
                 
                 
                 return ryModel;
             }];
             
             return model;
             
         }];
         
         [self.headTableView reloadData];
          [self.mansTableView reloadData];
    
        
         
     }error:^(NSError *error){

         
     }];
    

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
    if(tableView == self.headTableView)
    {
        return _m_ks_headArr.count;
    }else if(tableView == self.mansTableView)
    {
       return _m_ks_mansArr.count;
    }
    return 0;
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
        cellIdentifier = @"PlanDetailsHead_DepCell";
          PlanDetailsHead_DepCell *cell = (PlanDetailsHead_DepCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        cell.m_head_DepDelegate = self;
        
        [cell configureCellWithItem:self.m_ks_headArr[indexPath.row]];
        
        return cell;
    }else
    {
        cellIdentifier = @"PlanDetailsMans_DepCell";
        PlanDetailsMans_DepCell *cell = (PlanDetailsMans_DepCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        cell.m_mans_DepDelegate = self;
        
        [cell configureCellWithItem:self.m_ks_mansArr[indexPath.row]];
        
        return cell;
    }
 
    
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //单选功能
    if(tableView == self.headTableView)
    {
       
        ks_Model *model = self.m_ks_headArr[indexPath.row];
        if (_lastIndex && _lastIndex.row != indexPath.row) {
            
            ks_Model *lastModel = self.m_ks_headArr[_lastIndex.row];
            model.isSelected = YES;
            lastModel.isSelected = NO;
            
        }else
        {
            model.isSelected = !model.isSelected;
        }

        _lastIndex = indexPath;

    }else if(tableView == self.mansTableView)
    {
        ks_Model *model = self.m_ks_mansArr[indexPath.row];
        
        model.isSelected = !model.isSelected;
        
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
    
    if (textField == self.districtTF) {
        return self.districtArr;
    }else if (textField == self.IndustryCategoriesTF) {
        return self.industryCategoriesArr;
    }else if (textField == self.responsibleDepTF) {
        return self.responsibleDepArr;
    }else if (textField == self.headOFTF) {
        return self.headOFArr;
    }
    return nil;
}

#pragma mark - DropDownTextFieldDelegate
-(void)dropDownTextField:(DropDownTextField *)textField didSelectedWithData:(id<DropDownTextFieldShowCellTextLabel>) data forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (textField == self.districtTF) {
        
        
    }else if (textField == self.IndustryCategoriesTF) {
      
        
    }else if (textField == self.responsibleDepTF)
    {
        //在选择完 业务负责科室 后需要更新业务负责人得数据
        ResponsibleDepModel *respModel = ( ResponsibleDepModel *)data;
        
        /**
         *  业务负责科室
         */
        NSArray *headOF_Arr = respModel.m_data[@"ry"];
        self.headOFArr = [headOF_Arr linq_select:^id(NSDictionary *dict){
            
            HeadOFModel *headOFModel = [[HeadOFModel alloc]init];
            headOFModel.m_data = [NSDictionary dictionaryWithDictionary:dict];
            
            return headOFModel;
        }];
     
        
        
    }else if (textField == self.headOFTF) {
   
    }
    debug_object([data getShowCellForTextLabel]);
    
}

#pragma mark - PlanDetailsHead_DepCellDelegate
-(void)planDetailsHead_DepCell:(PlanDetailsHead_DepCell*) depCell didSelectedWithks_Model:(ks_Model *) ksModel
{
    
    DepManViewController *depManVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DepManViewController"];
    depManVC.modalPresentationStyle = UIModalPresentationFormSheet;
    depManVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    depManVC.m_dataSourceArr = ksModel.ryArr;
    depManVC.m_delegate = self;
    [self presentViewController:depManVC animated:YES completion:nil];
//    depManVC.view.superview.bounds = CGRectMake(0, 0, 529, 279);
    depManVC.view.superview.frame = CGRectMake(0, 0, 529, 279);//it's important to do this after presentModalViewController
    depManVC.view.superview.center = self.view.center;
    self.m_head_depManVC = depManVC;
    
    /**
     *  将要修改的model赋值给vc然后再vc中修改
     */
     self.m_head_depManVC.ksModel = ksModel;
}


#pragma mark - PlanDetailsMans_DepCellDelegate
-(void)planDetailsMans_DepCell:(PlanDetailsMans_DepCell*) depCell didSelectedWithks_Model:(ks_Model *) ksModel
{
    
    self.selected_ks_headModel = ksModel;
    DepMansViewController *depManVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DepMansViewController"];

    depManVC.m_delegate = self;
    depManVC.modalPresentationStyle = UIModalPresentationFormSheet;
    depManVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    depManVC.m_dataSourceArr = ksModel.ryArr;
    [self presentViewController:depManVC animated:YES completion:nil];
    //    depManVC.view.superview.bounds = CGRectMake(0, 0, 529, 279);
    depManVC.view.superview.frame = CGRectMake(100, 200, 529, 279);//it's important to do this after presentModalViewController
    depManVC.view.superview.center = self.view.center;
    
    self.m_mans_depManVC = depManVC;
    
    /**
     *  将要修改的model赋值给vc然后再vc中修改
     */
    self.m_mans_depManVC.ksModel = ksModel;
}


#pragma mark - DepManVCDelegate
-(void)DepManVC:(DepManViewController *)depManVC didSelectedArr:(NSArray *) selectedArr
{

 
}

#pragma mark - DepMansVCDelegate
-(void)DepMansVC:(DepMansViewController *)depManVC didSelectedArr:(NSArray *) selectedArr
{
    
}

@end
