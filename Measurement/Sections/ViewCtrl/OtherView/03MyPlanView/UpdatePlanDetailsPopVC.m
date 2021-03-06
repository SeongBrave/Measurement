//
//  UpdatePlanDetailsPopVC.m
//  Measurement
//
//  Created by DTSoft on 15/1/6.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "UpdatePlanDetailsPopVC.h"
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
#import "ProgressOverviewCell.h"
#import "jcjd_Model.h"
#import "jcjd_Detail_Model.h"
#import "TestProgressContentCell.h"
#import "SignatureCell.h"
#import "SignatureViewController.h"
#import "TGRImageViewController.h"
#import "TGRImageZoomAnimationController.h"
#import "AppDelegate.h"
#import "UIButton+WebCache.h"
#import "Wcjdjh_ksry_Model.h"
#import "Wcjdjh_Xcks_Model.h"
#import "Wcjdjh_Xcks_Cell.h"
#import "Wcjdjh_Ksry_Vc.h"

#define MaxOffset  100

@interface UpdatePlanDetailsPopVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,Wcjdjh_Ksry_VcDelegate, UIScrollViewDelegate,AutoCompleteTextFieldDataSource,AutoCompleteTextFieldDelegate,DatePickerDelegate,DropDownTextFieldDataSource,DropDownTextFieldDelegate,PlanDetailsHead_DepCellDelegate,Wcjdjh_Xcks_CellDelegate,DepManVCDelegate,DepMansVCDelegate,SignatureViewDelegate,UIViewControllerTransitioningDelegate>


@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;

/**
 *  客户签字
 */
@property (weak, nonatomic) IBOutlet UIScrollView *signatureScrollView;

/**
 * 检测进度
 */
@property (weak, nonatomic) IBOutlet UIScrollView *testProgressScrollView;

/**
 * 计划详情
 */
@property (weak, nonatomic) IBOutlet UIScrollView *planDetailsScrollView;

/**
 *  主scrollview
 */
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;


@property (weak, nonatomic) IBOutlet UIButton *testProgressBtn;
@property (weak, nonatomic) IBOutlet UIButton *signatureBtn;
@property (weak, nonatomic) IBOutlet UIButton *planBtn;
//@property (strong, nonatomic)  UIImageView *btnLineImgV;
@property (weak, nonatomic) IBOutlet UITableView *testProgressTableView;

@property(nonatomic ,strong)UIImageView *lineImgV;

@property(nonatomic , assign) __block int nIndex;



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


@property(nonatomic , strong)NSArray *m_jcjd_ModelArr;


@property(nonatomic , strong)ks_Model *selected_ks_headModel;

@property(nonatomic , strong)ks_Model *selected_ks_MansModel;



@property (weak, nonatomic) IBOutlet UITableView *SignatureTableView;

@property (weak, nonatomic) IBOutlet UIButton *signatureImgBtn;

@property(nonatomic , strong)NSArray *signatureArr;

@property(nonatomic , strong)NSDictionary *signatureDict;

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
 *  单位名称
 */
@property (weak, nonatomic) IBOutlet AutoCompleteTextField *m_dwmc_ATF;

/**
 *  单位地址
 */
@property (weak, nonatomic) IBOutlet DemoTextField *m_dwdz_TF;


/**
 *  联系人
 */
@property (weak, nonatomic) IBOutlet DemoTextField *m_lxr_TF;


/**
 *  联系电话
 */

@property (weak, nonatomic) IBOutlet DemoTextField *m_lxdh_TF;


/**
 *  所在区
 */
@property (weak, nonatomic) IBOutlet DropDownTextField *m_szdq_DTF;

/**
 *  行业类别
 */
@property (weak, nonatomic) IBOutlet DropDownTextField *m_hylb_DTF;


/**
 *  邮编
 */
@property (weak, nonatomic) IBOutlet DemoTextField *m_yb_TF;

/**
 *  业务负责科室
 */
@property (weak, nonatomic) IBOutlet DropDownTextField *m_ywfzks_DTF;



/**
 *  业务负责人
 */

@property (weak, nonatomic) IBOutlet DropDownTextField *m_ywfzr_DTF;

/**
 *  取证日期
 */
@property (weak, nonatomic) IBOutlet UIView *forensicsDateView;
@property (weak, nonatomic) IBOutlet CustomButton *forensicsDateBtn;


/**
 *  特殊要求
 */

@property (weak, nonatomic) IBOutlet DemoTextField *m_tsyq_TF;

/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet UITextView *noteTF;

/**
 *  下厂时间
 */
@property (weak, nonatomic) IBOutlet UIView *fromDateView;
@property (weak, nonatomic) IBOutlet CustomButton *fromDatePickerBtn;

@property (weak, nonatomic) IBOutlet UIView *toDateView;
@property (weak, nonatomic) IBOutlet CustomButton *toDatePickerBtn;

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


@property (weak, nonatomic) IBOutlet UIView *menuBarView;

/**
 *  客户签字
 */

/**
 *  用于保存最后确定时传的参数
 */
@property(nonatomic ,strong)NSMutableDictionary *m_saveDataDict;

/**
 *  单位名称
 */
@property (weak, nonatomic) IBOutlet UILabel *signature_wtdwmc_Label;

/**
 *  单位地址
 */
@property (weak, nonatomic) IBOutlet UILabel *signature_dwdz_Label;

/**
 *  联系人
 */
@property (weak, nonatomic) IBOutlet UILabel *signature_lxrxm_Label;

/**
 *  联系电话
 */
@property (weak, nonatomic) IBOutlet UILabel *signature_lxdh_Label;


@end
@implementation UpdatePlanDetailsPopVC


-(NSMutableDictionary *)m_saveDataDict
{
    if (_m_saveDataDict == nil) {
        _m_saveDataDict = [[NSMutableDictionary alloc]init];
        [self resetSaveDict];
        
    }
    
    return _m_saveDataDict;
}

-(void)resetSaveDict
{
    
    LoginedUser *usr = [LoginedUser sharedInstance];
    
    //当前登录用户的usercode
    
    self.m_saveDataDict[@"id"] = @"";
    self.m_saveDataDict[@"usercode"] = usr.usercode;
    self.m_saveDataDict[@"WTDWBH"] = @"";
    self.m_saveDataDict[@"WTDWMC"] = @"";
    self.m_saveDataDict[@"DWDZ"] = @"";
    self.m_saveDataDict[@"LXRXM"] = @"";
    self.m_saveDataDict[@"LXDH"] = @"";
    
    self.m_saveDataDict[@"YWFZKSBH"] = @"";
    self.m_saveDataDict[@"YWFZKS"] = @"";
    self.m_saveDataDict[@"YWFZRBH"] = @"";
    self.m_saveDataDict[@"YWFZR"] = @"";
    self.m_saveDataDict[@"HYLBID"] = @"";
    
    
    
    
    self.m_saveDataDict[@"HYLBMC"] = @"";
    self.m_saveDataDict[@"SZDQBH"] = @"";
    self.m_saveDataDict[@"SZDQ"] = @"";
    self.m_saveDataDict[@"YB"] = @"";
    self.m_saveDataDict[@"QZRQ"] = @"";
    
    
    self.m_saveDataDict[@"KHTSYQ"] = @"";
    self.m_saveDataDict[@"BZ"] = @"";
    
    self.m_saveDataDict[@"XCSJQ"] = @"";
    self.m_saveDataDict[@"XCSJZ"] = @"";
    self.m_saveDataDict[@"xcksbhs"] = @"";
    self.m_saveDataDict[@"xcrybhs"] = @"";
    
    self.m_saveDataDict[@"XCFZR"] = @"";
    self.m_saveDataDict[@"XCFZRBH"] = @"";
    self.m_saveDataDict[@"RWWCQK"] = @"";
    
    
    
}


