//
//  FactoryTaskDetailViewPopVC.m
//  Measurement
//
//  Created by DTSoft on 15/1/6.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "FactoryTaskDetailViewPopVC.h"
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
#import "sblb_Model.h"
#import "jcjd_Detail_Model.h"
#import "TestProgressContentCell.h"
#import "SignatureCell.h"
#import "SignatureViewController.h"
#import "BlackBackGroundV.h"
#import "AppDelegate.h"
#import "Sblb_TableViewCell.h"
#import "IPadScanViewController.h"
#import "backgroundV.h"
#import "TestingDataRegistViewController.h"
#import "wlqsb_Model.h"
#import "Wlqsb_TableViewCell.h"



#define MaxOffset  100

@interface FactoryTaskDetailViewPopVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate, UIScrollViewDelegate,AutoCompleteTextFieldDataSource,AutoCompleteTextFieldDelegate,DatePickerDelegate,DropDownTextFieldDataSource,DropDownTextFieldDelegate,PlanDetailsHead_DepCellDelegate,PlanDetailsMans_DepCellDelegate,DepManVCDelegate,DepMansVCDelegate,SignatureViewDelegate,IPadScanViewControllerDelegate,SWTableViewCellDelegate>


@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@property (weak, nonatomic) IBOutlet UITableView *m_detail_ksry_TableView;

@property(nonatomic , strong)NSArray *m_detail_ksry_Arr;


/**
 *  下厂科室人员
 */
@property(nonatomic , strong)NSArray *m_xcry_Arr;


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
@property (weak, nonatomic) IBOutlet UITableView *m_My_Sblb_TableView;

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


@property(nonatomic , strong)NSArray *m_Sblb_ModelArr;


@property(nonatomic , strong)ks_Model *selected_ks_headModel;

@property(nonatomic , strong)ks_Model *selected_ks_MansModel;



@property (weak, nonatomic) IBOutlet UITableView *SignatureTableView;

@property (weak, nonatomic) IBOutlet UIButton *signatureImgBtn;

@property(nonatomic , strong)NSArray *signatureArr;

@property(nonatomic , strong)NSDictionary *signatureDict;


@property (weak, nonatomic) IBOutlet UITableView *m_wlqsb_TableView;
@property(nonatomic , strong)NSArray *m_wlqsb_DataSourceArr;






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


@property (weak, nonatomic) IBOutlet UILabel *toDatePickerLB;

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
@implementation FactoryTaskDetailViewPopVC



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
    
     [self loadNetData];
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
    
    self.toDatePickerLB.text = [showDict GetLabelWithKey:@"XCFZR"];

    
    self.m_xcry_Arr = showDict[@"xcry"];
    
    [self.m_detail_ksry_TableView reloadData];
    
    
}
//TODO: 添加视图
-(void)layoutMainCustomView
{
    /**
     *  隐藏滚动条
     */
    self.m_detail_ksry_TableView.showsVerticalScrollIndicator = NO;
    
    /**
     *  隐藏分割线
     */
    self.m_detail_ksry_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.mainScrollView.delegate = self;

    
    /**
     *  设置tableview不可点击
     */
    self.SignatureTableView.allowsSelection=NO;
    //    self.m_My_Sblb_TableView.allowsSelection=NO;
    
    
    
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
    
    
    @weakify(self)
    [self.lineImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self)
        make.width.equalTo(@60);
        make.height.equalTo(@4);
        make.top.equalTo(self.menuBarView.mas_top).offset(2);
        make.leading.equalTo(self.planBtn.mas_leading);
        
        
    }];
    
    
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
           
                make.height.equalTo(@4);
                make.top.equalTo(self.menuBarView.mas_top).offset(2);
                switch (currentPage) {
                    case 0:
                        make.centerX.equalTo(self.planBtn.mas_centerX);
                        make.width.equalTo(@60);
//                        self.view.frame.size.height = 800;
                        break;
                    case 1:
                        make.centerX.equalTo(self.testProgressBtn.mas_centerX);
                        make.width.equalTo(@90);
                        break;
                        
                    case 2:
                        make.centerX.equalTo(self.signatureBtn.mas_centerX);
                        make.width.equalTo(@70);
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
     *  我的设备列表
     *
     *  @return m_Sblb_ModelArr
     */
    
    
    
}
-(void)SetUpData
{
    [self layoutMainCustomView];
    
    
    [self Add_RAC_Attention];
    
    
    self.isOpen = NO;
    
}

