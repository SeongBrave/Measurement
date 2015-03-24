//
//  MyPlanOverviewVc.m
//  Measurement
//
//  Created by DTSoft on 15/3/24.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "MyPlanOverviewVc.h"
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

@interface MyPlanOverviewVc ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,SignatureViewDelegate>

@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;


@property (weak, nonatomic) IBOutlet UIButton *testProgressBtn;
@property (weak, nonatomic) IBOutlet UIButton *signatureBtn;
@property (weak, nonatomic) IBOutlet UIButton *planBtn;


@property(nonatomic ,strong)UIImageView *lineImgV;



@property (weak, nonatomic) IBOutlet UIView *menuBarView;

/**
 * 计划详情
 */
@property (weak, nonatomic) IBOutlet UIScrollView *planDetailsScrollView;

/**
 *  单位名称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameOFEntityLB;

/**
 *  单位地址
 */
@property (weak, nonatomic) IBOutlet UILabel *addrOFEntityLB;
/**
 *  联系人
 */
@property (weak, nonatomic) IBOutlet UILabel *contactLB;

/**
 *  联系电话
 */
@property (weak, nonatomic) IBOutlet UILabel *ContactTELLB;

/**
 *  所在区
 */
@property (weak, nonatomic) IBOutlet UILabel *districtLB;

/**
 *  行业类别
 */
@property (weak, nonatomic) IBOutlet UILabel *IndustryCategoriesLB;

/**
 *  邮编
 */
@property (weak, nonatomic) IBOutlet UILabel *zipCodeLB;

/**
 *  业务负责科室
 */
@property (weak, nonatomic) IBOutlet UILabel *responsibleDepLB;

/**
 *  业务负责人
 */
@property (weak, nonatomic) IBOutlet UILabel *headOFLB;

/**
 *  取证日期
 */
@property (weak, nonatomic) IBOutlet UILabel *forensicsDateLB;


/**
 *  特殊要求
 */
@property (weak, nonatomic) IBOutlet UILabel *specialReqLB;

/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet UILabel *noteLB;

/**
 *  下厂时间
 */
@property (weak, nonatomic) IBOutlet UILabel *fromDatePickerLB;

/**
 *  下厂负责人
 */
@property (weak, nonatomic) IBOutlet UILabel *m_xcfzr_LB;

/**
 *  下厂科室人员列表
 */
@property (weak, nonatomic) IBOutlet UITableView *m_xcksry_tableView;
@property(nonatomic , strong)NSArray *m_xcry_Arr;


/**
 * 检测进度
 */
@property (weak, nonatomic) IBOutlet UIScrollView *testProgressScrollView;

@property (weak, nonatomic) IBOutlet UITableView *testProgressTableView;
@property(nonatomic , strong)NSArray *m_jcjd_ModelArr;

/**
 *  客户签字
 */


@property (weak, nonatomic) IBOutlet UIScrollView *signatureScrollView;
@property (weak, nonatomic) IBOutlet UITableView *SignatureTableView;

@property (weak, nonatomic) IBOutlet UIButton *signatureImgBtn;

@property(nonatomic , strong)NSArray *signatureArr;

@property(nonatomic , strong)NSDictionary *signatureDict;


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


/**
 *  主scrollview
 */
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;




@end