#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self SetUpData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self updateViewDataWithShowDict:_m_showDict];
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
        datePickerVC.m_date = [NSDate new];
        datePickerVC.dateDelegate = self;
        datePickerVC.datePickerMode = UIDatePickerModeDateAndTime;
        datePickerVC.m_clickBtn = self.toDatePickerBtn;
        
    }
    if ([segue.identifier isEqualToString:@"fromDatePicker"] )
    {
        
        DatePickerViewController *datePickerVC = (DatePickerViewController*)[segue destinationViewController];
        datePickerVC.m_date = [NSDate new];
        datePickerVC.datePickerMode = UIDatePickerModeDateAndTime;
        datePickerVC.dateDelegate = self;
        datePickerVC.m_clickBtn = self.fromDatePickerBtn;
        
        
    }
    
    if ([segue.identifier isEqualToString:@"forensicsDatePicker"] )
    {
        
        DatePickerViewController *datePickerVC = (DatePickerViewController*)[segue destinationViewController];
        datePickerVC.m_date = [NSDate new];
        datePickerVC.datePickerMode = UIDatePickerModeDateAndTime;
        datePickerVC.dateDelegate = self;
        datePickerVC.m_clickBtn = self.forensicsDateBtn;
        
    }
    

    
}

#pragma mark - 自定义方法


/**
 *  用于更新客户签名模块的数据
 *
 *  @param showDict
 */
-(void)updateSignatureViewDataWithShowDict:(NSDictionary *) showDict
{
    self.signature_wtdwmc_Label.text =  [showDict GetLabelWithKey:@"wtdwmc"];
    
       self.signature_dwdz_Label.text =[showDict GetLabelWithKey:@"dwdz"];
    
       self.signature_lxrxm_Label.text = [showDict GetLabelWithKey:@"lxrxm"];
    
       self.signature_lxdh_Label.text = [showDict GetLabelWithKey:@"lxdh"];
    
}
/**
 *  用于更新界面数据
 *
 *  @param showDict
 */
-(void)updateViewDataWithShowDict:(NSDictionary *)showDict
{
    
    self.m_dwmc_ATF.text =  [showDict GetLabelWithKey:@"WTDWMC"];
    
    self.m_dwdz_TF.text = [showDict GetLabelWithKey:@"DWDZ"];
    
    NSLog(@"%@",showDict[@"DWDZ"]);
    
    debug_object(showDict[@"BY7"]);
    
    
    if (showDict[@"DWDZ"] == nil) {
        
        debug_object(@"为nil");
    }
    
    
    if (showDict[@"DWDZ"]) {
        
        debug_object(@"不为nil");
    }
    
    
    
    if (showDict[@"BY7"] == nil) {
        
        debug_object(@"为nil");
    }
    
    
    if (showDict[@"BY7"]) {
        
        debug_object(@"不为nil");
    }
    
    
    self.m_lxr_TF.text =[showDict GetLabelWithKey:@"LXDH"];
    
    
    self.m_lxdh_TF.text =[showDict GetLabelWithKey:@"LXDH"];
    
    self.m_szdq_DTF.text =[showDict GetLabelWithKey:@"SZDQ"];
    
    
    self.m_hylb_DTF.text =[showDict GetLabelWithKey:@"HYLBMC"];
    
    self.m_yb_TF.text =[showDict GetLabelWithKey:@"YB"];
    
    
    self.m_ywfzks_DTF.text = [showDict GetLabelWithKey:@"YWFZKS"];
    self.m_ywfzr_DTF.text =[showDict GetLabelWithKey:@"YWFZR"];
    
    [self.forensicsDateBtn setTitle:@"" forState:UIControlStateNormal];
    
    self.m_tsyq_TF.text = [showDict GetLabelWithKey:@"tsyq"];
    
    self.noteTF.text = [showDict GetLabelWithKey:@"BZ"];
 
    [self.fromDatePickerBtn setTitle:[showDict GetLabelWithKey:@"XCSJQ"]forState:UIControlStateNormal];
    
    [self.toDatePickerBtn setTitle:[showDict GetLabelWithKey:@"XCSJQ"] forState:UIControlStateNormal];
    
    
//    CJSJ
    
    
    
}

/**
 *  为 CustomButton 设置时间
 *
 *  @param custombtn
 *  @param dateStr   时间
 */
-(void)setCustomButton:(CustomButton *) custombtn byDateStr:(NSString *) dateStr
{
    
    // 2012-05-17 11:23:23
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *fromdate=[format dateFromString:dateStr];
//    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
//    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
//    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];

    
    [custombtn.m_info setObject:fromdate ==nil?[NSDate new]:fromdate forKey:@"date"];
    NSString *strDate = [format stringFromDate:fromdate];
    [custombtn setTitle:strDate forState:UIControlStateNormal];
}