/**
 *  获取  的数据
 */
-(void)loadNetData
{

    LoginedUser *loginUsr = [LoginedUser sharedInstance];
    
    
    //    NSDictionary *dict = @{@"rwbh":[self.m_showDict GetLabelWithKey:@"RWBH"],@"usercode":loginUsr.usercode};
    
    
    /**
     *  我的设备列表
     */
    [[BaseNetWork getInstance] hideDialog];
    @weakify(self)
    [[[[[BaseNetWork getInstance] rac_postPath:@"findWdsblb.do" parameters:@{@"rwbh":[self.m_showDict GetLabelWithKey:@"RWBH"],@"usercode":loginUsr.usercode}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return [dict valueForKeyPath:@"data"];
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary  *retDict) {
         @strongify(self)
         
         NSArray *jcjdArr = retDict[@"sblb"];
         
         /**
          *  检测进度数据
          *
          *  @param
          *
          *  @return
          */
         self.m_Sblb_ModelArr = [jcjdArr linq_select:^id(NSDictionary *dict){
             
             
             sblb_Model *sblbmodel = [MTLJSONAdapter modelOfClass:[sblb_Model class] fromJSONDictionary:dict error:nil];
             
             
             return sblbmodel;
             
         }];
         
         [self.m_My_Sblb_TableView reloadData];
         
         
         
         
     }error:^(NSError *error){
         
         
     }];
    

    
//    [self.m_showDict GetLabelWithKey:@"RWBH"]
    [[BaseNetWork getInstance] hideDialog];
    /**
     *  获取检测进度数据
     */
    [[[[[BaseNetWork getInstance] rac_postPath:@"findShebei.do" parameters:@{@"rwbh":@"5dce769b2f9e46a3b3a2c194f46eb80b"}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return [dict valueForKeyPath:@"data"];
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSArray  *retArr) {
         @strongify(self)
         
         
         /**
          *  未领取设备
          *
          *  @param
          *
          *  @return
          */
         self.m_wlqsb_DataSourceArr = [retArr linq_select:^id(NSDictionary *dict){
             
             
             wlqsb_Model *sblbmodel = [MTLJSONAdapter modelOfClass:[wlqsb_Model class] fromJSONDictionary:dict error:nil];
             
             
             return sblbmodel;
             
         }];
         
         [self.m_wlqsb_TableView reloadData];
         
         
         
         
     }error:^(NSError *error){
         
         
     }];

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

- (IBAction)dismissClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
    
    
}
/*

@function:添加设备
* @param: *String rwbh
* @param: *String xtbs
* @param: *String usercode
* @param: String txm
* @param: String yqmc
* @param: String ksbh
* @param: String ks
* @param: String jltx *
* @param: String xmbh
* @param: String jcfw
* @param: String ggxh
 
 
* @param: String sccj
* @param: String ccbh *
* @param: String jclxbh
* @param: String jclx
* @param: String sl
* @param: String bzsf
 
* @param: String bzsfbh *
* @param: String wg
* @param: String pj
* @param: String bz
* @param: String jdzqbh
* @param: String by1
* @param: String by2
* @param: String sfsq *
* @return: json 1 成功/0 异常 * @author: yz
* @createtime: 2014-12-10
*/
/**
 *  添加设备
 *
 *  @param sender
 */
- (IBAction)Add_SB_Click:(id)sender {
    
    
    IPadScanViewController *popVc = (IPadScanViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"IPadScanViewController"];
       popVc.m_ScanDelegate = self;
    
    popVc.modalPresentationStyle = UIModalPresentationFormSheet;
    popVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:popVc animated:YES completion:nil];
    
}

/**
 *  进入设备列表
 *
 *  @param sender
 */
- (IBAction)In_SBLB_Click:(id)sender {
    
    @weakify(self);
    [self.lineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.testProgressBtn.mas_centerX);
        make.width.equalTo(@90);
        make.height.equalTo(@4);
        make.top.equalTo(self.menuBarView.mas_top).offset(2);
    }];
    [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        @strongify(self)
        [self.menuBarView layoutIfNeeded];
        
    }completion:NULL];
    
    [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width,0} animated:YES];
}