@implementation MyPlanOverviewVc

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
    
    self.nameOFEntityLB.text =  [showDict GetLabelWithKey:@"WTDWMC"];
    
    self.addrOFEntityLB.text = [showDict GetLabelWithKey:@"DWDZ"];
    
    self.contactLB.text =[showDict GetLabelWithKey:@"LXRXM"];
    
    
    self.ContactTELLB.text =[showDict GetLabelWithKey:@"LXDH"];
    
    self.districtLB.text =[showDict GetLabelWithKey:@"SZDQ"];
    
    
    self.IndustryCategoriesLB.text =[showDict GetLabelWithKey:@"HYLBMC"];
    
    self.zipCodeLB.text =[showDict GetLabelWithKey:@"YB"];
    
    
    self.responsibleDepLB.text = [showDict GetLabelWithKey:@"YWFZKS"];
    self.headOFLB.text =[showDict GetLabelWithKey:@"YWFZR"];
    
    self.forensicsDateLB.text =[showDict GetLabelWithKey:@"QZRQ"];
    
    
    self.specialReqLB.text = [showDict GetLabelWithKey:@"KHTSYQ"];
    
    self.noteLB.text = [showDict GetLabelWithKey:@"BZ"];
    
    self.fromDatePickerLB.text = [NSString stringWithFormat:@"%@至%@",[showDict GetLabelWithKey:@"XCSJQ"],[showDict GetLabelWithKey:@"XCSJQ"]];
    
    self.m_xcfzr_LB.text = [showDict GetLabelWithKey:@"XCFZR"];
    
    
    self.m_xcry_Arr = showDict[@"xcry"];
    
    [self.m_xcksry_tableView reloadData];
    
    
}
//TODO: 添加视图
-(void)layoutMainCustomView
{
    
    self.signatureImgBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.mainScrollView.delegate = self;
    
    
    self.m_xcksry_tableView.delegate = self;
    self.m_xcksry_tableView.dataSource = self;
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
    
    /**
     *  没有签名
     */
    if ([_m_showDict[@"BY1"] isNotNull]) {
        
        if ([_m_showDict[@"BY1"] isEqualToString:@"1"]) {
            NSString *rwbhStr = [NSString stringWithFormat:@"%@%@?rwbh=%@",defaultWebServiceUrl,@"khqzck.do",self.m_showDict[@"RWBH"]];
            [self.signatureImgBtn sd_setImageWithURL:[NSURL URLWithString:rwbhStr] forState:UIControlStateNormal];
            
        }
    }
    
    
    
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
    
    @weakify(self)
    /**
     *  获取检测进度数据
     */
    [[BaseNetWork getInstance] hideDialog];
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
    [[BaseNetWork getInstance] hideDialog];
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
         
         //         [self.testProgressTableView reloadData];
         
         
         
         
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
//-(void)updateWTDWWithData:(NSArray *) arr
//{
//    if (arr.count >=1) {
//
//        NSString *dqbhStr = nil;
//        NSDictionary *dict0 = [NSDictionary dictionaryWithDictionary:arr[0][0]];
//        NSDictionary *dict1 = [NSDictionary dictionaryWithDictionary:arr[1][0]];
//        if ([dict0 objectForKey:@"WTDWDZ"])
//        {
//
//            self.addrOFEntity.text = [dict0 GetLabelWithKey:@"SZDQ"];
//
//
//            self.addrOFEntity.text =[dict0 GetLabelWithKey:@"WTDWDZ"];
//            self.zipCodeTF.text = [dict0 GetLabelWithKey:@"WTDWYB"] ;
//            self.contactTF.text = [dict1 GetLabelWithKey:@"LXR"] ;
//            self.ContactTELTF.text = [dict1 GetLabelWithKey:@"LXR"];
//
//            dqbhStr =  [dict0 GetLabelWithKey:@"SZDQ"];
//
//        }else //否则说明arr[0] 是 联系人信息
//        {
//            self.addrOFEntity.text = [dict1 GetLabelWithKey:@"WTDWDZ"];
//            self.zipCodeTF.text = [dict1 GetLabelWithKey:@"WTDWYB"];
//            self.contactTF.text = [dict0 GetLabelWithKey:@"LXR"];
//            self.ContactTELTF.text = [dict0 GetLabelWithKey:@"LXDH"];
//
//            dqbhStr = [dict1 GetLabelWithKey:@"SZDQ"];
//        }
//
//
//
//        @weakify(self)
//        [[BaseNetWork getInstance] showDialog];
//        NSDictionary *dict =@{@"dqbh":dqbhStr};
//        [[[[[BaseNetWork getInstance] rac_postPath:@"findSzdq.do" parameters:dict]map:^(id responseData)
//           {
//               NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
//
//               return [dict valueForKeyPath:@"szdq"];
//           }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
//         subscribeNext:^(NSArray *arr) {
//
//             @strongify(self)
//             self.districtTF.text = arr[0][@"dqmc"];
//
//         }error:^(NSError *error){
//             //          @strongify(self)
//             ////          NSArray *arr = [self.m_store getObjectById:@"page.result" fromTable:self.m_tableName];
//             ////          self.m_DataSourceArr = arr;
//             ////          [_header endRefreshing];
//             ////          [_footer endRefreshing];
//             ////
//             ////          [self failedGetDataWithResponseData:arr];
//             //          //          [self.m_collectionView reloadData];
//
//
//         }];
//
//
//    }
//
//
//
//
//
//}
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
    
    NSString *strdwmc = self.nameOFEntityLB.text;
    
    LoginedUser *usr = [LoginedUser sharedInstance];
    
    
    @weakify(self)
    //    [[BaseNetWork getInstance] showDialogWithVC:self];
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
    if (tableView == self.m_xcksry_tableView)
    {
        return _m_xcry_Arr.count;
    }else if (tableView == self.testProgressTableView)
    {
        if (self.isOpen) {
            if (self.selectIndex.section == section) {
                
                jcjd_Model *model = [_m_jcjd_ModelArr objectAtIndex:section];
                
                return [model.jcjdDetailArr count]+2;
            }
        }
        return 1;
        
    }else
        if (tableView == self.SignatureTableView)
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
    if(tableView == self.m_xcksry_tableView)
    {
        cellIdentifier = @"ksryCell";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        NSDictionary *dict = _m_xcry_Arr[indexPath.row];
        
        NSString *xcryStr = [NSString stringWithFormat:@"%@,下厂人员为:%@",dict[@"XCKS"],dict[@"XCRY"]];
        
        //xcry
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.text = xcryStr;
        
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
                
                jcjd_Model *model = [_m_jcjd_ModelArr objectAtIndex:self.selectIndex.section];
                
                //            return [[model.jcjdDetailArr count]+1];
                
                //                [cell configureCellWithItem:model.jcjdDetailArr[indexPath.row-2]];
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
    if (tableView == self.testProgressTableView)
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

//
//#pragma mark - DepManVCDelegate
//-(void)DepManVC:(DepManViewController *)depManVC didSelectedArr:(NSArray *) selectedArr
//{
//
//
//}
//
//#pragma mark - DepMansVCDelegate
//-(void)DepMansVC:(DepMansViewController *)depManVC didSelectedArr:(NSArray *) selectedArr
//{
//
//}




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
    
    
    /**
     *  没有签名
     */
    
    if ([self.m_showDict[@"BY1"] isEqualToString:@"1"]) {
        
        TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:[self.signatureImgBtn imageForState:UIControlStateNormal]];
        //    viewController.transitioningDelegate = self;
        
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
        
    }else
    {
        
        SignatureViewController *signatureVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignatureViewController"];
        
        signatureVC.m_rwbh_Str = _m_showDict[@"RWBH"];
        
        signatureVC.m_delegate = self;
        signatureVC.modalPresentationStyle = UIModalPresentationFormSheet;
        signatureVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:signatureVC animated:YES completion:nil];
        //    depManVC.view.superview.bounds = CGRectMake(0, 0, 529, 279);
        signatureVC.view.superview.frame = CGRectMake(400, 800, 688, 410);//it's important to do this after presentModalViewController
        signatureVC.view.superview.center = self.view.center;
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}

#pragma mark - SignatureViewDelegate

-(void)SignatureVC:(SignatureViewController*) signatureVC saveUpWithImage:(UIImage *) img
{
    
    [signatureVC dismissViewControllerAnimated:YES completion:^(void){
        
    }];
    
    [self.signatureImgBtn setBackgroundImage:img forState:UIControlStateNormal];
    
    
    
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