-(void)update_Sbxq_ViewByDict:(NSDictionary *) retDict
{
    
    NSDictionary * wdjhDict = retDict[@"wdjh"];
    
    
    
    LoginedUser *usr = [LoginedUser sharedInstance];
    
    //当前登录用户的usercode
    
    self.m_saveDataDict[@"id"] = [wdjhDict GetLabelWithKey:@"rwbh"];
    
    
    self.m_saveDataDict[@"usercode"] = usr.usercode;
    self.m_saveDataDict[@"DWDZ"] = [wdjhDict GetLabelWithKey:@"dwdz"];
    self.m_saveDataDict[@"LXRXM"] = [wdjhDict GetLabelWithKey:@"lxrxm"];
    self.m_saveDataDict[@"LXDH"] = [wdjhDict GetLabelWithKey:@"lxdh"];
    
    self.m_saveDataDict[@"YWFZKSBH"] = [wdjhDict GetLabelWithKey:@"ywfzksbh"];
    self.m_saveDataDict[@"YWFZKS"] = [wdjhDict GetLabelWithKey:@"ywfzks"];
    self.m_saveDataDict[@"YWFZRBH"] = [wdjhDict GetLabelWithKey:@"ywfzrbh"];
    self.m_saveDataDict[@"YWFZR"] = [wdjhDict GetLabelWithKey:@"ywfzr"];
    self.m_saveDataDict[@"HYLBID"] = [wdjhDict GetLabelWithKey:@"hylbid"];
    
    
    self.m_saveDataDict[@"WTDWBH"] = [wdjhDict GetLabelWithKey:@"wtdwbh"];
    self.m_saveDataDict[@"WTDWMC"] = [wdjhDict GetLabelWithKey:@"wtdwmc"];
    
    self.m_saveDataDict[@"HYLBMC"] = [wdjhDict GetLabelWithKey:@"hylbmc"];
    self.m_saveDataDict[@"SZDQBH"] = [wdjhDict GetLabelWithKey:@"szdqbh"];
    self.m_saveDataDict[@"SZDQ"] = [wdjhDict GetLabelWithKey:@"szdq"];
    self.m_saveDataDict[@"YB"] = [wdjhDict GetLabelWithKey:@"yb"];
    self.m_saveDataDict[@"QZRQ"] = [wdjhDict GetLabelWithKey:@"qzrq"];
    
    
    self.m_saveDataDict[@"KHTSYQ"] = [wdjhDict GetLabelWithKey:@"khtsyq"];
    self.m_saveDataDict[@"BZ"] = [wdjhDict GetLabelWithKey:@"bz"];
    
    self.m_saveDataDict[@"XCSJQ"] = [wdjhDict GetLabelWithKey:@"xcsjq"];
    self.m_saveDataDict[@"XCSJZ"] = [wdjhDict GetLabelWithKey:@"xcsjz"];
    
    self.m_saveDataDict[@"XCFZR"] = [wdjhDict GetLabelWithKey:@"xcfzr"];
    self.m_saveDataDict[@"XCFZRBH"] = [wdjhDict GetLabelWithKey:@"xcfzrbh"];
    self.m_saveDataDict[@"RWWCQK"] = [wdjhDict GetLabelWithKey:@"rwwcqk"];
    
    
    /*
     其它字段都是和保存的时候一样，就剩这两个字段需要重新获取
    self.m_saveDataDict[@"xcksbhs"] = [wdjhDict GetLabelWithKey:@"rwbh"];
    self.m_saveDataDict[@"xcrybhs"] = [wdjhDict GetLabelWithKey:@"rwbh"];
     */
    
    self.m_dwmc_ATF.text =  [wdjhDict GetLabelWithKey:@"wtdwmc"];
    
    self.m_dwdz_TF.text = [wdjhDict GetLabelWithKey:@"dwdz"];
    
    
    self.m_lxr_TF.text =[wdjhDict GetLabelWithKey:@"lxrxm"];
    
    
    self.m_lxdh_TF.text =[wdjhDict GetLabelWithKey:@"lxdh"];
    
    self.m_szdq_DTF.text =[wdjhDict GetLabelWithKey:@"szdq"];
    
    
    self.m_hylb_DTF.text =[wdjhDict GetLabelWithKey:@"hylbmc"];
    
    self.m_yb_TF.text =[wdjhDict GetLabelWithKey:@"yb"];
    
    
    self.m_ywfzks_DTF.text = [wdjhDict GetLabelWithKey:@"ywfzks"];
    self.m_ywfzr_DTF.text =[wdjhDict GetLabelWithKey:@"ywfzr"];
    
    
    [self setCustomButton:self.forensicsDateBtn byDateStr:[wdjhDict GetLabelWithKey:@"qzrq"]];
    
//    // 2012-05-17 11:23:23
//    NSDateFormatter *format=[[NSDateFormatter alloc] init];
//    [format setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSDate *fromdate=[format dateFromString:[wdjhDict GetLabelWithKey:@"qzrq"]];
//    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
//    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
//    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
//    
//    
//    [self.forensicsDateBtn.m_info setObject:fromDate ==nil?[NSDate new]:fromDate forKey:@"date"];
//    NSString *strDate = [format stringFromDate:fromDate];
//    [self.forensicsDateBtn setTitle:strDate forState:UIControlStateNormal];
//    
//    NSString *qzrqStr = [wdjhDict GetLabelWithKey:@"qzrq"];
//    
//    
//    [self.forensicsDateBtn setTitle:qzrqStr forState:UIControlStateNormal];
    
    self.m_tsyq_TF.text = [wdjhDict GetLabelWithKey:@"tsyq"];
    
    self.noteTF.text = [wdjhDict GetLabelWithKey:@"bz"];
    
//    [self.fromDatePickerBtn setTitle:[wdjhDict GetLabelWithKey:@"qzrq"]forState:UIControlStateNormal];
    
     [self setCustomButton:self.fromDatePickerBtn byDateStr:[wdjhDict GetLabelWithKey:@"xcsjq"]];
    
     [self setCustomButton:self.toDatePickerBtn byDateStr:[wdjhDict GetLabelWithKey:@"xcsjz"]];
    
//    [self.toDatePickerBtn setTitle:[wdjhDict GetLabelWithKey:@"xcsjz"] forState:UIControlStateNormal];
    
//    Wcjdjh_Xcks_Model
    

    NSArray *xcksryArr = retDict[@"xcksry"];
    
    
    /**
     *  科室人员
     *
     *  @param
     *
     *  @return
     */
    self.m_ks_mansArr = [xcksryArr linq_select:^id(NSDictionary *dict){
        
        Wcjdjh_Xcks_Model *model = [MTLJSONAdapter modelOfClass:[Wcjdjh_Xcks_Model class] fromJSONDictionary:dict error:nil];

        NSArray *myarr = dict[@"ry"];
        model.m_ksryArr =[myarr linq_select:^id(NSDictionary *dict){
            
            Wcjdjh_ksry_Model *ryModel = [MTLJSONAdapter modelOfClass:[Wcjdjh_ksry_Model class] fromJSONDictionary:dict error:nil];
            
            return ryModel;
        }];
        return model;
    }];

    
    
    
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
     *  下厂科室负责人编号
     */
    NSString *xcfzrbhStr = wdjhDict[@"xcfzrbh"];
    
    
    NSArray *xcfzrArr = retDict[@"xcfzr"];
    

    NSDictionary *xcfzrDict =nil;
    if (xcfzrArr.count >0 ) {
    
        xcfzrDict = xcfzrArr[0];
        
    }
//    {
//        comcode = 22000004;
//        usercode = xie;
//        username = "\U8c22";
//    }
    /**
     *  下厂科室编号
     *
     */
    /**
     *
     */
    if (xcfzrDict == nil) {
        return;
    }
     NSString *xcksStr = xcfzrDict[@"comcode"];
    
    /**
     *  科室负责人
     *
     *  @param
     *
     *  @return
     */
    self.m_ks_headArr = [responsibleDep_Arr linq_select:^id(NSDictionary *dict){
        
        ks_Model *model = [MTLJSONAdapter modelOfClass:[ks_Model class] fromJSONDictionary:dict error:nil];
        
        /**
         *  选中的下厂科室编号
         */
        if ([model.comcode isEqualToString:xcksStr]) {
            
            model.isSelected = YES;
            
            NSArray *myarr = dict[@"ry"];
            model.ryArr =[myarr linq_select:^id(NSDictionary *dict)
            {
                
                ry_Model *ryModel = [MTLJSONAdapter modelOfClass:[ry_Model class] fromJSONDictionary:dict error:nil];
                if ([ryModel.usercode isEqualToString:xcfzrbhStr]) {
                    
                    ryModel.isSelected = YES;
                    
                    model.selected_ryModel = ryModel;
                    
                    model.selected_RYArr = @[ryModel];
                }else
                {
                    ryModel.isSelected = NO;
                }
                ryModel.isCheckBox = NO;
                
                
                return ryModel;
            }];

        }else
        {
            model.isSelected = NO;
            
            NSArray *myarr = dict[@"ry"];
            model.ryArr =[myarr linq_select:^id(NSDictionary *dict){
                
                
                ry_Model *ryModel = [MTLJSONAdapter modelOfClass:[ry_Model class] fromJSONDictionary:dict error:nil];
                ryModel.isCheckBox = NO;
                ryModel.isSelected = NO;
                
                return ryModel;
                
                
              
            }];

            
        }
        
        model.isCheckBox = NO;
        
        return model;
        
    }];
    
    [self.headTableView reloadData];
    [self.mansTableView reloadData];
    
}
//TODO: 添加视图
-(void)layoutMainCustomView
{
    
    self.signatureImgBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.mainScrollView.delegate = self;
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
    self.m_szdq_DTF.dropDownDelegate = self;
    self.m_szdq_DTF.dropDownDataSource = self;
    self.m_szdq_DTF.delegate = self;
    
    /**
     *  行业类别
     */
    self.m_hylb_DTF.dropDownDelegate = self;
    self.m_hylb_DTF.dropDownDataSource = self;
    self.m_hylb_DTF.delegate = self;
    /**
     *  业务负责人
     */
    self.m_ywfzr_DTF.dropDownDelegate = self;
    self.m_ywfzr_DTF.dropDownDataSource = self;
    self.m_ywfzr_DTF.delegate = self;
    /**
     *  业务负责科室
     */
    self.m_ywfzks_DTF.dropDownDelegate = self;
    self.m_ywfzks_DTF.dropDownDataSource = self;
    self.m_ywfzks_DTF.delegate = self;
    
    
    [self.m_dwmc_ATF setRequired:YES];
    [self.m_dwdz_TF setRequired:YES];
    [self.m_lxr_TF setRequired:YES];
    [self.m_lxdh_TF setRequired:YES];
    [self.m_szdq_DTF setRequired:YES];
    [self.m_hylb_DTF setRequired:YES];
    [self.m_ywfzks_DTF setRequired:YES];
    [self.m_ywfzr_DTF setRequired:YES];
    
    
    
    [self.forensicsDateBtn.m_info setObject:[NSDate date] forKey:@"date"];
    [self.fromDatePickerBtn.m_info setObject:[NSDate date] forKey:@"date"];
    [self.toDatePickerBtn.m_info setObject:[NSDate date] forKey:@"date"];
    
    
    // 将NSDate格式装换成NSString类型
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    // 设置日历显示格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 把日历时间传给字符串
    
    NSString *strDate = [dateFormatter stringFromDate:[NSDate new]];
    
    
    
    /**
     *  初始化时间显示为当前时间
     */
    [self.forensicsDateBtn setTitle:strDate forState:UIControlStateNormal];
    
    [self.fromDatePickerBtn setTitle:strDate forState:UIControlStateNormal];
    
    [self.toDatePickerBtn setTitle:strDate forState:UIControlStateNormal];
    
    /**
     *  设置tableview不可点击
     */
    self.SignatureTableView.allowsSelection=NO;
//    self.testProgressTableView.allowsSelection=NO;
    
    
    
    /**
     *  ios7以后需要专门设置下分割线要不然不是从每行的开始绘制的
     *
     */
    //    [self.headTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    //    [self.mansTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    //    

    //TODO:需要修改bug
    self.lineImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"float-tab-bg_line"]];
   
    [self.menuBarView addSubview:_lineImgV];
    
