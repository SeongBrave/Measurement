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


#define MaxOffset  100

@interface UpdatePlanDetailsPopVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate, UIScrollViewDelegate,AutoCompleteTextFieldDataSource,AutoCompleteTextFieldDelegate,DatePickerDelegate,DropDownTextFieldDataSource,DropDownTextFieldDelegate,PlanDetailsHead_DepCellDelegate,PlanDetailsMans_DepCellDelegate,DepManVCDelegate,DepMansVCDelegate,SignatureViewDelegate,UIViewControllerTransitioningDelegate>


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
@property (weak, nonatomic) IBOutlet UIView *forensicsDateView;
@property (weak, nonatomic) IBOutlet CustomButton *forensicsDateBtn;


/**
 *  特殊要求
 */
@property (weak, nonatomic) IBOutlet UITextField *specialReqTF;

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
    
    [self updateViewDataWithShowDict:_m_showDict];
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
    
    self.nameOFEntityTF.text =  [showDict GetLabelWithKey:@"WTDWMC"];
    
    self.addrOFEntity.text = [showDict GetLabelWithKey:@"DWDZ"];
    
    self.contactTF.text =[showDict GetLabelWithKey:@"LXDH"];
    
    
    self.ContactTELTF.text =[showDict GetLabelWithKey:@"LXDH"];
    
    self.districtTF.text =[showDict GetLabelWithKey:@"SZDQ"];
    
    
    self.IndustryCategoriesTF.text =[showDict GetLabelWithKey:@"HYLBMC"];
    
    self.zipCodeTF.text =[showDict GetLabelWithKey:@"YB"];
    
    
    self.responsibleDepTF.text = [showDict GetLabelWithKey:@"YWFZKS"];
    self.headOFTF.text =[showDict GetLabelWithKey:@"YWFZR"];
    
    [self.forensicsDateBtn setTitle:@"" forState:UIControlStateNormal];
    
    self.specialReqTF.text = [showDict GetLabelWithKey:@"tsyq"];
    
    self.noteTF.text = [showDict GetLabelWithKey:@"BZ"];
 
    [self.fromDatePickerBtn setTitle:[showDict GetLabelWithKey:@"XCSJQ"]forState:UIControlStateNormal];
    
    [self.toDatePickerBtn setTitle:[showDict GetLabelWithKey:@"XCSJQ"] forState:UIControlStateNormal];
    
    
//    CJSJ
    
    
    
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
    [[[[[BaseNetWork getInstance] rac_postPath:@"initDutyc.do" parameters:nil]map:^(id responseData)
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
         
             self.addrOFEntity.text = [dict0 GetLabelWithKey:@"SZDQ"];
            
            
            self.addrOFEntity.text =[dict0 GetLabelWithKey:@"WTDWDZ"];
            self.zipCodeTF.text = [dict0 GetLabelWithKey:@"WTDWYB"] ;
            self.contactTF.text = [dict1 GetLabelWithKey:@"LXR"] ;
            self.ContactTELTF.text = [dict1 GetLabelWithKey:@"LXR"];
            
            dqbhStr =  [dict0 GetLabelWithKey:@"SZDQ"];
            
        }else //否则说明arr[0] 是 联系人信息
        {
            self.addrOFEntity.text = [dict1 GetLabelWithKey:@"WTDWDZ"];
            self.zipCodeTF.text = [dict1 GetLabelWithKey:@"WTDWYB"];
            self.contactTF.text = [dict0 GetLabelWithKey:@"LXR"];
            self.ContactTELTF.text = [dict0 GetLabelWithKey:@"LXDH"];
            
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
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}
- (IBAction)cancleClick:(id)sender {
         
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}
- (IBAction)okClick:(id)sender {
    
    
    NSString *rwbhStr = self.m_showDict[@"RWBH"];
    
    NSString *strdwmc = self.nameOFEntityTF.text;
    
    LoginedUser *usr = [LoginedUser sharedInstance];
    
    
    @weakify(self)
    [[BaseNetWork getInstance] showDialogWithVC:self];
    NSDictionary *dict =@{@"rwbh":rwbhStr,@"wtdwmc":strdwmc,@"usercode":usr.usercode};
    [[[[[BaseNetWork getInstance] rac_postPath:@"editDutyToDwmc.do" parameters:dict]map:^(id responseData)
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
         
     }error:^(NSError *error){
         
         debug_object(error);
         
         
     }];

    
    
    
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
        cellIdentifier = @"PlanDetailsMans_DepCell";
        PlanDetailsMans_DepCell *cell = (PlanDetailsMans_DepCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        cell.m_mans_DepDelegate = self;
        
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
            [cell configureCellWithItem:self.m_jcjd_ModelArr[indexPath.row]];
            
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
        ks_Model *model = self.m_ks_mansArr[indexPath.row];
        
        model.isSelected = !model.isSelected;
        
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
    depManVC.view.superview.frame = CGRectMake(100, 400, 529, 279);//it's important to do this after presentModalViewController
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
    
    
    
}

#pragma  mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    DropDownTextField *myTextField = (DropDownTextField *)textField;
    
    if (myTextField == self.districtTF) {
        
        return NO;
        
    }else if (myTextField == self.IndustryCategoriesTF) {
        
        return NO;
        
    }else if (myTextField == self.responsibleDepTF)
    {
        
        return NO;
        
        
        
    }else if (textField == self.headOFTF) {
        
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