/**
 *  获取  的数据
 */
-(void)loadJiliangqjByTxm:(NSString *) txmStr
{
    @weakify(self)
    [[BaseNetWork getInstance] showDialogWithVC:self];
    NSDictionary *dict =@{@"txm":txmStr};
    [[[[[BaseNetWork getInstance] rac_postPath:@"findJiliangqjByTxm.do" parameters:dict]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary *retDict) {
         
         @strongify(self)
         
         if ([retDict[@"ret"] intValue] == 0) {
             
             NSDictionary *dict = @{@"txm":txmStr};
               [self ToTestingDataRegistViewControllerWithDict:dict AndDataSourceType:TxmNotDataSourceType];
             
         }else
         {
             [self ToTestingDataRegistViewControllerWithDict:retDict[@"qjxx"] AndDataSourceType:TxmDataSourceType];
         }
        
         
         
     }error:^(NSError *error){
         
         
         
     }];
    
    
    
}

-(void)ToTestingDataRegistViewControllerWithDict:(NSDictionary *) qjxxDict AndDataSourceType:(DataSourceType) dataSourceType
{
    TestingDataRegistViewController *popVc = (TestingDataRegistViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"TestingDataRegistViewController"];
    
    popVc.m_superView = self;
    
    popVc.m_qjxxDict = qjxxDict;
    popVc.m_dataSourceType = dataSourceType;
    popVc.m_showDict = self.m_showDict;
    popVc.modalPresentationStyle = UIModalPresentationFormSheet;
    popVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
     [self presentViewController:popVc animated:YES completion:nil];
    

}

#pragma mark - 代理协议方法*


#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    if (tableView == self.m_My_Sblb_TableView)
    {
        return 1;
    }else  if (tableView == self.SignatureTableView)
    {
        return _signatureArr.count;
    }else if (tableView == self.m_detail_ksry_TableView)
    {
        return 1;
    }else if(tableView == _m_wlqsb_TableView)
    {
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.m_My_Sblb_TableView)
    {
        return  _m_Sblb_ModelArr.count+1;
        
    }else  if (tableView == self.SignatureTableView)
    {
        
        NSString *keyStr = _signatureArr[section];
        
        
        NSArray *arr = self.signatureDict[keyStr];
        
        return arr.count +1 ;
    }else if (tableView == self.m_detail_ksry_TableView)
    {
        return _m_xcry_Arr.count;
    }else if(tableView == _m_wlqsb_TableView)
    {
        return _m_wlqsb_DataSourceArr.count +1;
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
    if (tableView == self.m_My_Sblb_TableView)
    {
        if (indexPath.row == 0) {
            
            cellIdentifier = @"Sblb_TableViewTitleCell";
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            return cell;
            
            
        }else
        {
            
            cellIdentifier = @"Sblb_TableViewCell";
            Sblb_TableViewCell *cell = (Sblb_TableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            sblb_Model *model = [_m_Sblb_ModelArr objectAtIndex:indexPath.row -1];
            cell.rightUtilityButtons = [self rightButtons];
            cell.delegate = self;

            [cell configureCellWithItem:model andIndex:indexPath.row];
            
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
            
            [cell configureCellWithItem:wtdbhModel andIndex:indexPath.row];
            
//            [cell configureCellWithItem:wtdbhModel];
            
            return cell;
            
        }
        
    }else if(tableView == self.m_detail_ksry_TableView)
    {
        cellIdentifier = @"ksryCell";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        NSDictionary *dict = _m_xcry_Arr[indexPath.row];
        
        NSString *xcryStr = [NSString stringWithFormat:@" %@ :%@",dict[@"XCKS"],dict[@"XCRY"]];
        
        //xcry
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.text = xcryStr;
        
        return cell;
        
    }else if(tableView == _m_wlqsb_TableView)
    {
        if (indexPath.row == 0) {
            
            cellIdentifier = @"Wlqsb_TableViewCellTitle";
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            return cell;
            
            
        }else
        {
            
            cellIdentifier = @"Wlqsb_TableViewCell";
            Wlqsb_TableViewCell *cell = (Wlqsb_TableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            wlqsb_Model *model = [_m_wlqsb_DataSourceArr objectAtIndex:indexPath.row -1];
            cell.rightUtilityButtons = [self rightButtons];
            cell.delegate = self;
            
            [cell configureCellWithItem:model andIndex:indexPath.row];
            
            return cell;
            
        }
    }
    
    return nil;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _m_My_Sblb_TableView)
    {
        if (indexPath.row == 0) {
            
        }else
        {
            
              sblb_Model *model = [self.m_Sblb_ModelArr objectAtIndex:indexPath.row -1];
            
            
            
    
            @weakify(self)
            [[BaseNetWork getInstance]hideDialog];
            NSDictionary *dict =@{@"yqid":model.yqid};
            [[[[[BaseNetWork getInstance] rac_postPath:@"findWtdxxxxByYqid.do" parameters:dict]map:^(id responseData)
               {
                   NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
                   
                   return [dict valueForKeyPath:@"qjxx"];
               }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
             subscribeNext:^(NSDictionary *retDict) {
                 
                 @strongify(self)
                 [self ToTestingDataRegistViewControllerWithDict:retDict AndDataSourceType:YqidDataSourceType];
                 
                 
             }error:^(NSError *error){
                 
                 
                 
             }];
            
            
            
            
        }
        
    
    }
    
}

//- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
//{
//    self.isOpen = firstDoInsert;
//    
//    ProgressOverviewCell *cell = (ProgressOverviewCell *)[self.m_My_Sblb_TableView cellForRowAtIndexPath:self.selectIndex];
//    [cell changeArrowWithUp:firstDoInsert];
//    
//    [self.m_My_Sblb_TableView beginUpdates];
//    
//    int section = self.selectIndex.section;
//    
//    sblb_Model *model = [_m_Sblb_ModelArr objectAtIndex:section];
//    
//    int contentCount = [model.jcjdDetailArr count] +1;
//    
//    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
//    for (NSUInteger i = 1; i < contentCount + 1; i++) {
//        NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
//        [rowToInsert addObject:indexPathToInsert];
//    }
//    
//    
//    if (firstDoInsert)
//    {   [self.m_My_Sblb_TableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
//    }
//    else
//    {
//        [self.m_My_Sblb_TableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
//    }
//    
//    
//    [self.m_My_Sblb_TableView endUpdates];
//    if (nextDoInsert) {
//        self.isOpen = YES;
//        self.selectIndex = [self.m_My_Sblb_TableView indexPathForSelectedRow];
//        [self didSelectCellRowFirstDo:YES nextDo:NO];
//    }
//    if (self.isOpen) [self.m_My_Sblb_TableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.SignatureTableView) {
        return 35;
    }
    
    return 0;
}

 //设置cell的行高
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return 50;
 }
 /*
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

-(void)SignatureVC:(SignatureViewController*) signatureVC saveUpWithImage:(UIImage *) img
{
    
    [signatureVC dismissViewControllerAnimated:YES completion:^(void){
        
    }];
    
    [self.signatureImgBtn setBackgroundImage:img forState:UIControlStateNormal];
    
    
    
}

#pragma mark -IPadScanViewControllerDelegate
-(void)IPadScanVC:(IPadScanViewController*) ipadScanVC DidScanViewWithStr:(NSString *) resultValue
{
   
   
    @weakify(self)
    [self dismissViewControllerAnimated:YES completion:^(void){
        @strongify(self)
        [self loadJiliangqjByTxm:resultValue];
        
    }];
   
    
}

-(void)IPadScanVC:(IPadScanViewController*) ipadScanVC DidCancleClick:(UIButton *) CancleBtn
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        

    }];
}

-(void)IPadScanVC:(IPadScanViewController*) ipadScanVC DidSkipClick:(UIButton *) skinBtn
{
//    MyPopTest

    @weakify(self)
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        @strongify(self)
        //模拟器测试
//          [self loadJiliangqjByTxm: @"140047018"];
        [self ToTestingDataRegistViewControllerWithDict:nil AndDataSourceType:NullDataSourceType];
        
    }];
    
   
    
}

-(void)delete_Wdsblb_RequestWithByYqid:(NSString *)yqid
{
    //delShebeiByYqid.do
    
    @weakify(self)
    [[BaseNetWork getInstance] showDialogWithVC:self];
    NSDictionary *dict =@{@"yqid":yqid};
    [[[[[BaseNetWork getInstance] rac_postPath:@"delShebeiByYqid.do" parameters:dict]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary *retDict) {
         
         @strongify(self)
         
         if ([retDict[@"ret"] intValue] == 0) {
             
             [Dialog toastError:@"删除失败!"];
             
         }else
         {
             [Dialog toastSuccess:@"删除成功!"];
             
             [self loadNetData];
         }
         
         
         
     }error:^(NSError *error){
         
         
         
     }];
    
}

-(void)reject_Wdsblb_RequestWithByYqid:(NSString *)yqid
{
    @weakify(self)
    [[BaseNetWork getInstance] showDialogWithVC:self];
    NSDictionary *dict =@{@"yqid":yqid};
    [[[[[BaseNetWork getInstance] rac_postPath:@"delShebeiByYqid.do" parameters:dict]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary *retDict) {
         
         @strongify(self)
         
         if ([retDict[@"ret"] intValue] == 0) {
             
             [Dialog toastError:@"驳回失败!"];
             
         }else
         {
             [Dialog toastSuccess:@"驳回成功!"];
             
             [self loadNetData];
         }
         
         
         
     }error:^(NSError *error){
         
         
         
     }];
}

-(void)delete_Wlqsb_RequestWithByYqid:(NSString *)yqid
{
    //delShebeiByYqid.do
    
    @weakify(self)
    [[BaseNetWork getInstance] showDialogWithVC:self];
    NSDictionary *dict =@{@"yqid":yqid};
    [[[[[BaseNetWork getInstance] rac_postPath:@"delShebeiByYqid.do" parameters:dict]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary *retDict) {
         
         @strongify(self)
         
         if ([retDict[@"ret"] intValue] == 0) {
             
             [Dialog toastError:@"删除失败!"];
             
         }else
         {
             [Dialog toastSuccess:@"删除成功!"];
             
             [self loadNetData];
         }
         
         
         
     }error:^(NSError *error){
         
         
         
     }];
    
}

-(void)reject_Wlqsb_RequestWithByYqid:(NSString *)yqid
{
    @weakify(self)
    [[BaseNetWork getInstance] showDialogWithVC:self];
    NSDictionary *dict =@{@"yqid":yqid};
    [[[[[BaseNetWork getInstance] rac_postPath:@"delShebeiByYqid.do" parameters:dict]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary *retDict) {
         
         @strongify(self)
         
         if ([retDict[@"ret"] intValue] == 0) {
             
             [Dialog toastError:@"删除失败!"];
             
         }else
         {
             [Dialog toastSuccess:@"删除成功!"];
             
             [self loadNetData];
         }
         
         
         
     }error:^(NSError *error){
         
         
         
     }];
}


-(NSMutableArray *)rightButtons
{
    NSMutableArray *leftUtilityButtons = [[NSMutableArray alloc]init];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:0.071 green:0.455 blue:0.550 alpha:1.000] title:@"驳回"];
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:0.750 green:0.336 blue:0.052 alpha:1.000] title:@"删除"];
    
    return leftUtilityButtons;
    
}

// TODO: SWTableViewCellDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            
            [Dialog toast:self withMessage:@"sadfsdaf"];
        }
            break;
        case 1:
        {
          
            [Dialog toast:self withMessage:@"asdf"];
            
        }
            break;
        case 2:
            NSLog(@"cross button was pressed");
            break;
        case 3:
            NSLog(@"list button was pressed");
        default:
            break;
    }
    
}



- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    
    switch (index) {
        case 0:
        {
            
          sblb_Model *model = [_m_Sblb_ModelArr objectAtIndex:index];
            
            [self reject_Wdsblb_RequestWithByYqid:model.yqid];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            sblb_Model *model = [_m_Sblb_ModelArr objectAtIndex:index];
            
            [self delete_Wdsblb_RequestWithByYqid:model.yqid];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        default:
            break;
    }
    
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    return YES;
}

@end