//    [self.lineImgV showPlaceHolder];
    
    NSLog(@"%@", self.menuBarView.subviews);
    
    @weakify(self)
    [self.lineImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self)
        make.width.equalTo(@60);
        make.height.equalTo(@4);
        make.top.equalTo(self.menuBarView.mas_top).offset(2);
        make.leading.equalTo(self.planBtn.mas_leading);
        
    
    }];
    
//    [self.planBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.width.equalTo(@60);
//        make.leading.equalTo(@31);
//    }];
    
}


- (BOOL)validateInputInView:(UIView*)view
{
    
    if (view == self.planDetailsScrollView) {
        
        if (![self.m_dwmc_ATF validate]) {
            [self.m_dwmc_ATF becomeFirstResponder];
            return NO;
        }else if (![self.m_dwdz_TF validate]) {
            [self.m_dwdz_TF becomeFirstResponder];
            return NO;
        }else if (![self.m_lxr_TF validate]) {
            [self.m_lxr_TF becomeFirstResponder];
            return NO;
        }else  if (![self.m_lxdh_TF validate]) {
            [self.m_lxdh_TF becomeFirstResponder];
            return NO;
        }else  if (![self.m_szdq_DTF validate]) {
            [self.m_szdq_DTF verifyshowDropDownTableView];
            return NO;
        }else  if (![self.m_hylb_DTF validate]) {
            [self.m_hylb_DTF verifyshowDropDownTableView];
            return NO;
        }else  if (![self.m_ywfzks_DTF validate]) {
            [self.m_ywfzks_DTF verifyshowDropDownTableView];
            return NO;
        }else  if (![self.m_ywfzr_DTF validate]) {
            [self.m_ywfzr_DTF verifyshowDropDownTableView];
            return NO;
        }else
            return YES;
    }else
    {
        return YES;
    }
    
}

/**
 *  添加rac检测
 */
-(void)Add_RAC_Attention
{
    
//    [self.view showPlaceHolder];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.showsHorizontalScrollIndicator = FALSE;
    @weakify(self)
    [RACObserve(self.mainScrollView, contentOffset) subscribeNext:^(NSValue *value) {
        
        @strongify(self);
        CGPoint offset = [value CGPointValue];
        if (offset.x < 0.0f) {
            [self.mainScrollView setContentOffset:CGPointZero animated:NO];
        }
        else if (offset.x >= self.view.frame.size.width*2){
            [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:NO];
        }
        
    }];
    
    [[self rac_signalForSelector:@selector(scrollViewDidEndDecelerating:) fromProtocol:@protocol(UIScrollViewDelegate)] subscribeNext:^(RACTuple *x) {
        if (x.first == self.mainScrollView) {
            CGPoint offset = [x.first contentOffset];
            NSInteger currentPage = (NSInteger)roundf(offset.x / self.view.frame.size.width);
            
            [self.lineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@60);
                make.height.equalTo(@4);
                make.top.equalTo(self.menuBarView.mas_top).offset(2);
                switch (currentPage) {
                    case 0:
                        make.leading.equalTo(self.planBtn.mas_leading);
                        break;
                    case 1:
                        make.leading.equalTo(self.testProgressBtn.mas_leading);
                        break;

                    case 2:
                        make.leading.equalTo(self.signatureBtn.mas_leading);
                        break;

                    default:
                        break;
                }
            }];
            [UIView animateWithDuration:0.25 animations:^{
                [self.menuBarView layoutIfNeeded];
            }];
        }
    }];
    
    
    /**
     *  计划详情
     *
     */
    [RACObserve(self.planDetailsScrollView, contentOffset) subscribeNext:^(NSValue *value) {
        
        @strongify(self);
        CGPoint offset = [value CGPointValue];
        if (offset.x < 0.0f) {
            [self.mainScrollView setContentOffset:CGPointZero animated:NO];
        }
        else if (offset.x >= self.view.frame.size.width*2){
            [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:NO];
        }
        
    }];
    
    
    /**
     *  客服签字
     *
     */
    [RACObserve(self.signatureScrollView, contentOffset) subscribeNext:^(NSValue *value) {
        
        @strongify(self);
        CGPoint offset = [value CGPointValue];
        if (offset.x < 0.0f) {
            [self.mainScrollView setContentOffset:CGPointZero animated:NO];
        }
        else if (offset.x >= self.view.frame.size.width*2){
            [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:NO];
        }
        
    }];
    
 
    
    
    [[self.planBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
       
        @strongify(self)
        [self updateLineConstraints:next];

        [self.mainScrollView setContentOffset:CGPointZero animated:YES];
        
    }];
    
    
    [[self.testProgressBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
        @strongify(self)
        [self updateLineConstraints:next];
        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width,0} animated:YES];
        
    }];
    
    [[self.signatureBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
        
      @strongify(self)
        [self updateLineConstraints:next];
          [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:YES];
        
    }];
    
        NSString *rwbhStr = [NSString stringWithFormat:@"%@%@?rwbh=%@",defaultWebServiceUrl,@"khqzck.do",self.m_showDict[@"RWBH"]];
        [self.signatureImgBtn sd_setImageWithURL:[NSURL URLWithString:rwbhStr] forState:UIControlStateNormal];
//    [self.signatureImgBtn sd_setImageWithURL:[NSURL URLWithString:@"http://192.168.10.169:8080/mbs/convey/khqzck.do?rwbh=5dce769b2f9e46a3b3a2c194f46eb80b"] forState:UIControlStateNormal];

}
-(void)SetUpData
{
    [self layoutMainCustomView];
    
    
    [self Add_RAC_Attention];
    
   [self loadInitDutyc];
    
    self.isOpen = NO;
    
}
-(void)updateLineConstraints:(UIButton *)button
{
 
    @weakify(self);
    [self.lineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(button.mas_leading);
        make.width.equalTo(@60);
        make.height.equalTo(@4);
        make.top.equalTo(self.menuBarView.mas_top).offset(2);
    }];
    [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        @strongify(self)
        [self.menuBarView layoutIfNeeded];
        
    }completion:NULL];
    
}
-(void)updateTestProgressBtnLineConstraints
{
     @weakify(self)
    [self.lineImgV mas_updateConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.leading.equalTo(self.view.mas_leading).offset(115);
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        @strongify(self)
        [self.view layoutIfNeeded];
        
    }completion:NULL];
    

    
}
-(void)updateSignatureBtnLineConstraints
{
    
    @weakify(self)
    [self.lineImgV mas_updateConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self)
        make.leading.equalTo(self.view.mas_leading).offset(191);
        
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        @strongify(self)
        [self.view layoutIfNeeded];
        
    }completion:NULL];
    
  
    
}

//TODO:需要修改成 修改界面的数据
/**
 *  获取 进入添加计划页面 的数据
 */
-(void)loadInitDutyc
{
    
    
    [[BaseNetWork getInstance]hideDialog];
    @weakify(self)
    [[[[[BaseNetWork getInstance] rac_postPath:@"initEditDutyc.do" parameters:@{@"rwbh":self.m_showDict[@"RWBH"]}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary  *retDict) {
         
         @strongify(self)
         if ([retDict[@"ret"] intValue] == 1) {
             
             
            [self update_Sbxq_ViewByDict:retDict[@"data"]];

            
         }else
         {
             [Dialog toastError:@"加载数据失败!"];
         }
         
         
         
         
     }error:^(NSError *error){
         
         
     }];
    
    
    /**
     *  获取检测进度数据
     */
    [[[[[BaseNetWork getInstance] rac_postPath:@"jcjds.do" parameters:@{@"rwbh":self.m_showDict[@"RWBH"]}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return [dict valueForKeyPath:@"data"];
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSArray  *jcjdArr) {
         
          @strongify(self)
         
         /**
          *  检测进度数据
          *
          *  @param
          *
          *  @return
          */
         self.m_jcjd_ModelArr = [jcjdArr linq_select:^id(NSDictionary *dict){
             
             jcjd_Model *model = [MTLJSONAdapter modelOfClass:[jcjd_Model class] fromJSONDictionary:dict error:nil];
  
             NSArray *myarr = dict[@"yqxx"];
             model.jcjdDetailArr =[myarr linq_select:^id(NSDictionary *dict){
                 
                 jcjd_Detail_Model *ryModel = [MTLJSONAdapter modelOfClass:[jcjd_Detail_Model class] fromJSONDictionary:dict error:nil];
                 
                 return ryModel;
             }];
             
             return model;
             
         }];
         
         [self.testProgressTableView reloadData];

         
         
         
     }error:^(NSError *error){
         
         
     }];
    
    
    /**
     *  客户签名
     *
     *  @param
     *
     *  @return
     */
    [[[[[BaseNetWork getInstance] rac_postPath:@"khqzrwxx.do" parameters:@{@"rwbh":self.m_showDict[@"RWBH"]}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return [dict valueForKeyPath:@"data"];
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary  *retDict) {
         
         @strongify(self)
//         NSArray *arr = retDict[@"wtd"];
         
         self.signatureDict = retDict[@"wtd"];
         
         [self updateSignatureViewDataWithShowDict:retDict];
         
         
         self.signatureArr = [self.signatureDict allKeys];
         
         [self.SignatureTableView reloadData];
     
//         self.m_jcjd_ModelArr = [jcjdArr linq_select:^id(NSDictionary *dict){
//             
//             jcjd_Model *model = [MTLJSONAdapter modelOfClass:[jcjd_Model class] fromJSONDictionary:dict error:nil];
//             
//             NSArray *myarr = dict[@"yqxx"];
//             model.jcjdDetailArr =[myarr linq_select:^id(NSDictionary *dict){
//                 
//                 jcjd_Detail_Model *ryModel = [MTLJSONAdapter modelOfClass:[jcjd_Detail_Model class] fromJSONDictionary:dict error:nil];
//                 
//                 return ryModel;
//             }];
//             
//             return model;
//             
//         }];
         
         [self.testProgressTableView reloadData];
         
         
         
         
     }error:^(NSError *error){
         
         
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
            self.m_dwdz_TF.text =[dict0 GetLabelWithKey:@"WTDWDZ"];
            self.m_yb_TF.text = [dict0 GetLabelWithKey:@"WTDWYB"] ;
            self.m_lxr_TF.text = [dict1 GetLabelWithKey:@"LXR"] ;
            self.m_lxdh_TF.text = [dict1 GetLabelWithKey:@"LXR"];
            self.m_dwmc_ATF.m_bm = [dict0 GetLabelWithKey:@"WTDWBM"];
            
            dqbhStr =  [dict0 GetLabelWithKey:@"SZDQ"];
            
        }else //否则说明arr[0] 是 联系人信息
        {
            self.m_dwmc_ATF.m_bm = [dict1 GetLabelWithKey:@"WTDWBM"];
            self.m_dwdz_TF.text = [dict1 GetLabelWithKey:@"WTDWDZ"];
            self.m_yb_TF.text = [dict1 GetLabelWithKey:@"WTDWYB"];
            self.m_lxr_TF.text = [dict0 GetLabelWithKey:@"LXR"];
            self.m_lxdh_TF.text = [dict0 GetLabelWithKey:@"LXDH"];
            
            dqbhStr = [dict1 GetLabelWithKey:@"SZDQ"];
        }
        
        
        
        @weakify(self)
        [[BaseNetWork getInstance] showDialog];
        NSDictionary *dict =@{@"dqbh":dqbhStr};
        [[[[[BaseNetWork getInstance] rac_postPath:@"findSzdq.do" parameters:dict]map:^(id responseData)
           {
               NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
               
               return [dict valueForKeyPath:@"szdq"];
           }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
         subscribeNext:^(NSArray *arr) {
             
             @strongify(self)
             self.m_szdq_DTF.text = arr[0][@"dqmc"];
             
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
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}
- (IBAction)cancleClick:(id)sender {
         
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}
- (IBAction)okClick:(id)sender {
    
     UIButton *okBtn = (UIButton *)sender;
    if (![self validateInputInView:self.planDetailsScrollView]){
        [self.m_showDialog WarningNotificationWithMessage:@"请补全信息!"];
        
    }else
    {
        
        [self save_Data];
        okBtn.enabled = NO;
        @weakify(self)
        [[BaseNetWork getInstance] showDialogWithVC:self];
        [[[[[BaseNetWork getInstance] rac_postPath:@"editDutyc.do" parameters:self.m_saveDataDict]map:^(id responseData)
           {
               NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
               
               return [dict valueForKeyPath:@"ret"];
           }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
         subscribeNext:^(NSString *isOK) {
             
             @strongify(self)
             
             if ([isOK integerValue] == 1) {
                 [Dialog toast:self withMessage:@"修改成功"];
             }else
             {
                 [Dialog toast:self withMessage:@"修改失败!"];
             }
             okBtn.enabled = YES;
         }error:^(NSError *error){
             okBtn.enabled = YES;
             debug_object(error);
             
             
         }];
        
        
    }
   
    
    
    
}


/**
 *  usercode
 WTDWBH VARCHAR2(10 CHAR) Y WTDWMCVARCHAR2(60 CHAR) Y DWDZ VARCHAR2(60 CHAR) Y
 LXRXM VARCHAR2(10 CHAR) Y LXDH VARCHAR2(15 CHAR) Y YWFZKSBH VARCHAR2(8 CHAR) YWFZKSVARCHAR2(10 CHAR) Y YWFZRBH VARCHAR2(14 CHAR)
 YWFZR VARCHAR2(10 CHAR) Y HYLBIDVARCHAR2(32 CHAR) Y
 Y Y
 当前用户编号
 委托单位编号
 委托单位名称
 单位地址
 联系人 联系电话
 业务负责科室编号
 业务负责科室
 业务负责人编号
 业务负责人 行业类别id
 已完成
 Y 行业类别名称 Y 所在地区编号 Y 所在地区
 邮编
 XCSJZ DATE Y 下场时间至
 RWWCQKVARCHAR2(1) Y 0 任务完成情况 0 未完成 1 是
 HYLBMCVARCHAR2(60 CHAR) SZDQBHVARCHAR2(32 CHAR) SZDQ VARCHAR2(20 CHAR)
 YB VARCHAR2(10 CHAR) Y
 QZRQ DATE Y 取证日期 KHTSYQVARCHAR2(60 CHAR) Y 客户特殊要求 BZ VARCHAR2(500 CHAR) Y 备注
 XCSJQ DATE Y 下场时间起
 XCFZR VARCHAR2(10 CHAR) Y XCFZRBH VARCHAR2(10 CHAR) Y xcksbhs 下厂科室组
 xcrybhs 下厂人员组
 下场负责人
 下场负责人编号
 */
-(void)save_Data
{

    
    
    
    //单位地址
    [self.m_saveDataDict setObject:[_m_dwdz_TF.text GetNotNullStr].length>0?[_m_dwdz_TF.text GetNotNullStr]:@"" forKey:@"DWDZ"];
    //联系人
    [self.m_saveDataDict setObject:[_m_lxr_TF.text GetNotNullStr].length>0?[_m_lxr_TF.text GetNotNullStr]:@"" forKey:@"LXRXM"];
    //联系电话
    [self.m_saveDataDict setObject:[_m_lxdh_TF.text GetNotNullStr].length>0?[_m_lxdh_TF.text GetNotNullStr]:@"" forKey:@"LXDH"];
    
    self.m_saveDataDict[@"WTDWMC"] = [self.m_dwmc_ATF.text GetNotNullStr].length>0 ?[self.m_dwmc_ATF.text GetNotNullStr]:@"";
    
    
    //邮编
    [self.m_saveDataDict setObject:[_m_yb_TF.text GetNotNullStr].length>0?[_m_yb_TF.text GetNotNullStr]:@"" forKey:@"YB"];
    
    // 将NSDate格式装换成NSString类型
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    // 设置日历显示格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    // 把日历时间传给字符串
    NSString *strQzrq = [dateFormatter stringFromDate:self.forensicsDateBtn.m_info[@"date"]];
    
    //取证日期 forensicsDateBtn
    [self.m_saveDataDict setObject:[strQzrq GetNotNullStr] forKey:@"QZRQ"];
    //客户特殊要求
    [self.m_saveDataDict setObject:[_m_tsyq_TF.text GetNotNullStr] forKey:@"KHTSYQ"];
    //备注
    [self.m_saveDataDict setObject:[_noteTF.text GetNotNullStr] forKey:@"BZ"];
    
    
    NSString *strXcsjq = [dateFormatter stringFromDate:self.fromDatePickerBtn.m_info[@"date"]];
    //下场时间起
    [self.m_saveDataDict setObject:[strXcsjq GetNotNullStr]forKey:@"XCSJQ"];
    
    NSString *strXcsjz = [dateFormatter stringFromDate:self.toDatePickerBtn.m_info[@"date"]];
    //下场时间至
    [self.m_saveDataDict setObject:[strXcsjz GetNotNullStr] forKey:@"XCSJZ"];
    
    
    
    //TODO:效率太低有待优化
    NSString *xcfzrStr = nil;
    NSString *xcfzrbhStr = nil;
    for(ks_Model *ksModel in self.m_ks_headArr)
    {
        if (ksModel.isSelected) {
            
            for( ry_Model *rymodel in ksModel.selected_RYArr)
            {
                xcfzrStr =  rymodel.username;
                xcfzrbhStr =  rymodel.usercode;
            }
        }
        
    }
    //下场负责人
    [self.m_saveDataDict setObject:[xcfzrStr GetNotNullStr] forKey:@"XCFZR"];
    //下场负责人编号
    [self.m_saveDataDict setObject:[xcfzrbhStr GetNotNullStr] forKey:@"XCFZRBH"];
    
    
    
    NSMutableArray *xcksArr = [[NSMutableArray alloc]init];
    NSMutableArray *xcryArr = [[NSMutableArray alloc]init];
    
    for(Wcjdjh_Xcks_Model *ksModel in self.m_ks_mansArr)
    {
        if ([ksModel.state intValue] == 1) {
            
            
            NSArray *ksryArr = ksModel.m_ksryArr;
            
            
            [xcksArr addObject:ksModel.comcode];
            
            for( Wcjdjh_ksry_Model *rymodel in ksryArr)
            {
                if ([rymodel.state intValue] == 1) {
                    [xcryArr addObject:rymodel.usercode];
                }
                
            }
        }
        
    }
    
    //下厂科室组
    [self.m_saveDataDict setObject:[xcksArr componentsJoinedByString:@","] forKey:@"xcksbhs"];
    //下厂人员组
    [self.m_saveDataDict setObject:[xcryArr componentsJoinedByString:@","] forKey:@"xcrybhs"];
}


#pragma mark - 代理协议方法*


#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    if (tableView == self.testProgressTableView)
    {
        return _m_jcjd_ModelArr.count;
    }else  if (tableView == self.SignatureTableView)
    {
        return _signatureArr.count;
    }else
    {
        return 1;
    }
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
    }else if (tableView == self.testProgressTableView)
    {
        if (self.isOpen) {
            if (self.selectIndex.section == section) {
                
                jcjd_Model *model = [_m_jcjd_ModelArr objectAtIndex:section];
                
                return [model.jcjdDetailArr count]+2;
            }
        }
        return 1;
        
    }else  if (tableView == self.SignatureTableView)
    {
        
        NSString *keyStr = _signatureArr[section];
        
        
        NSArray *arr = self.signatureDict[keyStr];

        return arr.count +1 ;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.SignatureTableView) {
        
        NSString *keyStr = _signatureArr[section];
    
        
        return [NSString stringWithFormat:@"委托单编号%@",keyStr];
    }else
        return @"";
    
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
    }else if(tableView == self.mansTableView )
    {
        cellIdentifier = @"Wcjdjh_Xcks_Cell";
        Wcjdjh_Xcks_Cell *cell = (Wcjdjh_Xcks_Cell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        cell.m_Xcks_CellDelegate = self;
        
        [cell configureCellWithItem:self.m_ks_mansArr[indexPath.row]];
        
        return cell;
    }else if (tableView == self.testProgressTableView)
    {
        
       
        if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0)
        {
            
            
            if (indexPath.row ==1) {
                
                /**
                 *  表头
                 */
                cellIdentifier = @"ProgressOverviewTitleCell";
                UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
                
           
                return cell;
                
                
            }else
            {
                cellIdentifier = @"TestProgressContentCell";
                TestProgressContentCell *cell = (TestProgressContentCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
                
                jcjd_Model *model = [_m_jcjd_ModelArr objectAtIndex:indexPath.section];
                
                //            return [[model.jcjdDetailArr count]+1];
                
                [cell configureCellWithItem:model.jcjdDetailArr[indexPath.row-2] andIndex:indexPath.row -1];
                
                return cell;
                
            }
      
            
//            NSArray *list = [[_dataList objectAtIndex:self.selectIndex.section] objectForKey:@"list"];
//            cell.titleLabel.text = [list objectAtIndex:indexPath.row-1];
//            return cell;
        }else
        {
            cellIdentifier = @"ProgressOverviewCell";
            ProgressOverviewCell *cell = (ProgressOverviewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            [cell changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
            [cell configureCellWithItem:self.m_jcjd_ModelArr[indexPath.section]];
            
            return cell;
        }

        
        
    }else if (tableView == self.SignatureTableView)
    {
        
        if (indexPath.row ==0) {
            
            /**
             *  表头
             */
            cellIdentifier = @"SignatureTitleCell";
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            return cell;
            
            
        }else
        {
            cellIdentifier = @"SignatureCell";
            SignatureCell *cell = (SignatureCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
           
            
            
            NSString *keyStr = _signatureArr[indexPath.section];
            
            
            NSArray *arr = self.signatureDict[keyStr];
            
    
            
            
            NSDictionary *myDict = arr[indexPath.row -1];
            
            
              wtdbh_Model *wtdbhModel = [MTLJSONAdapter modelOfClass:[wtdbh_Model class] fromJSONDictionary:myDict error:nil];

            
            [cell configureCellWithItem:wtdbhModel];
            
            return cell;
            
        }
        
    }
    
    return nil;
    
    
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
        Wcjdjh_Xcks_Model *model = self.m_ks_mansArr[indexPath.row];
        
        if ([model.state intValue] == 1) {
            model.state = @0;
        }else
        {
             model.state = @1;
        }
        
    }else if (tableView == self.testProgressTableView)
    {
        
        if (indexPath.row == 0)
        {
            
            
            if ([indexPath isEqual:self.selectIndex]) {
                self.isOpen = NO;
                [self didSelectCellRowFirstDo:NO nextDo:NO];
                self.selectIndex = nil;
                
            }else
            {
                if (!self.selectIndex) {
                    self.selectIndex = indexPath;
                    [self didSelectCellRowFirstDo:YES nextDo:NO];
                    
                }else
                {
                    
                    [self didSelectCellRowFirstDo:NO nextDo:YES];
                }
            }
            
        }
        else
        {
            /**
             *  选中详细列表行
             */
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    }
    
    
}

- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    
    ProgressOverviewCell *cell = (ProgressOverviewCell *)[self.testProgressTableView cellForRowAtIndexPath:self.selectIndex];
    [cell changeArrowWithUp:firstDoInsert];
    
    [self.testProgressTableView beginUpdates];
    
    int section = self.selectIndex.section;
    
     jcjd_Model *model = [_m_jcjd_ModelArr objectAtIndex:section];
    
    int contentCount = [model.jcjdDetailArr count] +1;
    
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    for (NSUInteger i = 1; i < contentCount + 1; i++) {
        NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
        [rowToInsert addObject:indexPathToInsert];
    }
    
    
    if (firstDoInsert)
    {   [self.testProgressTableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        [self.testProgressTableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
    
    [self.testProgressTableView endUpdates];
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = [self.testProgressTableView indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen) [self.testProgressTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.SignatureTableView) {
        return 35;
    }
    
    return 0;
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
    self.m_saveDataDict[@"WTDWBH"] = data.m_dict[@"WTDWBM"];
    self.m_saveDataDict[@"WTDWMC"] = data.m_dict[@"WTDWMC"];
    
    
    @weakify(self)
    [[BaseNetWork getInstance] showDialog];
    NSDictionary *dict =@{@"wtdwbm":data.m_dict[@"WTDWBM"]};
    [[[[[BaseNetWork getInstance] rac_postPath:@"getWtdwjbxx.do" parameters:dict]map:^(id responseData)
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
    
    if (textField == self.m_szdq_DTF) {
        return self.districtArr;
    }else if (textField == self.m_hylb_DTF) {
        return self.industryCategoriesArr;
    }else if (textField == self.m_ywfzks_DTF) {
        return self.responsibleDepArr;
    }else if (textField == self.m_ywfzr_DTF) {
        return self.headOFArr;
    }
    return nil;
}

#pragma mark - DropDownTextFieldDelegate
-(void)dropDownTextField:(DropDownTextField *)textField didSelectedWithData:(id<DropDownTextFieldShowCellTextLabel>) data forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (textField == self.m_szdq_DTF) {
        
        DistrictModel *districtModel = self.districtArr[indexPath.row];
        
        NSDictionary *dict = districtModel.m_data;
        
        
        self.m_saveDataDict[@"SZDQBH"] = [dict GetLabelWithKey:@"dqbh"];
        self.m_saveDataDict[@"SZDQ"] = [dict GetLabelWithKey:@"dqmc"];
        
        
    }else if (textField == self.m_hylb_DTF) {
        
        DistrictModel *districtModel = self.industryCategoriesArr[indexPath.row];
        
        NSDictionary *dict = districtModel.m_data;
        
        
        //行业类别id
        self.m_saveDataDict[@"HYLBID"] = [dict GetLabelWithKey:@"DMBM"];
        //行业类别名称
        self.m_saveDataDict[@"HYLBMC"] = [dict GetLabelWithKey:@"DMXXMC"];
        
        
        
    }else if (textField == self.m_ywfzks_DTF)
    {
        
        DistrictModel *districtModel = self.responsibleDepArr[indexPath.row];
        
        NSDictionary *dict = districtModel.m_data;
        
        //业务负责科室
        [self.m_saveDataDict setObject:[dict GetLabelWithKey:@"comcname"] forKey:@"YWFZKS"];
        //业务负责科室编号
        [self.m_saveDataDict setObject:[dict GetLabelWithKey:@"comcode"] forKey:@"YWFZKSBH"];
        
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
        
        
        
    }else if (textField == self.m_ywfzr_DTF) {
        
        DistrictModel *districtModel = self.headOFArr[indexPath.row];
        
        NSDictionary *dict = districtModel.m_data;
        //业务负责人
        [self.m_saveDataDict setObject:[dict GetLabelWithKey:@"username"] forKey:@"YWFZR"];
        //业务负责人编号
        [self.m_saveDataDict setObject:[dict GetLabelWithKey:@"usercode"] forKey:@"YWFZRBH"];
        
    }
    
    
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
    depManVC.view.superview.frame = CGRectMake(100, 400, 529, 279);//it's important to do this after presentModalViewController
    depManVC.view.superview.center = self.view.center;
    
    self.m_mans_depManVC = depManVC;
    
    /**
     *  将要修改的model赋值给vc然后再vc中修改
     */
    self.m_mans_depManVC.ksModel = ksModel;
}

#pragma mark -  Wcjdjh_Xcks_CellDelegate

-(void)Wcjdjh_Xcks_Cell:(Wcjdjh_Xcks_Cell*) depCell didSelectedWithks_Model:(Wcjdjh_Xcks_Model *) ksModel
{
//    Wcjdjh_Ksry_Vc
   
    Wcjdjh_Ksry_Vc *depManVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Wcjdjh_Ksry_Vc"];
    
    depManVC.m_delegate = self;
    depManVC.modalPresentationStyle = UIModalPresentationFormSheet;
    depManVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    depManVC.m_dataSourceArr = ksModel.m_ksryArr;
    
    [self presentViewController:depManVC animated:YES completion:nil];
    //    depManVC.view.superview.bounds = CGRectMake(0, 0, 529, 279);
    depManVC.view.superview.frame = CGRectMake(100, 400, 529, 279);//it's important to do this after presentModalViewController
    depManVC.view.superview.center = self.view.center;
    
    
    /**
     *  将要修改的model赋值给vc然后再vc中修改
     */
    depManVC.m_model = ksModel;
    
    
}



#pragma mark - DepManVCDelegate
-(void)DepManVC:(DepManViewController *)depManVC didSelectedArr:(NSArray *) selectedArr
{
    
    
}

#pragma mark - DepMansVCDelegate
-(void)DepMansVC:(DepMansViewController *)depManVC didSelectedArr:(NSArray *) selectedArr
{
    
}




//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView == _mainScrollView) {
//        
//        
//        if (scrollView.contentOffset.x < 0.0f) {
//            [self.mainScrollView setContentOffset:CGPointZero animated:NO];
//        }else if(scrollView.contentOffset.x > scrollView.frame.size.width)
//        {
//            
//            [scrollView setContentOffset:(CGPoint){self.view.frame.size.width,0} animated:NO];
//            //        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0
//            //) ;
//        }
//        
//        
//    }
//    
//    
//}
- (IBAction)SignatureClick:(id)sender {
    
    

    debug_object(@"sadfasdasdfasdfasdfasdfasfas");
    
    
    
    if ([_m_showDict[@"BY1"] isEqualToString:@"0"]) {
        
        SignatureViewController *signatureVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignatureViewController"];
    
        signatureVC.m_rwbh_Str = _m_showDict[@"RWBH"];
    
        signatureVC.m_delegate = self;
        signatureVC.modalPresentationStyle = UIModalPresentationFormSheet;
        signatureVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:signatureVC animated:YES completion:nil];
        //    depManVC.view.superview.bounds = CGRectMake(0, 0, 529, 279);
        signatureVC.view.superview.frame = CGRectMake(400, 800, 688, 410);//it's important to do this after presentModalViewController
        signatureVC.view.superview.center = self.view.center;
    }else
    {
        TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:[self.signatureImgBtn imageForState:UIControlStateNormal]];
        viewController.transitioningDelegate = self;
        
        self.m_popVC = [[UIPopoverController alloc] initWithContentViewController:viewController];
        //TODO:popoverLayoutMargins是指你的popover相对于整个window上下左右的margin
        self.m_popVC.popoverLayoutMargins = UIEdgeInsetsMake(20,0,0,0);
        
        //    self.m_popVC.popoverBackgroundViewClass = [BlackBackGroundV class];
        // 设定展示区域的大小
        // 从这个按钮点击的位置弹出，并且popVC的指向为这个按钮的中心。
        //    曾有段时间纠结于这个popVC的指向， 真是麻烦得很
        [self.m_popVC presentPopoverFromRect:self.view.bounds
                                      inView:self.view
                    permittedArrowDirections:0
                                    animated:YES];
    }

    
    

    
    
}

-(void)SignatureVC:(SignatureViewController*) signatureVC saveUpWithImage:(UIImage *) img
{
    
    [signatureVC dismissViewControllerAnimated:YES completion:^(void){
        
    }];
    
    [self.signatureImgBtn setBackgroundImage:img forState:UIControlStateNormal];
    
     [self.m_superView loadNetData];
    
}

#pragma  mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    DropDownTextField *myTextField = (DropDownTextField *)textField;
    
    if (myTextField == self.m_szdq_DTF) {
        
        return NO;
        
    }else if (myTextField == self.m_hylb_DTF) {
        
        return NO;
        
    }else if (myTextField == self.m_ywfzks_DTF)
    {
        
        return NO;
        
        
        
    }else if (textField == self.m_ywfzr_DTF) {
        
        return NO;
    }
    return YES;
}
#pragma mark - UIViewControllerTransitioningDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.signatureImgBtn.imageView];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.signatureImgBtn.imageView];
    }
    return nil;
}

//signatureImgBtn
@end
