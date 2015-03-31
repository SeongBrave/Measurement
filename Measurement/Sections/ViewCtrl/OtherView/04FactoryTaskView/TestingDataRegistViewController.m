//
//  TestingDataRegistViewController.m
//  Measurement
//
//  Created by DTSoft on 15/1/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "TestingDataRegistViewController.h"
#import "DropDownTextField.h"
#import "Jlbzkhzsh_TableViewCell.h"
#import "Bzqsb_TableViewCell.h"
#import "Jsyj_TableViewCell.h"
#import "FullScreenPreviewVC.h"
#import "AutoCompleteTextField.h"
#import "Yqmc_Auto_Model.h"
#import "Yqjbxx_Model.h"
#import "dmxx_Model.h"
#import "DatePickerViewController.h"
#import "pzr_Model.h"
#import "hyr_Model.h"
#import "jdzq_Model.h"
#import "WebViewJavascriptBridge.h"
#import "jlmb_Model.h"
#import "SBJson4Parser.h"
#import "ZS_TemplatesListViewController.h"
#import "YSJL_TemplatesListViewController.h"
#import "zsmb_Model.h"
#import "xmbh_Auto_Model.h"
#import "YSJL_HqsjVC.h"
#import "DemoTextField.h"
#import "UIPopoverListView.h"
@interface TestingDataRegistViewController ()<DropDownTextFieldDelegate,DropDownTextFieldDataSource,AutoCompleteTextFieldDataSource,AutoCompleteTextFieldDelegate,UITextFieldDelegate,DatePickerDelegate,ZS_TemplatesListVCDelegate,YSJL_TemplatesListVCDelegate,UIWebViewDelegate,DidSelectedValue_XCRY_Delegate,UIPopoverControllerDelegate,UIPopoverListViewDataSource,UIPopoverListViewDelegate>


/**
 *  表示当前所在的位置（0：设备详情 1:公共信息 2:原始记录 3:证书）
 */
@property(nonatomic , assign)NSInteger n_stept;

@property(nonatomic , assign)BOOL sbxq_Flag;
@property(nonatomic , assign)BOOL ggxx_Flag;
@property(nonatomic , assign)BOOL ysjl_Flag;
@property(nonatomic , assign)BOOL zs_Flag;


/**
 *  表示是否已经编辑  @1 便是编辑过 显示保存 @0未编辑过 button显示 已保存
 */
@property(nonatomic , strong)NSNumber *is_sbxq_Edited;

/**
 *  表示是否已经编辑  @1 便是编辑过 显示保存 @0未编辑过 button显示 已保存
 */
@property(nonatomic , strong)NSNumber *is_ggxx_Edited;

/**
 *  表示是否已经编辑  @1 便是编辑过 显示保存 @0未编辑过 button显示 已保存
 */
@property(nonatomic , strong)NSNumber *is_ysjl_Edited;

/**
 *  保存检定人员编号
 */
@property(nonatomic , strong)NSString *m_jdrybh_Str;

@property(nonatomic , strong)MBProgressHUD *m_hub;
@property(nonatomic , strong)RTSpinKitView *m_spinner;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property(nonatomic ,strong)UIImageView *lineImgV;

@property (weak, nonatomic) IBOutlet UIView *m_menuBarView;

@property(nonatomic , strong) FullScreenPreviewVC *m_fullScreenVc;

@property(nonatomic , strong)NSString *yqid_Str;

/**
 *  设备详情
 */
@property (weak, nonatomic) IBOutlet UIButton *m_sbxq_Btn;

@property (weak, nonatomic) IBOutlet DemoTextField *m_txm_TF;
@property (weak, nonatomic) IBOutlet AutoCompleteTextField *m_yqmc_TF;
@property(nonatomic , strong)NSArray *m_autoTFArr;

 //TODO:计量范围应该为 计量特性
@property (weak, nonatomic) IBOutlet DemoTextField *m_jlfw_TF;

@property (weak, nonatomic) IBOutlet DemoTextField *m_clfw_TF;

@property (weak, nonatomic) IBOutlet DemoTextField *m_ggxh_TF;

@property (weak, nonatomic) IBOutlet DemoTextField *m_sccj_TF;

@property (weak, nonatomic) IBOutlet DemoTextField *m_ccbh_TF;

@property (weak, nonatomic) IBOutlet DropDownTextField *m_jclx_DTF;
@property(nonatomic , strong)NSArray *m_jclxTFArr;


@property (weak, nonatomic) IBOutlet DemoTextField *m_sl_TF;

@property (weak, nonatomic) IBOutlet DropDownTextField *m_dw_DTF;
@property(nonatomic , strong)NSArray *m_dwTFArr;

@property (weak, nonatomic) IBOutlet DemoTextField *m_bj_TF;


@property (weak, nonatomic) IBOutlet DemoTextField *m_wg_TF;

//@property (weak, nonatomic) IBOutlet UITextField *m_xm_TF;
@property (weak, nonatomic) IBOutlet AutoCompleteTextField *m_xm_ADTF;
@property(nonatomic , strong)NSArray *m_xmAutoTFArr;

@property (weak, nonatomic) IBOutlet DemoTextField *m_fj_TF;

@property (weak, nonatomic) IBOutlet UITextField *m_txyq_TF;

@property (weak, nonatomic) IBOutlet UITextView *m_bz_TV;

@property (weak, nonatomic) IBOutlet UIScrollView *m_sbxq_ScrollView;

/**
 *  设备详情
 */
@property(nonatomic ,strong) NSDictionary *m_jcsj_Dict;

@property (weak, nonatomic) IBOutlet UIButton *sbxq_SaveBtn;

/**
 *  公共信息
 */
@property (weak, nonatomic) IBOutlet UIButton *ggxx_SaveBtn;

@property(nonatomic , strong)NSDictionary *m_jdy_Dict;

@property (weak, nonatomic) IBOutlet UIButton *m_ggxx_Btn;

@property (weak, nonatomic) IBOutlet UIScrollView *m_ggxx_ScrollView;

@property (weak, nonatomic) IBOutlet DropDownTextField *m_qjyt_DTF;
@property(nonatomic , strong)NSArray *m_qjytTFArr;


@property (weak, nonatomic) IBOutlet DropDownTextField *m_jdzq_DTF;
@property(nonatomic , strong)NSArray *m_jdzqTFArr;

@property (weak, nonatomic) IBOutlet DemoTextField *m_jddd_TF;
@property (weak, nonatomic) IBOutlet DemoTextField *m_hjwd_TF;

@property (weak, nonatomic) IBOutlet DemoTextField *m_xdsd_TF;


@property (weak, nonatomic) IBOutlet DemoTextField *m_qt_TF;

@property (weak, nonatomic) IBOutlet DemoTextField *m_jdy_TF;

@property (weak, nonatomic) IBOutlet DropDownTextField *m_hyy_DTF;
@property(nonatomic , strong)NSArray *m_hyyTFArr;

@property (weak, nonatomic) IBOutlet DropDownTextField *m_pzr_DTF;
@property(nonatomic , strong)NSArray *m_pzrTFArr;


@property (weak, nonatomic) IBOutlet DemoTextField *m_jszt_TF;



@property (weak, nonatomic) IBOutlet UIView *m_jdrq_V;

@property (weak, nonatomic) IBOutlet CustomButton *m_jdrq_Btn;


@property (weak, nonatomic) IBOutlet UITableView *m_jlbzkhzsh_TableView;
@property(nonatomic , strong)NSArray *m_jlbzkhzsh_Arr;

@property (weak, nonatomic) IBOutlet UITableView *m_bzqsb_TableView;
@property(nonatomic , strong)NSArray *m_bzqsb_Arr;

@property (weak, nonatomic) IBOutlet UITableView *m_jsyj_TableView;
@property(nonatomic , strong)NSArray *m_jsyj_Arr;

/**
 *  保存保存成功后返回的数据
 */
@property (strong, nonatomic) NSDictionary *m_ggxx_retDict;


/**
 *  原始记录
 */
@property (weak, nonatomic) IBOutlet UIButton *m_ysjl_Btn;

@property (weak, nonatomic) IBOutlet UIButton *ysjl_SaveBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *m_ysjl_ScrollView;

@property (weak, nonatomic) IBOutlet UIWebView *m_ysjl_WebView;
@property(nonatomic , strong)NSString *m_ysjl_saveUrl_Str;

@property (strong, nonatomic) WebViewJavascriptBridge *m_ysjl_javascriptBridge;

/**
 *  保存保存成功后返回的数据
 */
@property (strong, nonatomic) NSDictionary *m_ysjl_retDict;



/**
 *  证书
 */
@property (weak, nonatomic) IBOutlet UIButton *m_zs_Btn;

@property (weak, nonatomic) IBOutlet UIScrollView *m_zs_ScrollView;
@property (weak, nonatomic) IBOutlet UIWebView *m_zs_WebView;
@property(nonatomic , strong)NSString *m_zs_saveUrl_Str;
@property (strong, nonatomic) WebViewJavascriptBridge *m_zs_javascriptBridge;

@property(nonatomic , strong)NSDictionary *m_zs_retDict;


@end

@implementation TestingDataRegistViewController

#pragma mark - 系统方法

-(NSMutableDictionary *)m_Sbxq_saveDataDict
{
    if (_m_Sbxq_saveDataDict == nil) {
        _m_Sbxq_saveDataDict = [[NSMutableDictionary alloc]init];
        [self reset_Sbxq_SaveDict];
        
    }
    
    return _m_Sbxq_saveDataDict;
}

-(NSMutableDictionary *)m_Ggxx_saveDataDict
{
    if (_m_Ggxx_saveDataDict == nil) {
        _m_Ggxx_saveDataDict = [[NSMutableDictionary alloc]init];
        [self reset_Ggxx_SaveDict];
        
    }
    
    return _m_Ggxx_saveDataDict;
}

-(void)reset_Ggxx_SaveDict
{
    LoginedUser *user = [LoginedUser sharedInstance];
    
    _m_Ggxx_saveDataDict[@"usercode"] = user.usercode;
    
    _m_Ggxx_saveDataDict[@"yqid"] = @"";
    _m_Ggxx_saveDataDict[@"xmbh"] = self.m_Sbxq_saveDataDict[@"xmbh"];
    _m_Ggxx_saveDataDict[@"qjytbh"] = @"";
    _m_Ggxx_saveDataDict[@"jdrq"] = @"";
    
    _m_Ggxx_saveDataDict[@"jdzq"] = @"";
    _m_Ggxx_saveDataDict[@"jdzqbh"] = @"";
    _m_Ggxx_saveDataDict[@"hjwd"] = @"";
    _m_Ggxx_saveDataDict[@"hjsd"] = @"";
    _m_Ggxx_saveDataDict[@"jdrbh"] = @"";
    
    _m_Ggxx_saveDataDict[@"hyrbh"] = @"";
    _m_Ggxx_saveDataDict[@"pzrbh"] = @"";
    _m_Ggxx_saveDataDict[@"jddd"] = @"";
    _m_Ggxx_saveDataDict[@"jszt"] = @"";
    _m_Ggxx_saveDataDict[@"qt"] = @"";
    
    _m_Ggxx_saveDataDict[@"jlbzkhzsID"] = @"";
    _m_Ggxx_saveDataDict[@"bzsbbhs"] = @"";
    _m_Ggxx_saveDataDict[@"syzshs"] = @"";
    _m_Ggxx_saveDataDict[@"jsyjID"] = @"";

}

-(void)reset_Sbxq_SaveDict
{
    //TODO:界面显示信息
    _m_Sbxq_saveDataDict[@"txm"] = @"";
    _m_Sbxq_saveDataDict[@"yqmc"] = @"";
    _m_Sbxq_saveDataDict[@"jltx"] = @"";
    _m_Sbxq_saveDataDict[@"jcfw"] = @"";

    _m_Sbxq_saveDataDict[@"ggxh"] = @"";
    _m_Sbxq_saveDataDict[@"sccj"] = @"";
    _m_Sbxq_saveDataDict[@"ccbh"] = @"";
    _m_Sbxq_saveDataDict[@"jclx"] = @"";
    _m_Sbxq_saveDataDict[@"sl"] = @"";
    /**
     *  数量单位
     */
      _m_Sbxq_saveDataDict[@"by1"] = @"";
    
    /**
     *  报价
     */
     _m_Sbxq_saveDataDict[@"bzsf"] = @"";
    _m_Sbxq_saveDataDict[@"wg"] = @"";
    
    /**
     *  项目 未使用 （界面上唯一未使用的，因为使用了项目编号了）
     */
    
    /**
     *  附件
     */
     _m_Sbxq_saveDataDict[@"pj"] = @"";
    
      _m_Sbxq_saveDataDict[@"bz"] = @"";
    
    
    
    /**
     *  隐藏信息
     */
    LoginedUser *user = [LoginedUser sharedInstance];
    _m_Sbxq_saveDataDict[@"rwbh"] = @"";
    _m_Sbxq_saveDataDict[@"xtbs"] = MBS_XTBS;
    _m_Sbxq_saveDataDict[@"usercode"] = user.usercode;
    _m_Sbxq_saveDataDict[@"yqid"] = @"";
    _m_Sbxq_saveDataDict[@"ksbh"] = @"";
    _m_Sbxq_saveDataDict[@"ks"] = @"";
    /**
     *  项目编号
     */
    _m_Sbxq_saveDataDict[@"xmbh"] = @"";
    _m_Sbxq_saveDataDict[@"jclxbh"] = @"";
    /**
     *  报价 标准收费编号
     */
    _m_Sbxq_saveDataDict[@"bzsfbh"] = @"";
    _m_Sbxq_saveDataDict[@"jdzqbh"] = @"";
  
    /**
     *  数量单位编号
     */
    _m_Sbxq_saveDataDict[@"by2"] = @"";
    _m_Sbxq_saveDataDict[@"sfsq"] = @"";

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"JDRQ_DatePicker"] )
    {
        
        DatePickerViewController *datePickerVC = (DatePickerViewController*)[segue destinationViewController];
        datePickerVC.datePickerMode = UIDatePickerModeDateAndTime;
        
        NSDate * date = self.m_jdrq_Btn.m_info[@"date"];
        
        datePickerVC.m_date = date;
        datePickerVC.dateDelegate = self;
        datePickerVC.m_clickBtn = self.m_jdrq_Btn;
        
    }
    
    
}

#pragma mark - 自定义方法

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
    
    [self.m_txm_TF setRequired:YES];
    [self.m_sl_TF setRequired:YES];
    [self.m_yqmc_TF setRequired:YES];
    [self.m_jclx_DTF setRequired:YES];
    [self.m_dw_DTF setRequired:YES];
    [self.m_xm_ADTF setRequired:YES];
    [self.m_jclx_DTF setRequired:YES];
    [self.m_bj_TF setRequired:YES];
    

    [self.m_qjyt_DTF setRequired:YES];
    [self.m_jdzq_DTF setRequired:YES];
    [self.m_jddd_TF setRequired:YES];
    [self.m_hjwd_TF setRequired:YES];
    [self.m_xdsd_TF setRequired:YES];
    [self.m_qt_TF setRequired:YES];
    [self.m_pzr_DTF setRequired:YES];
    [self.m_jdy_TF setRequired:YES];
    [self.m_jdzq_DTF setRequired:YES];
    [self.m_hyy_DTF setRequired:YES];

    /**
     *  初始化标志状态
     */
    //初始化状态为 设备详情
    self.n_stept = 0;
    self.sbxq_Flag = NO;
     self.ggxx_Flag = NO;
     self.ysjl_Flag = NO;
     self.zs_Flag = NO;
    self.yqid_Str = nil;
    
    /**
     *  1表示编辑过 因为在这初始化界面默认编辑过，需要点击保存按钮，所以button显示保存
     */
    self.is_sbxq_Edited = @1;
    
    /**
     *  1表示编辑过 因为在这初始化界面默认编辑过，需要点击保存按钮，所以button显示保存
     */
    self.is_ggxx_Edited = @1;
    
    
    /**
     *  1表示编辑过 因为在这初始化界面默认编辑过，需要点击保存按钮，所以button显示保存
     */
    self.is_ysjl_Edited = @1;
    
    

    
    self.m_jdrq_V.layer.borderWidth = 2.0;
    self.m_jdrq_V.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
    self.m_qjyt_DTF.dropDownDelegate = self;
    self.m_qjyt_DTF.dropDownDataSource= self;
    self.m_qjyt_DTF.delegate = self;
    
    self.m_jdzq_DTF.dropDownDelegate = self;
    self.m_jdzq_DTF.dropDownDataSource= self;
    self.m_jdzq_DTF.delegate = self;

    
    self.m_jclx_DTF.dropDownDelegate = self;
    self.m_jclx_DTF.dropDownDataSource= self;
    self.m_jclx_DTF.delegate = self;

    self.m_dw_DTF.dropDownDelegate = self;
    self.m_dw_DTF.dropDownDataSource= self;
    self.m_dw_DTF.delegate = self;
    
    self.m_hyy_DTF.dropDownDelegate = self;
    self.m_hyy_DTF.dropDownDataSource= self;
    self.m_hyy_DTF.delegate = self;
    
    self.m_pzr_DTF.dropDownDelegate = self;
    self.m_pzr_DTF.dropDownDataSource= self;
    self.m_pzr_DTF.delegate = self;
    
 
    self.m_ysjl_WebView.delegate = self;
    self.m_zs_WebView.delegate = self;
    
    /**
     *  默认检定日期为当前时间
     */
    [self.m_jdrq_Btn.m_info setObject:[NSDate date] forKey:@"date"];
    
    
    self.lineImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"float-tab-bg_line"]];
    
    [self.m_menuBarView addSubview:_lineImgV];
    
    @weakify(self)
    [self.lineImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self)
        make.width.equalTo(@60);
        make.height.equalTo(@4);
        make.top.equalTo(self.m_menuBarView.mas_top).offset(2);
        make.leading.equalTo(self.m_sbxq_Btn.mas_leading);
        
    }];
    
    /**
     *  绘制分割线
     *
     */
    self.m_bz_TV.layer.borderWidth = 2.0;
    self.m_bz_TV.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
    
 
    self.m_ysjl_javascriptBridge = [WebViewJavascriptBridge bridgeForWebView:self.m_ysjl_WebView handler:^(id data, WVJBResponseCallback responseCallback) {
        
    }];
    
    self.m_zs_javascriptBridge = [WebViewJavascriptBridge bridgeForWebView:self.m_zs_WebView handler:^(id data, WVJBResponseCallback responseCallback) {
        
    }];

}

/**
 *  初始化设备详情界面
 */
-(void)layout_SbxqInterface
{
     self.n_stept = 0;
}
/**
 *  初始化公共信息界面
 */
-(void)layout_GgxxInterface
{
    self.n_stept = 1;
    
    if (!self.sbxq_Flag) {
        LoginedUser *loginUsr = [LoginedUser sharedInstance];
        @weakify(self)
        [[BaseNetWork getInstance] showDialogWithVC:self];
        NSDictionary *dict =@{@"usercode":loginUsr.usercode,@"yqid":self.yqid_Str};
        [[[[[BaseNetWork getInstance] rac_postPath:@"initDetectionDataRegistration.do" parameters:dict]map:^(id responseData)
           {
               NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
               
               return dict;
           }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
         subscribeNext:^(NSDictionary *retDict) {
             
             if ([retDict[@"ret"] isEqualToString:@"0"]) {
                 [Dialog toast:self withMessage:@"获取公共信息失败!"];
             }else
             {
                 @strongify(self)
                 [ self update_ggxxViewByYretDict:retDict];
             }
             
             
             
         }error:^(NSError *error){
             
             
             
         }];
    }
    
    self.sbxq_Flag = YES;
//    @weakify(self);
//    [self.lineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerX.equalTo(self.m_ggxx_Btn.mas_centerX);
//        make.width.equalTo(@60);
//        make.height.equalTo(@4);
//        make.top.equalTo(self.m_menuBarView.mas_top).offset(2);
//    }];
//    [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//        @strongify(self)
//        [self.m_menuBarView layoutIfNeeded];
//        
//    }completion:NULL];
//    
//    
//    [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width,0} animated:YES];
    
    
    
    
    
}
/**
 *  初始化原始记录界面
 */
-(void)layout_YsjlInterface
{
    self.n_stept = 2;
    
    if (!self.ggxx_Flag) {
        NSDictionary *dict = @{@"xmbh":self.m_Sbxq_saveDataDict[@"xmbh"],@"jclxbh":self.m_Sbxq_saveDataDict[@"jclxbh"]};
        [self PopYSJL_TemplatesListViewControllerWithZSretDict:dict];
    }
    
    self.ggxx_Flag = YES;
    
    
}
/**
 *  初始化证书界面
 */
-(void)layout_ZsInterface
{
    self.n_stept = 3;
    
    if (!self.ysjl_Flag) {
        [self PopZS_TemplatesListViewControllerWithZSretDict:self.m_ysjl_retDict];
    }
    self.ysjl_Flag = YES;
    
    
    
    
}
/**
 *  添加rac检测
 */
-(void)Add_RAC_Attention
{
    
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.showsHorizontalScrollIndicator = FALSE;
    @weakify(self)
    [RACObserve(self.mainScrollView, contentOffset) subscribeNext:^(NSValue *value) {
        
        @strongify(self);
        CGPoint offset = [value CGPointValue];
        
        switch (_n_stept) {
            case 0:
            {
                if (self.sbxq_Flag == NO&&self.yqid_Str == nil) {
                    
                     [self.mainScrollView setContentOffset:CGPointZero animated:NO];
                }
            }
                break;
            case 1:
            {
                
                if (self.ggxx_Flag == NO&&[_m_ggxx_retDict[@"ret"]intValue] != 1) {
                    if (offset.x < 0.0f) {
                        [self.mainScrollView setContentOffset:CGPointZero animated:NO];
                    }
                    else if (offset.x >= self.view.frame.size.width){
                        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*1,0} animated:NO];
                    }
                }
               
            }
                break;
            case 2:
            {
                
                if (self.ysjl_Flag == NO&&[self.m_ysjl_retDict[@"ret"]intValue] != 1) {
                    if (offset.x < 0.0f) {
                        [self.mainScrollView setContentOffset:CGPointZero animated:NO];
                    }
                    else if (offset.x >= self.view.frame.size.width*2){
                        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:NO];
                    }
                }
                
               
            }
                break;
            case 3:
            {
                if (offset.x < 0.0f) {
                    [self.mainScrollView setContentOffset:CGPointZero animated:NO];
                }
                else if (offset.x >= self.view.frame.size.width*3){
                    [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*3,0} animated:NO];
                }
            }
                break;
                
            default:
                break;
        }
        
        
       
        
    }];
    
    [[self rac_signalForSelector:@selector(scrollViewDidEndDecelerating:) fromProtocol:@protocol(UIScrollViewDelegate)] subscribeNext:^(RACTuple *x) {
        if (x.first == self.mainScrollView) {
            CGPoint offset = [x.first contentOffset];
            NSInteger currentPage = (NSInteger)roundf(offset.x / self.view.frame.size.width);
            @strongify(self)
            [self.lineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.height.equalTo(@4);
                make.top.equalTo(self.m_menuBarView.mas_top).offset(2);
                switch (currentPage) {
                    case 0:
                        make.centerX.equalTo(self.m_sbxq_Btn.mas_centerX);
                        make.width.equalTo(@60);
                       
                        [self layout_SbxqInterface];
                        //                        
                        break;
                    case 1:
                        make.centerX.equalTo(self.m_ggxx_Btn.mas_centerX);
                        make.width.equalTo(@60);
                         [self layout_GgxxInterface];
                        break;
                        
                    case 2:
                        make.centerX.equalTo(self.m_ysjl_Btn.mas_centerX);
                        make.width.equalTo(@60);
                      
                        [self layout_YsjlInterface];
                        break;
                        
                    case 3:
                        make.centerX.equalTo(self.m_zs_Btn.mas_centerX);
                        make.width.equalTo(@30);
                        
                        [self layout_ZsInterface];
                        break;
                        
                    default:
                        break;
                }
            }];
            [UIView animateWithDuration:0.25 animations:^{
                [self.m_menuBarView layoutIfNeeded];
            }];
        }
    }];
    
    
    /**
     *  设备详情
     *
     */
    [RACObserve(self.m_sbxq_ScrollView, contentOffset) subscribeNext:^(NSValue *value) {
        
        @strongify(self);
        CGPoint offset = [value CGPointValue];
        if (offset.x < 0.0f) {
            [self.mainScrollView setContentOffset:CGPointZero animated:NO];
        }
        else if (offset.x >= self.view.frame.size.width){
            [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width,0} animated:NO];
        }
        
    }];
    
    
    /**
     *  公共信息
     *
     */
    [RACObserve(self.m_zs_ScrollView, contentOffset) subscribeNext:^(NSValue *value) {
        
        @strongify(self);
        CGPoint offset = [value CGPointValue];
        if (offset.x < 0.0f) {
            [self.mainScrollView setContentOffset:CGPointZero animated:NO];
        }
        else if (offset.x >= self.view.frame.size.width){
            [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*3,0} animated:NO];
        }
        
    }];

//    [[self.m_sbxq_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
//        
//        @strongify(self)
//        [self updateLineConstraints:next];
//        
//        [self.mainScrollView setContentOffset:CGPointZero animated:YES];
//        
//    }];
//    
//    
//    [[self.m_ggxx_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
//        @strongify(self)
//        [self updateLineConstraints:next];
//        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width,0} animated:YES];
//        
//    }];
//    
//    [[self.m_ysjl_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
//        
//        @strongify(self)
//        [self updateLineConstraints:next];
////        [self PopYSJL_TemplatesListViewControllerWithZSretDict:nil];
//        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width,0} animated:YES];
//        
//    }];
//    
//    [[self.m_zs_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
//        
//        @strongify(self)
//        [self updateLineConstraints:next];
////        [self PopZS_TemplatesListViewControllerWithZSretDict:nil];
////        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*3,0} animated:YES];
//        
//    }];
    
    /**
     *  仪器名称模糊查询
     *
     *  @return
     */
    [[self.m_yqmc_TF.rac_textSignal
      throttle:0.5] subscribeNext:^(NSString *yqmcStr)
     {
         [[BaseNetWork getInstance] hideDialog];
         NSDictionary *dict =@{@"yqmc":yqmcStr,@"num":@"15"};
         [[[[[BaseNetWork getInstance] rac_postPath:@"getYqbj.do" parameters:dict]map:^(id responseData)
            {
                NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
                
                return [dict valueForKeyPath:@"yqxxList"];
            }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
          subscribeNext:^(NSArray *arr) {
              @strongify(self)
              
              self.m_autoTFArr = [arr linq_select:^id(NSDictionary *dict){
                  
                  Yqmc_Auto_Model *yqmcModel = [MTLJSONAdapter modelOfClass:[Yqmc_Auto_Model class] fromJSONDictionary:dict error:nil];
                  
                  
                  return yqmcModel;
              }];
              
              [self.m_yqmc_TF reloadData];
              
              
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
    
    /**
     *  项目模糊查询m_xm_ADTF
     */
    [[self.m_xm_ADTF.rac_textSignal
      throttle:0.5] subscribeNext:^(NSString *xmmcStr)
     {
         [[BaseNetWork getInstance] hideDialog];
         NSDictionary *dict =@{@"xmmc":xmmcStr,@"num":@"15"};
         [[[[[BaseNetWork getInstance] rac_postPath:@"findXmxx.do" parameters:dict]map:^(id responseData)
            {
                NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
                
                return dict;
            }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
          subscribeNext:^(NSDictionary *retDict) {
              @strongify(self)
              
              if ([retDict[@"ret"] intValue] ==0) {
                  
              }else
              {
                  NSArray *arr = retDict[@"xm"];
                  self.m_xmAutoTFArr = [arr linq_select:^id(NSDictionary *dict){
                      
                      xmbh_Auto_Model *yqmcModel = [MTLJSONAdapter modelOfClass:[xmbh_Auto_Model class] fromJSONDictionary:dict error:nil];
                      
                      
                      return yqmcModel;
                  }];
                  
                  [self.m_xm_ADTF reloadData];
                  
              }
        
              
              
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
    
    
    
    /**
     *  rac_prepareForReuseSignal 很关键 否则重用的时候会崩溃
     *
     */
//    RAC(self,sbxq_SaveBtn.selected) =
//    [RACObserve(self,is_sbxq_Edited)
//     map:^id(NSNumber *number)
//     {
//         return @0;
//         
//     }];
    
    [RACObserve(self,is_sbxq_Edited) subscribeNext:^(NSNumber *number){
       
        if (number.intValue == 0) {
             [self.sbxq_SaveBtn setBackgroundImage:[UIImage imageNamed:@"right-button-ybc.png"] forState:UIControlStateNormal];
            
        }else
        {
            [self.sbxq_SaveBtn setBackgroundImage:[UIImage imageNamed:@"right-button-bc.png"] forState:UIControlStateNormal];
        }
        
    }];
    
    [RACObserve(self,is_ggxx_Edited) subscribeNext:^(NSNumber *number){
        
        if (number.intValue == 0) {
            [self.ggxx_SaveBtn setImage:[UIImage imageNamed:@"right-button-ybc.png"] forState:UIControlStateNormal];
            
        }else
        {
            [self.ggxx_SaveBtn setImage:[UIImage imageNamed:@"right-button-bc.png"] forState:UIControlStateNormal];
            
        }
        
    }];
    
    [RACObserve(self,is_ysjl_Edited) subscribeNext:^(NSNumber *number){
        
        if (number.intValue == 0) {
            [self.ysjl_SaveBtn setBackgroundImage:[UIImage imageNamed:@"right-button-ybc.png"] forState:UIControlStateNormal];
            
        }else
        {
            [self.ysjl_SaveBtn setBackgroundImage:[UIImage imageNamed:@"right-button-bc.png"] forState:UIControlStateNormal];
        }
        
    }];

    
//    /**
//     *  获取单位名称
//     */
//    [[BaseNetWork getInstance] hideDialog];
//    [[[[[BaseNetWork getInstance] rac_postPath:@"findDmxx.do" parameters:@{@"zdbm":@"dw"}]map:^(id responseData)
//       {
//           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
//           
//           return dict;
//       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
//     subscribeNext:^(NSDictionary *retDict) {
//         @strongify(self)
//         
//         if ([retDict[@"ret"] intValue] ==0) {
//             
//         }else
//         {
//             NSArray *arr = retDict[@"dmxxList"];
//             self.m_autoTFArr = [arr linq_select:^id(NSDictionary *dict){
//                 
//                 Yqmc_Auto_Model *yqmcModel = [MTLJSONAdapter modelOfClass:[Yqmc_Auto_Model class] fromJSONDictionary:dict error:nil];
//                 
//                 
//                 return yqmcModel;
//             }];
//             
//             [self.m_yqmc_TF reloadData];
//             
//         }
//
//         
//         
//     }error:^(NSError *error){
//         //          @strongify(self)
//         ////          NSArray *arr = [self.m_store getObjectById:@"page.result" fromTable:self.m_tableName];
//         ////          self.m_DataSourceArr = arr;
//         ////          [_header endRefreshing];
//         ////          [_footer endRefreshing];
//         ////
//         ////          [self failedGetDataWithResponseData:arr];
//         //          //          [self.m_collectionView reloadData];
//         
//         
//     }];

    /**
     *  获取单位数据
     */
    [[BaseNetWork getInstance] hideDialog];
    [[[[[BaseNetWork getInstance] rac_postPath:@"findDmxx.do" parameters:@{@"zdbm":@"dw"}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary *retDict) {
         @strongify(self)
         
         if ([retDict[@"ret"] intValue] ==0) {
             
         }else
         {
             
             NSArray *arr = retDict[@"dmxxList"] ;
             self.m_dwTFArr = [arr linq_select:^id(NSDictionary *dict){
                 
                 dmxx_Model *dmxxModel = [MTLJSONAdapter modelOfClass:[dmxx_Model class] fromJSONDictionary:dict error:nil];
                 
                 
                 return dmxxModel;
             }];
             
//             
//             [self.m_dw_DTF reloadData];
             
         }
     
         
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
    
    

    
    /**
     *  获取检测类型
     */
    [[BaseNetWork getInstance] hideDialog];
    [[[[[BaseNetWork getInstance] rac_postPath:@"findDmxx.do" parameters:@{@"zdbm":@"jclx"}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict[@"dmxxList"];
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSArray *arr) {
         @strongify(self)
         
         self.m_jclxTFArr = [arr linq_select:^id(NSDictionary *dict){
             
             dmxx_Model *dmxxModel = [MTLJSONAdapter modelOfClass:[dmxx_Model class] fromJSONDictionary:dict error:nil];
             
             
             return dmxxModel;
         }];
         
         
//         [self.m_jclx_DTF reloadData];
         
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
    
    
    /**
     *  获取器具用途
     */
    [[BaseNetWork getInstance] hideDialog];
    [[[[[BaseNetWork getInstance] rac_postPath:@"findDmxx.do" parameters:@{@"zdbm":@"qjyt"}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict[@"dmxxList"];
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSArray *arr) {
         @strongify(self)
         
         self.m_qjytTFArr = [arr linq_select:^id(NSDictionary *dict){
             
             dmxx_Model *dmxxModel = [MTLJSONAdapter modelOfClass:[dmxx_Model class] fromJSONDictionary:dict error:nil];
             
             
             return dmxxModel;
         }];
         
         
         
         
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
    


    
//    [self.m_ysjl_WebView showPlaceHolderWithLineColor:[UIColor purpleColor]];
    
}

-(void)updateLineConstraints:(UIButton *)button
{
    
    @weakify(self);
    [self.lineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button.mas_centerX);
        make.width.equalTo(button.mas_width);
        make.height.equalTo(@4);
        make.top.equalTo(self.m_menuBarView.mas_top).offset(2);
    }];
    [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        @strongify(self)
        [self.m_menuBarView layoutIfNeeded];
        
    }completion:NULL];
    
}

-(void)update_yczd
{
    /**
     *  隐藏信息
     */
    LoginedUser *user = [LoginedUser sharedInstance];
    self.m_Sbxq_saveDataDict[@"rwbh"] = [self.m_showDict GetLabelWithKey:@"RWBH"];
    self.m_Sbxq_saveDataDict[@"xtbs"] = MBS_XTBS;
    self.m_Sbxq_saveDataDict[@"usercode"] = user.usercode;

    


//    /**
//     *  报价 标准收费编号
//     */
//    self.m_Sbxq_saveDataDict[@"bzsfbh"] = [sbxqDict GetLabelWithKey:@"bzsfbh"];
//    self.m_Sbxq_saveDataDict[@"jdzqbh"] = [sbxqDict GetLabelWithKey:@"jdzqbh"];
//    
//    /**
//     *  数量单位编号
//     */
//    self.m_Sbxq_saveDataDict[@"by2"] = [sbxqDict GetLabelWithKey:@"dwbh"];
//    self.m_Sbxq_saveDataDict[@"sfsq"] = [sbxqDict GetLabelWithKey:@"by1"];

}
/**
 *  更新设备详情界面
 *  TODO:需要把dwbh 改成by2
 *  by2  数量单位编号  ,    findJiliangqjByTxm.do : dwbh
 *
 */
-(void)update_sbxqViewByTxmDict:(NSDictionary *) sbxqDict
{
    //TODO:测试需要
//    [self test_SbxqV];
    
    self.m_txm_TF.text =  [sbxqDict GetLabelWithKey:@"txm"];
    self.m_yqmc_TF.text =  [sbxqDict GetLabelWithKey:@"yqmc"];
    
//    // TODO: **注意意思这块是通过 findJiliangqjByTxm.do 扫描条码获取到得 ，需要把dwbh 改成by2
//    self.m_yqmc_TF.m_bm = [sbxqDict GetLabelWithKey:@"yqid"];
    
    //TODO:需修改字段 计量特性
    self.m_jlfw_TF.text =  [sbxqDict GetLabelWithKey:@"jltx"];
    
    //TODO:需修改字段
    self.m_clfw_TF.text =  [sbxqDict GetLabelWithKey:@"jcfw"];
    
    self.m_ggxh_TF.text =  [sbxqDict GetLabelWithKey:@"ggxh"];
    
    self.m_sccj_TF.text =  [sbxqDict GetLabelWithKey:@"sccj"];
    self.m_ccbh_TF.text =  [sbxqDict GetLabelWithKey:@"ccbh"];
    //通过条形码得到数据 by4 是指的检测类型
    self.m_jclx_DTF.text =  [sbxqDict GetLabelWithKey:@"by4"];
    
    self.m_sl_TF.text =  [[sbxqDict GetLabelWithKey:@"sl"] isNotNull]?@"1":[sbxqDict GetLabelWithKey:@"sl"];
    self.m_dw_DTF.text =  [sbxqDict GetLabelWithKey:@"by5"];

    
    self.m_bj_TF.text =  [sbxqDict GetLabelWithKey:@"bj"];
    self.m_wg_TF.text =  [sbxqDict GetLabelWithKey:@"wg"];
    self.m_xm_ADTF.text =  [sbxqDict GetLabelWithKey:@"xmmc"];
    self.m_fj_TF.text =  [sbxqDict GetLabelWithKey:@"pj"];
    self.m_bz_TV.text =  [sbxqDict GetLabelWithKey:@"bz"];
    
    
    /**
     *  隐藏信息
     */
    LoginedUser *user = [LoginedUser sharedInstance];
    self.m_Sbxq_saveDataDict[@"rwbh"] = [self.m_showDict GetLabelWithKey:@"RWBH"];
    self.m_Sbxq_saveDataDict[@"xtbs"] = MBS_XTBS;
    self.m_Sbxq_saveDataDict[@"usercode"] = user.usercode;
    self.m_Sbxq_saveDataDict[@"yqid"] = [sbxqDict GetLabelWithKey:@"yqid"];
    
    self.m_Sbxq_saveDataDict[@"ks"] = [sbxqDict GetLabelWithKey:@"by3"];
    
    
    self.m_Sbxq_saveDataDict[@"ksbh"] = [sbxqDict GetLabelWithKey:@"ksbh"];
    
    /**
     *  项目编号
     */
    self.m_Sbxq_saveDataDict[@"xmbh"] = [sbxqDict GetLabelWithKey:@"xmbh"];
    self.m_Sbxq_saveDataDict[@"jclxbh"] =[sbxqDict GetLabelWithKey:@"jclxbh"];
    /**
     *  报价 标准收费编号
     */
    self.m_Sbxq_saveDataDict[@"bzsfbh"] = [sbxqDict GetLabelWithKey:@"bzsfbh"];
    
    
    if ([sbxqDict GetLabelWithKey:@"jdzqbh"] != nil) {
        
         self.m_Sbxq_saveDataDict[@"jdzqbh"] = [sbxqDict GetLabelWithKey:@"jdzqbh"];
    }
   
    
    /**
     *  数量单位编号
     */
    self.m_Sbxq_saveDataDict[@"by2"] = [sbxqDict GetLabelWithKey:@"dwbh"];
    self.m_Sbxq_saveDataDict[@"sfsq"] = [sbxqDict GetLabelWithKey:@"by1"];
    
}
/**
 *  更新设备详情界面
 *  TODO:需要把dwbh 改成by2
 *  by2  数量单位编号  ,    findJiliangqjByTxm.do : dwbh
 *
 */
-(void)update_sbxqViewByYqidDict:(NSDictionary *) sbxqDict
{
    
    //TODO:测试需要
//    [self test_SbxqV];
    
     self.m_txm_TF.text =  [sbxqDict GetLabelWithKey:@"txm"];
    self.m_yqmc_TF.text =  [sbxqDict GetLabelWithKey:@"yqmc"];
    

    
     //TODO:需修改字段 计量特性
    self.m_jlfw_TF.text =  [sbxqDict GetLabelWithKey:@"jltx"];
    

    self.m_jclx_DTF.text =  [sbxqDict GetLabelWithKey:@"jclx"];
    
    //TODO:需修改字段
    self.m_clfw_TF.text =  [sbxqDict GetLabelWithKey:@"jcfw"];
    
    
    self.m_ggxh_TF.text =  [sbxqDict GetLabelWithKey:@"ggxh"];
    
    self.m_sccj_TF.text =  [sbxqDict GetLabelWithKey:@"sccj"];
    self.m_ccbh_TF.text =  [sbxqDict GetLabelWithKey:@"ccbh"];

    
    self.m_sl_TF.text =  [[sbxqDict GetLabelWithKey:@"sl"] isNotNull]?[sbxqDict GetLabelWithKey:@"sl"]:@"1";
    self.m_dw_DTF.text =  [sbxqDict GetLabelWithKey:@"by1"];

    
    self.m_bj_TF.text =  [sbxqDict GetLabelWithKey:@"bzsf"];
    self.m_wg_TF.text =  [sbxqDict GetLabelWithKey:@"wg"];
    self.m_xm_ADTF.text =  [sbxqDict GetLabelWithKey:@"xmmc"];
    self.m_fj_TF.text =  [sbxqDict GetLabelWithKey:@"pj"];
    
    self.m_bz_TV.text =  [sbxqDict GetLabelWithKey:@"bz"];

    
    
    /**
     *  隐藏信息
     */
    LoginedUser *user = [LoginedUser sharedInstance];
    self.m_Sbxq_saveDataDict[@"rwbh"] = [self.m_showDict GetLabelWithKey:@"RWBH"];
    self.m_Sbxq_saveDataDict[@"xtbs"] = MBS_XTBS;
    self.m_Sbxq_saveDataDict[@"usercode"] = user.usercode;
    self.m_Sbxq_saveDataDict[@"yqid"] = [sbxqDict GetLabelWithKey:@"yqid"];
    
    self.yqid_Str = [sbxqDict GetLabelWithKey:@"yqid"];
    
    if (self.yqid_Str.length >0) {
        /**
         *  0为显示 已保存
         */
        self.is_sbxq_Edited = @0;
    }else
    {
        /**
         *  1表示编辑过 因为在这初始化界面默认编辑过，需要点击保存按钮，所以button显示保存
         */
        self.is_sbxq_Edited = @1;
    }
    
    self.is_ggxx_Edited = @1;
    
    self.is_ysjl_Edited = @1;
    
    
    
    
    self.m_Sbxq_saveDataDict[@"ks"] = [sbxqDict GetLabelWithKey:@"ks"];
    
    self.m_Sbxq_saveDataDict[@"ksbh"] = [sbxqDict GetLabelWithKey:@"ksbh"];
    
    /**
     *  项目编号
     */
    

    self.m_Sbxq_saveDataDict[@"xmbh"] = [sbxqDict GetLabelWithKey:@"xmbh"];
    self.m_Sbxq_saveDataDict[@"jclxbh"] = [sbxqDict GetLabelWithKey:@"jclxbh"];
    /**
     *  报价 标准收费编号
     */
    self.m_Sbxq_saveDataDict[@"bzsfbh"] = [sbxqDict GetLabelWithKey:@"bzsfbh"];
    self.m_Sbxq_saveDataDict[@"jdzqbh"] = [sbxqDict GetLabelWithKey:@"jdzqbh"];
    
    /**
     *  数量单位编号
     */
    self.m_Sbxq_saveDataDict[@"by2"] = [sbxqDict GetLabelWithKey:@"by2"];
    
    self.m_Sbxq_saveDataDict[@"sfsq"] = [sbxqDict GetLabelWithKey:@"sfsq"];
}

/**
 *  更新设备详情界面
 *
 */
-(void)update_sbxqViewByYqjbxx_Model:(Yqjbxx_Model *) sbxqDict
{
   
    /**
     *  1表示编辑过 因为在这初始化界面默认编辑过，需要点击保存按钮，所以button显示保存
     */
    self.is_sbxq_Edited = @1;
    
    self.is_ggxx_Edited = @1;
    
    self.is_ysjl_Edited = @1;
    
//    _m_Sbxq_saveDataDict[@"jdzqbh"] = sbxqDict.by5.length>0?sbxqDict.by5:@"";
//    _m_Sbxq_saveDataDict[@"ksbh"] =sbxqDict.ssksbh.length>0?sbxqDict.ssksbh:@"";
//    _m_Sbxq_saveDataDict[@"ks"] =sbxqDict.ssks.length>0?sbxqDict.ssks:@"";
    
    
    if (sbxqDict.by5 != nil) {
         self.m_Sbxq_saveDataDict[@"jdzqbh"] = [sbxqDict.by5 GetNotNullStr];
    }
    
    if ([sbxqDict.ssksbh GetNotNullStr] != nil) {
         self.m_Sbxq_saveDataDict[@"ksbh"] =[sbxqDict.ssksbh GetNotNullStr];
    }
   
    if ([sbxqDict.ssks GetNotNullStr] != nil) {
        self.m_Sbxq_saveDataDict[@"ks"] =[sbxqDict.ssks GetNotNullStr];
    }
   
    
     self.m_Sbxq_saveDataDict[@"by2"] =[sbxqDict.dwbh GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"xmbh"] =[sbxqDict.xmbh GetNotNullStr];
    
    self.m_Sbxq_saveDataDict[@"jclxbh"] = [sbxqDict.jclxbh GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"sfsq"] = [sbxqDict.sfsq GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"bzsf"] = [sbxqDict.bj GetNotNullStr];
    /**
     *  一定要注意
     */
    self.m_Sbxq_saveDataDict[@"bzsfbh"] = [sbxqDict.sfbzid GetNotNullStr];
    
    
    self.m_yqmc_TF.text =  [sbxqDict.jlqjmc GetNotNullStr];
    //TODO:需修改字段
    self.m_jlfw_TF.text =  [sbxqDict.jltx GetNotNullStr];
    //TODO:计量范围应该为 计量特性
    self.m_clfw_TF.text =  [sbxqDict.clfw GetNotNullStr];
    
    self.m_ggxh_TF.text =  [sbxqDict.ggxh GetNotNullStr];
    
    //TODO:需修改字段
    self.m_jclx_DTF.text =  [sbxqDict.jclx GetNotNullStr];

    self.m_dw_DTF.text =  [sbxqDict.dw GetNotNullStr];
    
    self.m_bj_TF.text =  [sbxqDict.bj GetNotNullStr];
    
    //TODO:需要要求添加 项目字段代替
    self.m_xm_ADTF.text =  [sbxqDict.xmmc GetNotNullStr];
    
}


-(void)test_SbxqV
{
    self.m_sl_TF.text = @"2";
    self.m_bj_TF.text = @"223";
    self.m_xm_ADTF.text = @"sfad";
    self.m_fj_TF.text = @"233";
    self.m_txyq_TF.text = @"233";
    
    
}

-(void)test_GgxxV
{
    self.m_jddd_TF.text = @"sadf";
    self.m_hjwd_TF.text = @"23";
    self.m_xdsd_TF.text = @"sfad";
    self.m_qt_TF.text = @"233";
    
    
}
/**
 *  更新公共信息界面
 *
 */
-(void)update_ggxxViewByYretDict:(NSDictionary *) retDict
{
    
//    NSString *qjytbhStr = retDict[@"yqxx"][@"qjytbh"];
//    self.m_Ggxx_saveDataDict[@"qjytbh"] =qjytbhStr.length >0?qjytbhStr:@"";

    //TODO:测试需要的
//    [self test_GgxxV];
    /**
     *  检定日期
     */
    // 设置日历显示格式
    
    
    // 把日历时间传给字符串
    
   
    // 2012-05-17 11:23:23
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *wtrqStr =[retDict GetLabelWithKey:@"wtrq"] ;
    NSDate *fromdate=[format dateFromString:wtrqStr];

 
    
    [self.m_jdrq_Btn.m_info setObject:fromdate ==nil?[NSDate new]:fromdate forKey:@"date"];
     NSString *strDate = [format stringFromDate:fromdate ==nil?[NSDate new]:fromdate ];
    [self.m_jdrq_Btn setTitle:strDate forState:UIControlStateNormal];
    
    /**
     *  注:默认检定人,不可修改
     */
    NSDictionary *hyrDict = retDict[@"hyrmap"];
    
//    
//    if ([hyrDict allKeys].count >0) {
//        
//      self.m_jdy_TF.text =[hyrDict GetLabelWithKey:[hyrDict allKeys][0]];
//        self.m_jdrybh_Str = [hyrDict allKeys][0];
//        
//    }else
//    {
//        self.m_jdy_TF.text = @"";
//    }
    
    
    NSDictionary *jdrDict = retDict[@"jdrmap"];
    if ([jdrDict allKeys].count >0) {
        
        self.m_jdy_TF.text =[jdrDict GetLabelWithKey:[jdrDict allKeys][0]];
        self.m_jdrybh_Str = [jdrDict allKeys][0];
        
    }else
    {
        self.m_jdy_TF.text = @"";
    }
    
    
    
    

    self.m_jdy_Dict = jdrDict;
    
    NSString *jdzqStr = [retDict[@"yqxx"] GetLabelWithKey:@"jdzqbh"];
    
    
    NSArray *jdzqArr = retDict[@"jdzqList"];
 
    
    self.m_jdzqTFArr = [jdzqArr linq_select:^id(NSDictionary *dict){
        
        jdzq_Model *dmxxModel = [MTLJSONAdapter modelOfClass:[jdzq_Model class] fromJSONDictionary:dict error:nil];

        return dmxxModel;
    }];
    

    for(jdzq_Model *model in self.m_jdzqTFArr)
    {
        if ([jdzqStr isEqualToString:model.dmbm] )
        {

            self.m_jdzq_DTF.text = model.dmxxmc;
            self.m_jdzq_DTF.m_bm = model.dmbm;
            
            self.m_Ggxx_saveDataDict[@"jdzqbh"] = [model.dmbm GetNotNullStr];

        }
    }
  
    /**
     *  hyrmap 注:核验人
     */
    // NSDictionary *hyrDict = retDict[@"hyrmap"];
    
    NSMutableArray *hyrList = [[NSMutableArray alloc]init];
    for(NSString *strKey  in hyrDict.allKeys)
    {
        hyr_Model *hyrModel = [[hyr_Model alloc]init];
        hyrModel.m_key = strKey;
        hyrModel.m_value = hyrDict[strKey];
        [hyrList addObject:hyrModel];
    }
    
    self.m_hyyTFArr = hyrList ;

    
    
    /**
     *  hyrmap 注:批准人
     */
    NSArray *pzrArr = retDict[@"pzrList"];
    
    self.m_pzrTFArr = [pzrArr linq_select:^id(NSDictionary *dict){
        
        pzr_Model *pzrModel = [MTLJSONAdapter modelOfClass:[pzr_Model class] fromJSONDictionary:dict error:nil];
        
        return pzrModel;
    }];
    

    
    
    
    
    NSArray *jlbzkhzshArr = retDict[@"jlbzkhzsLists"];
    NSArray *bzqsbArr = retDict[@"bzqsbLists"];
    
    NSArray *jsyjArr = retDict[@"jsyjLists"];
    
    self.m_jlbzkhzsh_Arr = [jlbzkhzshArr
                            linq_select:^id(NSDictionary *dict)
                            {
                                
                                Jlbzkhzsh_Model *model = [MTLJSONAdapter modelOfClass:[Jlbzkhzsh_Model class] fromJSONDictionary:dict error:nil];
                                model.isSelected = YES;
                                
                                return model;
                            }];
    
    self.m_bzqsb_Arr = [bzqsbArr
                        linq_select:^id(NSDictionary *dict)
                        {
                            
                            Bzqsb_Model *model = [MTLJSONAdapter modelOfClass:[Bzqsb_Model class] fromJSONDictionary:dict error:nil];
                            model.isSelected = YES;
                            return model;
                        }];
    
    self.m_jsyj_Arr = [jsyjArr
                       linq_select:^id(NSDictionary *dict)
                       {
                           
                           Jsyj_Model *model = [MTLJSONAdapter modelOfClass:[Jsyj_Model class] fromJSONDictionary:dict error:nil];
                           model.isSelected = YES;
                           
                           return model;
                       }];
    
    
  

    
    [self.m_jlbzkhzsh_TableView reloadData];
    [self.m_bzqsb_TableView reloadData];
    [self.m_jsyj_TableView reloadData];

}

//layoutMainCustomView
-(void)PopZS_TemplatesListViewControllerWithZSretDict:(NSDictionary *)retDict{
    ZS_TemplatesListViewController *tempLasteVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ZS_TemplatesListViewController"];
    tempLasteVC.m_delegate = self;
    /**
     *  保存需要请求获取的参数
     */
    tempLasteVC.m_zsParameterDict = @{@"yqid":_yqid_Str};
    tempLasteVC.modalPresentationStyle = UIModalPresentationFormSheet;
    tempLasteVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:tempLasteVC animated:YES completion:nil];
    
}
-(void)PopYSJL_TemplatesListViewControllerWithZSretDict:(NSDictionary *)retDict{
    YSJL_TemplatesListViewController *tempLasteVC = [self.storyboard instantiateViewControllerWithIdentifier:@"YSJL_TemplatesListViewController"];
    tempLasteVC.m_ysjlParameterDict = retDict;
    tempLasteVC.m_delegate = self;
    tempLasteVC.modalPresentationStyle = UIModalPresentationFormSheet;
    tempLasteVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:tempLasteVC animated:YES completion:nil];
    
}

/**
 *  获取  的数据
 */
-(void)loadNetData
{
   
    switch (_m_dataSourceType) {
        case TxmDataSourceType:
        {
            [self update_sbxqViewByTxmDict:_m_qjxxDict];
        }
            
            break;
        case TxmNotDataSourceType:
        {
            
            /**
             *  设置隐藏参数
             */
            [self update_yczd];
            /**
             *  扫描条形码未得到数据时 将扫描到得条形码赋值到界面
             */
            self.m_txm_TF.text =  [_m_qjxxDict GetLabelWithKey:@"txm"];
        }
            
            break;
        case YqidDataSourceType:
        {
            [self update_sbxqViewByYqidDict:_m_qjxxDict];
            
        }
            
            break;
        case NullDataSourceType:
        {
            /**
             *  设置隐藏参数
             */
            [self update_yczd];
        }
            
            break;
            
        default:
            break;
    }
    

    
   
    
    

    
}
- (IBAction)BackToVC:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:^(void){
       
        [self.m_superView  loadNetData];
    }];
}





/**
 *  设备详情底部按钮事件
 *
 *  @param sender
 */

- (IBAction)Sbxq_SaveBtnClick:(id)sender {
    
    //TODO:需要把dwbh 改成by2
    //by2  数量单位编号  ,    findJiliangqjByTxm.do : dwbh
    //wtdwbh 委托单位编号
    
    //项目编号 : xmbh
    /**
     *  项目 : 模糊查询
     */
    // SSKSBH -> ksbh  科室编号 SSKS ->ks
    //JLQJMC ->仪器名称
    
    //JLQJBH ->计量器具名称编号
    
    if (![self validateInputInView:self.m_sbxq_ScrollView]){
//        [Dialog alert:@"请补全信息!"];
        
        [self.m_showDialog WarningNotificationWithMessage:@"请补全信息!"];
        
    }else
    {
        
        UIButton *saveBtn = (UIButton *)sender;
        
        [self save_Sbxq_Data];
        
        @weakify(self)
        [[BaseNetWork getInstance] hideDialog];
        [[[[[BaseNetWork getInstance] rac_postPath:@"addEquipment.do" parameters:_m_Sbxq_saveDataDict]map:^(id responseData)
           {
               
               
               NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
               return dict;
           }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
         subscribeNext:^(NSDictionary *retDict) {
             @strongify(self)
             if ([retDict[@"ret"] intValue] == 1) {
                 
                 self.yqid_Str = retDict[@"yqid"];
                 self.m_Sbxq_saveDataDict[@"yqid"] = self.yqid_Str;
                [Dialog toastSuccess:@"保存成功！"];
//                  [self.m_showDialog SuccessNotificationWithMessage:@"保存成功！"];
                 /**
                  *  1为显示 保存
                  */
                 self.is_sbxq_Edited = @1;
                 
                 //              [saveBtn setImage:[UIImage imageNamed:@"right-button-ybc"] forState:UIControlStateNormal];
                 
                 [saveBtn setBackgroundImage:[UIImage imageNamed:@"right-button-ybc.png"] forState:UIControlStateNormal];
             }else
             {
                 [Dialog toastError:@"保存失败！"];
//                  [self.m_showDialog ErrorNotificationWithMessage:@"保存失败！"];
             }
             
             
             
         }error:^(NSError *error){
             
             
             
         }];

        
    }

   
}

- (IBAction)Sbxq_CancleBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        [self.m_superView  loadNetData];
    }];

}



- (IBAction)Sbxq_NextStepBtnClick:(id)sender {
    
    
    if ([_yqid_Str isNotNull])
    {
        
        
        @weakify(self);
        [self.lineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.m_ggxx_Btn.mas_centerX);
            make.width.equalTo(@60);
            make.height.equalTo(@4);
            make.top.equalTo(self.m_menuBarView.mas_top).offset(2);
        }];
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            @strongify(self)
            [self.m_menuBarView layoutIfNeeded];
            
        }completion:NULL];
        
        
        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width,0} animated:YES];
        
        
        LoginedUser *loginUsr = [LoginedUser sharedInstance];
        
        [[BaseNetWork getInstance] showDialogWithVC:self];
        NSDictionary *dict =@{@"usercode":loginUsr.usercode,@"yqid":self.yqid_Str};
        [[[[[BaseNetWork getInstance] rac_postPath:@"initDetectionDataRegistration.do" parameters:dict]map:^(id responseData)
           {
               NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
               
               return dict;
           }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
         subscribeNext:^(NSDictionary *retDict) {
             
             if ([retDict[@"ret"] isEqualToString:@"0"]) {
                 [Dialog toast:self withMessage:@"获取公共信息失败!"];
             }else
             {
                 @strongify(self)
                 [ self update_ggxxViewByYretDict:retDict];
             }
             
             
             
         }error:^(NSError *error){
             
             
             
         }];

        
    }else
    {
        [Dialog toast:self withMessage:@"没有仪器id!"];
    }
   
    
    
}


/**
 *  公共信息 底部按钮事件
 *
 *  @param sender
 */
- (IBAction)Ggxx_SaveBtnClick:(id)sender {
    
    //TODO: 每次选择日期就更新 三个 tableview  默认选中 ，取消
    
    
    
    /**
     * @function: 保存 检测数据 公共信息 --单证
     * @param1: *Strng usercode * @param2: *Strng yqid
     * @param3: *Strng xmbh
     * @param4: *Strng qjytbh
     * @param5: *Strng jdrq HH:mm)
     *
     * @param6: *Strng jdzq
     * @param7: *Strng jdzqbh
     * @param8: *Strng hjwd
     * @param9: *Strng hjsd
     * @param10: *Strng jdrbh *
     * @param11: *Strng hyrbh
     * @param12: *Strng pzrbh
     * @param13: *Strng jddd
     * @param14: *Strng jszt
     * @param15: *Strng qt *
     * @param16: *Strng jlbzkhzsID
     分隔)
     * @param17: *Strng bzsbbhs
     个按","分隔)
     * @param18: *Strng syzshs
     按","分隔)
     * @param19: *Strng jsyjID *
     * @return: json
     * @author: yz
     * @createtime: 2014-12-25
    当前用户账号 仪器yqid 项目编号
    器具用途编号 检定日期(格式:yyyy-MM-dd
                检定周期 检定周期编号
                环境温度 环境湿度
                检定人编号
                核验人编号
                批准人编号
                检定地点
                接收状态
                其它 计量标准考核证书ID(多个按","
                              标准器设备--标准设备编号(多 标准器设备--溯源证书号(多个 技术依据ID(多个按","分隔)
    */
    
    debug_object(self.m_Ggxx_saveDataDict);
    
    
    
    if (![self validateInputInView:self.m_ggxx_ScrollView]){
        [self.m_showDialog WarningNotificationWithMessage:@"请补全信息!"];
        
    }else
    {
    
        UIButton *saveBtn = (UIButton *)sender;
        [self save_ggxx_Data];
        
        @weakify(self)
        [[BaseNetWork getInstance] hideDialog];
        [[[[[BaseNetWork getInstance] rac_postPath:@"saveDdrTojson.do" parameters:_m_Ggxx_saveDataDict]map:^(id responseData)
           {
               
               @strongify(self)
               NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
               /**
                *  保存公共信息返回的数据，点击下一步用
                */
               self.m_ggxx_retDict = dict;
               return [dict valueForKeyPath:@"ret"];
           }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
         subscribeNext:^(NSString *retStr) {
             
             if ([retStr intValue] == 1) {
               [Dialog toastSuccess:@"保存成功！"];
//                 [self.m_showDialog SuccessNotificationWithMessage:@"保存成功！"];
                 /**
                  *  1为显示 保存
                  */
                 self.is_ggxx_Edited = @1;
                 
                 [saveBtn setImage:[UIImage imageNamed:@"right-button-ybc"] forState:UIControlStateNormal];
             }else
             {
                 [Dialog toastError:@"保存失败！"];
//                 [self.m_showDialog ErrorNotificationWithMessage:@"保存失败！"];
             }
             
             
             
         }error:^(NSError *error){
             
             
             
         }];

        
    }
    
}

- (IBAction)Ggxx_CancleBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        @weakify(self);
        [self.lineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.m_ysjl_Btn.mas_centerX);
            make.width.equalTo(@60);
            make.height.equalTo(@4);
            make.top.equalTo(self.m_menuBarView.mas_top).offset(2);
        }];
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            @strongify(self)
            [self.m_menuBarView layoutIfNeeded];
            
        }completion:NULL];
        
        
        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:YES];

    }];

}

- (IBAction)Ggxx_NextStepBtnClick:(id)sender {
    
    
    
    if ([_m_ggxx_retDict[@"ret"]intValue] == 1)
    {
        
        
        @weakify(self);
        [self.lineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.m_ysjl_Btn.mas_centerX);
            make.width.equalTo(@60);
            make.height.equalTo(@4);
            make.top.equalTo(self.m_menuBarView.mas_top).offset(2);
        }];
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            @strongify(self)
            [self.m_menuBarView layoutIfNeeded];
            
        }completion:NULL];
        
        
        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:YES];
    
        NSDictionary *dict = @{@"xmbh":self.m_Sbxq_saveDataDict[@"xmbh"],@"jclxbh":self.m_Sbxq_saveDataDict[@"jclxbh"]};
        [self PopYSJL_TemplatesListViewControllerWithZSretDict:dict];
    }else
    {
        [Dialog toast:self withMessage:@"未保存成功公共信息!"];
    }
    

    
    if ([_m_ggxx_retDict[@"ret"]intValue] == 1) {
      
        
    }
    
   
    
}


/**
 *  原始记录 底部按钮事件
 *
 *  @param sender
 */
- (IBAction)Ysjl_SaveBtnClick:(id)sender {
    
    
    UIButton *saveBtn = (UIButton *)sender;
//    [self.m_ysjl_javascriptBridge callHandler:@"hqlssj" data:self.yqid_Str responseCallback:^(id response)
//     {
//      
//         
//         debug_object(response);
//         
//         
//         
//     }];
    
    if (![self validateInputInView:self.m_sbxq_ScrollView]){
       [self.m_showDialog WarningNotificationWithMessage:@"请补全信息!"];
        
    }else
    {
        @weakify(self)
        id data = @{ @"name": @"杨智",@"title":@"成功了嘛？" };
        [self.m_ysjl_javascriptBridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id response)
         {
             @strongify(self)
             
             [self pasteWithDictStr:response];
             
             [saveBtn setImage:[UIImage imageNamed:@"right-button-ybc"] forState:UIControlStateNormal];
             
             
         }];
    }
    
       //jdjl 检定结论(校准记录可为空) 否则（检定的必须有值）
    //jlModel 记录信息 TModelJiluxxb model记录信息表 jlModel 字段包括 A1,A2,A3......A992
}

-(void)postToNetWithDict:(NSDictionary *)dict
{
    
    
     LoginedUser *usr = [LoginedUser sharedInstance];
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    [dict1 addEntriesFromDictionary:@{@"yqid":self.yqid_Str,@"usercode":usr.usercode}];
    //判断是否为 校准记录
    if (dict[@"jdjl"] !=nil)
    {
        
        /**
         *   检定结论(校准记录可为空) 否则（检定的必须有值）
         */
        if ([dict[@"jdjl"]isNotNull]) {
            
            
            //    @weakify(self)
            [[BaseNetWork getInstance] hideDialog];
            [[[[[BaseNetWork getInstance] rac_postPath:@"addJiluxx.do" parameters:dict1]map:^(id responseData)
               {
                   NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
                   
                   return dict;
               }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
             subscribeNext:^(NSDictionary *retDict) {
                 
//                 jlh = "JL-CD02156224";
//                 jlid = 97A22AC96BEF433598730B4E6ECC7925;
//                 ret = 1;
                 self.m_ysjl_retDict = retDict;
                 
                 if ([retDict[@"ret"] intValue] == 0)
                 {
                    [Dialog toastError:@"保存失败!"];
//                     [self.m_showDialog ErrorNotificationWithMessage:@"保存失败！"];
                     
                 }else
                 {
                     [Dialog toastSuccess:@"保存成功！"];
                     /**
                      *  1为显示 保存
                      */
                     self.is_ysjl_Edited = @1;
                     
                     
                 }
                 
             }error:^(NSError *error){
                 

                 
             }];
            
            
        }else
        {
            //表示不符合条件
            [Dialog toast:self withMessage:@"检定必须有值!"];
        
        }
        
        
    }else
    {
        
        //    @weakify(self)
        [[[[[BaseNetWork getInstance] rac_postPath:@"addJiluxx.do" parameters:dict1]map:^(id responseData)
           {
               NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
               
               return dict;
           }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
         subscribeNext:^(NSDictionary *retDict) {
             
              self.m_ysjl_retDict = retDict;
             
             if ([retDict[@"ret"] intValue] == 0)
             {
                 [Dialog toastError:@"保存失败!"];
//                 [self.m_showDialog ErrorNotificationWithMessage:@"保存失败！"];
                 
             }else
             {
                [Dialog toastSuccess:@"保存成功！"];
//                 [self.m_showDialog SuccessNotificationWithMessage:@"保存成功！"];
             }
             
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
-(void)pasteWithDictStr:(id ) jsonStr
{
    
    @weakify(self)
    SBJson4ValueBlock block = ^(id v, BOOL *stop) {
       
        @strongify(self)
        
        [self postToNetWithDict:v];
    };
    
    SBJson4ErrorBlock eh = ^(NSError* err) {
        NSLog(@"OOPS: %@", err);
    };
    
    id parser = [SBJson4Parser multiRootParserWithBlock:block
                                           errorHandler:eh];
    NSData* xmlData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    // Note that this input contains multiple top-level JSON documents
//    id data = [jsonStr dataWithEncoding:NSUTF8StringEncoding];
    [parser parse:xmlData];
    
    
}
- (IBAction)Ysjl_hqsj_BtnClick:(id)sender {
    
    CGFloat xWidth = self.view.bounds.size.width - 460;
    CGFloat yHeight = 80.0f;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(230, yOffset, xWidth, yHeight)];
    
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = FALSE;
    [poplistview show];
    
}

- (IBAction)Ysjl_ghzsmb_btnClick:(id)sender {
    
}


- (IBAction)Ysjl_CancleBtbClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        [self.m_superView  loadNetData];
    }];

}

- (IBAction)Ysjl_NextStepBtnClick:(id)sender {
    
    /**
     *  原始记录保存后的数据成功时才能下一步
     */
    if ([self.m_ysjl_retDict[@"ret"]intValue] == 1) {
        
        
        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*3,0} animated:YES];
        
        @weakify(self);
        [self.lineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.m_zs_Btn.mas_centerX);
            make.width.equalTo(@30);
            make.height.equalTo(@4);
            make.top.equalTo(self.m_menuBarView.mas_top).offset(2);
        }];
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            @strongify(self)
            [self.m_menuBarView layoutIfNeeded];
            
        }completion:NULL];
          [self PopZS_TemplatesListViewControllerWithZSretDict:self.m_ysjl_retDict];
        
    }else
    {
        [Dialog toast:self withMessage:@"原始记录未保存成功!"];
    }
    
    
 
    
    
}
- (IBAction)zs_GhzsmbBtnClick:(id)sender {
    
      [self PopZS_TemplatesListViewControllerWithZSretDict:self.m_ysjl_retDict];
    
}
- (IBAction)Ysjl_RefreshBtnClick:(id)sender {
    
     [self load_ysjl_WebViewWithjljspmc:_m_ysjl_saveUrl_Str];
}

- (IBAction)Zs_RefreshBtnClick:(id)sender {
    
    [self load_zs_WebViewWithjljspmc:_m_zs_saveUrl_Str];
    
    
}

/**
 *  证书 底部按钮事件
 *
 *  @param sender
 */
- (IBAction)Zs_SaveBtnClick:(id)sender {
    
    
    if ([self.yqid_Str isNotNull]) {
        
        LoginedUser *usr = [LoginedUser sharedInstance];
        
        //    @weakify(self)
        [[[[[BaseNetWork getInstance] rac_postPath:@"tjhy.do" parameters:@{@"usercode":usr.usercode,@"yqid":self.yqid_Str}]map:^(id responseData)
           {
               NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
               
               return dict;
           }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
         subscribeNext:^(NSDictionary *retDict) {
             
             if ([retDict[@"ret"] intValue] == 0)
             {
                 
                 [Dialog toast:self withMessage:@"核验失败!"];
                 
             }else
             {
                 [Dialog toast:self withMessage:@"核验成功!"];
                 
                 [self dismissViewControllerAnimated:YES completion:^(void){
                     [self.m_superView  loadNetData];
                 }];
             }
             
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

        
    }else
    {
        [Dialog toast:self withMessage:@"没有仪器id!"];
    }
   
  
    
}

- (IBAction)Zs_CancleBtnClick:(id)sender {
}


- (IBAction)FullScreenPreviewBtnClick:(id)sender {
    
    
//    FullScreenPreviewVC
    
    
    if ([self.m_zs_saveUrl_Str isNotNull]) {
        
        NSString *webzsStr = [NSString stringWithFormat:@"http://%@/lims/web/pages/detectionTask/certificate-autoc.jsp?zsbh=%@",WEBURL,self.m_zs_saveUrl_Str];
        FullScreenPreviewVC *tempLasteVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FullScreenPreviewVC"];
        tempLasteVC.m_urlStr = webzsStr;
        tempLasteVC.modalPresentationStyle = UIModalPresentationFormSheet;
        tempLasteVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        [self presentViewController:tempLasteVC animated:YES completion:^(void){
            
            
        }];
        
    }else
    {
        [Dialog toast:self withMessage:@"web页面不存在!"];
    }
    
  
    
    
    
}

- (void)tapClick:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.m_fullScreenVc dismissViewControllerAnimated:YES completion:^(void){
        [self.m_superView  loadNetData];
    }];
}

- (IBAction)m_UpBtnClick:(id)sender {
}



/**
 *  点击保存是，取得计量标准考核证书ID(多个按","分隔)
 *
 *  @return 计量标准考核证书ID(多个按","分隔)
 */
-(NSString *)get_jlbzkhzsID
{
    
    //01. 第一步先找出选中的数据
    NSArray *jlbzkhzshArr = [self.m_jlbzkhzsh_Arr linq_where:^BOOL(Jlbzkhzsh_Model *model) {
        return model.isSelected;
    }];
    //02. 第二步筛选出 计量标准考核证书ID
    NSArray *jlbzkhzshIDArr = [jlbzkhzshArr linq_select:^id(Jlbzkhzsh_Model *model){
        return model.m_id;
    }];
    
    debug_object(jlbzkhzshIDArr);
    //03. 第三步 将计量标准考核证书ID数组转换成","分割的字符串
    NSString *retStr = [jlbzkhzshIDArr componentsJoinedByString:@","];
      debug_object(retStr);
    return  retStr;
}

/**
 *  点击保存是，取得 标准器设备--标准设备编号(多个按","分隔)
 *
 *  @return 标准器设备--标准设备编号(多个按","分隔)
 */
-(NSString *)get_bzsbbhs
{
    
    //01. 第一步先找出选中的数据
    NSArray *bzqsbArr = [self.m_bzqsb_Arr linq_where:^BOOL(Bzqsb_Model *model) {
        return model.isSelected;
    }];
    //02. 第二步筛选出 计量标准考核证书ID
    NSArray *jlbzkhzshIDArr = [bzqsbArr linq_select:^id(Bzqsb_Model *model){
        return model.bzsbbh;
    }];
    
    //03. 第三步 将计量标准考核证书ID数组转换成","分割的字符串
    NSString *retStr = [jlbzkhzshIDArr componentsJoinedByString:@","];
     debug_object(retStr);
    return  retStr;
}

/**
 *  点击保存是，取得 标准器设备--溯源证书号(多个按","分隔)
 *
 *  @return 标准器设备--溯源证书号(多个按","分隔)
 */
-(NSString *)get_syzshs
{
    
    //01. 第一步先找出选中的数据
    NSArray *bzqsbArr = [self.m_bzqsb_Arr linq_where:^BOOL(Bzqsb_Model *model) {
        return model.isSelected;
    }];
    //02. 第二步筛选出 计量标准考核证书ID
    NSArray *jlbzkhzshIDArr = [bzqsbArr linq_select:^id(Bzqsb_Model *model){
        return model.syzsh;
    }];
    
    //03. 第三步 将计量标准考核证书ID数组转换成","分割的字符串
    NSString *retStr = [jlbzkhzshIDArr componentsJoinedByString:@","];
     debug_object(retStr);
    return  retStr;
}


/**
 *  点击保存是，取得 技术依据ID(多个按","分隔)
 *
 *  @return 技术依据ID(多个按","分隔)
 */
-(NSString *)get_jsyjID
{
    
    //01. 第一步先找出选中的数据
    NSArray *bzqsbArr = [self.m_jsyj_Arr linq_where:^BOOL(Jsyj_Model *model) {
        return model.isSelected;
    }];
    //02. 第二步筛选出  技术依据ID
    NSArray *jlbzkhzshIDArr = [bzqsbArr linq_select:^id(Jsyj_Model *model){
        return model.m_id;
    }];
    
    //03. 第三步  技术依据ID数组转换成","分割的字符串
    NSString *retStr = [jlbzkhzshIDArr componentsJoinedByString:@","];
    
    return  retStr;
}

-(void)save_ggxx_Data
{
    // 将NSDate格式装换成NSString类型
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    // 设置日历显示格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    // 把日历时间传给字符串
    NSString *jdrqStr = [dateFormatter stringFromDate:self.m_jdrq_Btn.m_info[@"date"]];
    
    
    self.m_Ggxx_saveDataDict[@"yqid"] = self.yqid_Str;
    
    self.m_Ggxx_saveDataDict[@"jdrq"] = [jdrqStr GetNotNullStr];
    
   
    
    self.m_Ggxx_saveDataDict[@"hjwd"] = [self.m_hjwd_TF.text GetNotNullStr];
    self.m_Ggxx_saveDataDict[@"hjsd"] = [self.m_xdsd_TF.text GetNotNullStr];
    
    
    NSArray *jdyArr = [self.m_jdy_Dict allKeys];
    
    if (jdyArr.count>0) {
        self.m_Ggxx_saveDataDict[@"jdrbh"] = jdyArr[0];
    }else
    {
         self.m_Ggxx_saveDataDict[@"jdrbh"] = @"";
    }

    self.m_Ggxx_saveDataDict[@"jddd"] = [self.m_jddd_TF.text GetNotNullStr];
    self.m_Ggxx_saveDataDict[@"jszt"] = [self.m_jszt_TF.text GetNotNullStr];
    self.m_Ggxx_saveDataDict[@"qt"] = [self.m_qt_TF.text GetNotNullStr];
    
//    if (@"j001") {
//        
//    }
//    if ([[self get_jlbzkhzsID] GetNotNullStr].length <1) {
//        
//        return;
//        
//    }
    self.m_Ggxx_saveDataDict[@"jlbzkhzsID"] = [[self get_jlbzkhzsID] GetNotNullStr];
    self.m_Ggxx_saveDataDict[@"bzsbbhs"] = [[self get_bzsbbhs] GetNotNullStr];
    self.m_Ggxx_saveDataDict[@"syzshs"] = [[self get_syzshs] GetNotNullStr];
   self.m_Ggxx_saveDataDict[@"jsyjID"] = [[self get_jsyjID] GetNotNullStr];
    
    
    
   // jdrq
    //取证日期 forensicsDateBtn
}

-(void)save_Sbxq_Data
{

    //TODO:界面显示信息
    self.m_Sbxq_saveDataDict[@"txm"] = [_m_txm_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"yqmc"] = [_m_yqmc_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"jltx"] = [_m_jlfw_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"jcfw"] = [_m_clfw_TF.text GetNotNullStr];
    
    self.m_Sbxq_saveDataDict[@"ggxh"] = [_m_ggxh_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"sccj"] = [_m_sccj_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"ccbh"] = [_m_ccbh_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"jclx"] = [_m_jclx_DTF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"sl"] = [_m_sl_TF.text GetNotNullStr];
    
    /**
     *  数量单位
     */
    self.m_Sbxq_saveDataDict[@"by1"] = [_m_dw_DTF.text GetNotNullStr];
    
    /**
     *  报价
     */
    self.m_Sbxq_saveDataDict[@"bzsf"] = [_m_bj_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"wg"] = [_m_wg_TF.text GetNotNullStr];;
    
    /**
     *  项目 未使用 （界面上唯一未使用的，因为使用了项目编号了）
     */
    
    /**
     *  附件
     */
    self.m_Sbxq_saveDataDict[@"pj"] = [_m_fj_TF.text GetNotNullStr];
    
    self.m_Sbxq_saveDataDict[@"bz"] = [_m_bz_TV.text GetNotNullStr];;
    
    
    /*****************************************************/

    
    switch (_m_dataSourceType) {
        case TxmDataSourceType:
        {

        }
            
            break;
        case TxmNotDataSourceType:
        {
            
            /**
             *  设置隐藏参数
             */
            [self update_yczd];

        }
            
            break;
        case YqidDataSourceType:
        {
            
        }
            
            break;
        case NullDataSourceType:
        {
            /**
             *  设置隐藏参数
             */
            [self update_yczd];
        }
            
            break;
            
        default:
            break;
    }
    

    
}

- (BOOL)validateInputInView:(UIView*)view
{
    
    if (view == self.m_ggxx_ScrollView) {
        
        if (![self.m_qjyt_DTF validate]) {
            [self.m_qjyt_DTF verifyshowDropDownTableView];
            return NO;
        }else if (![self.m_jdzq_DTF validate]) {
            [self.m_jdzq_DTF becomeFirstResponder];
            return NO;
        }else if (![self.m_jddd_TF validate]) {
            [self.m_jddd_TF becomeFirstResponder];
            return NO;
        }else  if (![self.m_jdzq_DTF validate]) {
            [self.m_jdzq_DTF verifyshowDropDownTableView];
            return NO;
        }else  if (![self.m_jddd_TF validate]) {
            [self.m_jddd_TF becomeFirstResponder];
            return NO;
        }else  if (![self.m_hjwd_TF validate]) {
            [self.m_hjwd_TF becomeFirstResponder];
            return NO;
        }else  if (![self.m_xdsd_TF validate]) {
            [self.m_xdsd_TF becomeFirstResponder];
            return NO;
        }else  if (![self.m_qt_TF validate]) {
            [self.m_qt_TF becomeFirstResponder];
            return NO;
        }else  if (![self.m_jdy_TF validate]) {
            [self.m_jdy_TF becomeFirstResponder];
            return NO;
        }else if (![self.m_hyy_DTF validate]) {
            [self.m_hyy_DTF verifyshowDropDownTableView];
            return NO;
        }else if (![self.m_pzr_DTF validate]) {
            [self.m_pzr_DTF verifyshowDropDownTableView];
            return NO;
        }else
            return YES;
    }else if (view == self.m_sbxq_ScrollView) {
        if (![self.m_txm_TF validate]) {
            [self.m_txm_TF becomeFirstResponder];
            return NO;
        }else if (![self.m_yqmc_TF validate]) {
            [self.m_yqmc_TF becomeFirstResponder];
            return NO;
        }else if (![self.m_jclx_DTF validate]) {
            [self.m_jclx_DTF verifyshowDropDownTableView];
            return NO;
        }else if (![self.m_sl_TF validate]) {
            [self.m_sl_TF becomeFirstResponder];
            return NO;
        }else if (![self.m_dw_DTF validate]) {
            [self.m_dw_DTF becomeFirstResponder];
            return NO;
        }else if (![self.m_bj_TF validate]) {
            [self.m_bj_TF becomeFirstResponder];
            return NO;
        }else  if (![self.m_xm_ADTF validate]) {
            [self.m_xm_ADTF becomeFirstResponder];
            return NO;
        }else
            return YES;
    }else
    {
        return YES;
    }
    
}

#pragma mark - 代理协议方法*



#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == _m_jlbzkhzsh_TableView)
    {
        return _m_jlbzkhzsh_Arr.count +1;
        
    }else if (tableView == _m_bzqsb_TableView)
    {
        return _m_bzqsb_Arr.count +1;
    }else if (tableView == _m_jsyj_TableView)
    {
        return _m_jsyj_Arr.count +1;
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
 
 
 - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
 
 }
 
 
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 return @"";
 
 }*/
#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *cellIdentifier;
    
    if (tableView == _m_jlbzkhzsh_TableView)
    {
        
        if (indexPath.row ==0) {
            cellIdentifier = @"Jlbzkhzsh_TableViewCellTitle";
            
             UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            return cell;
            
        }else
        {
            cellIdentifier = @"Jlbzkhzsh_TableViewCell";
            Jlbzkhzsh_TableViewCell *cell = (Jlbzkhzsh_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            Jlbzkhzsh_Model *model = _m_jlbzkhzsh_Arr[indexPath.row -1];
            [cell configureCellWithItem:model];
            
            return cell;
        }
        
        
    }else if (tableView == _m_bzqsb_TableView)
    {
        
        if (indexPath.row ==0) {
            cellIdentifier = @"Bzqsb_TableViewCellTitle";
            
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            return cell;
            
        }else
        {
            cellIdentifier = @"Bzqsb_TableViewCell";
            Bzqsb_TableViewCell *cell = (Bzqsb_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            Bzqsb_Model *model = _m_bzqsb_Arr[indexPath.row-1];
            [cell configureCellWithItem:model];
            
            return cell;
        }
        
    }else if (tableView == _m_jsyj_TableView)
    {
        
        if (indexPath.row ==0) {
            cellIdentifier = @"Jsyj_TableViewCellTitle";
            
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            return cell;
            
        }else
        {
            cellIdentifier = @"Jsyj_TableViewCell";
            Jsyj_TableViewCell *cell = (Jsyj_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            Jsyj_Model *model = _m_jsyj_Arr[indexPath.row-1];
            [cell configureCellWithItem:model];
            
            return cell;
        }
    }

    return nil;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        
        if (tableView == _m_jlbzkhzsh_TableView)
        {
            Jlbzkhzsh_Model *model = _m_jlbzkhzsh_Arr[indexPath.row-1];
            model.isSelected = !model.isSelected;
            
        }else if (tableView == _m_bzqsb_TableView)
        {
            Bzqsb_Model *model = _m_bzqsb_Arr[indexPath.row-1];
            model.isSelected = !model.isSelected;
        }else if (tableView == _m_jsyj_TableView)
        {
            Jsyj_Model *model = _m_jsyj_Arr[indexPath.row-1];
            
            model.isSelected = !model.isSelected;
        }
        
        /**
         *  1为显示 保存
         */
        self.is_ggxx_Edited = @1;
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
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

#pragma  mark - DropDownTextFieldDataSource
-(NSArray *)dropDownTextFieldDataSourceTextField:(DropDownTextField *)textField;

{
    
    if (textField == _m_jclx_DTF) {
        
        return _m_jclxTFArr;
        
    }else if(textField == _m_dw_DTF) {
        
        return _m_dwTFArr;
    }else if(textField == _m_qjyt_DTF)
    {
        return _m_qjytTFArr;
        
    }else if(textField == _m_hyy_DTF)
    {
        return _m_hyyTFArr;
    }else if(textField == _m_pzr_DTF)
    {
        return _m_pzrTFArr;
        
    }else if(textField == _m_jdzq_DTF)
    {
        return _m_jdzqTFArr;
    }
    
    return nil;
}


 #pragma mark - DropDownTextFieldDelegate

-(void)dropDownTextField:(DropDownTextField *)textField didSelectedWithData:(id<DropDownTextFieldShowCellTextLabel>) data forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (textField == _m_jclx_DTF) {
         dmxx_Model *model = _m_jclxTFArr[indexPath.row];
        
        self.m_Sbxq_saveDataDict[@"jclxbh"] =model.dmbm;
        
        /**
         *  1为显示 保存
         */
        self.is_sbxq_Edited = @1;
    
    }else if(textField == _m_dw_DTF) {
        
        dmxx_Model *model = _m_dwTFArr[indexPath.row];

         self.m_Sbxq_saveDataDict[@"by2"] =model.dmbm;
        
        /**
         *  1为显示 保存
         */
        self.is_sbxq_Edited = @1;
        
        
    }else if(textField == _m_qjyt_DTF) {
        
        jdzq_Model *model = _m_qjytTFArr[indexPath.row];
        
        self.m_Ggxx_saveDataDict[@"qjytbh"] =model.dmbm;
        
    
        self.is_ggxx_Edited = @1;
        
        
    }else if(textField == _m_jdzq_DTF)
    {
        
        dmxx_Model *model = _m_jdzqTFArr[indexPath.row];
        
//        self.m_Sbxq_saveDataDict[@"jdzqbh"] =model.dmbm;
        self.m_Ggxx_saveDataDict[@"jdzqbh"] =model.dmbm;
        self.is_ggxx_Edited = @1;
        
    }
     else if(textField == _m_hyy_DTF)
    {
        /**
         *  需要判断 如果id与检定员id相同则重新修改
         */

        hyr_Model *model = _m_hyyTFArr[indexPath.row];
        
        if ([model.m_key isEqualToString:self.m_jdrybh_Str]) {

            [Dialog toast:self withMessage:@"核验人与检定人不能为同一个人!"];
            
        }else
        {
            self.m_Ggxx_saveDataDict[@"hyrbh"] = model.m_key;
            
            self.is_ggxx_Edited = @1;
        }
        
        
        
    }else if(textField == _m_pzr_DTF)
    {
        pzr_Model *model = _m_pzrTFArr[indexPath.row];
        self.m_Ggxx_saveDataDict[@"pzrbh"] = model.usercode;

        
    }
    
}

#pragma  mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _m_jclx_DTF) {
        return NO;
        
    }else if(textField == _m_dw_DTF) {
        
         return NO;
        
    }else if(textField == _m_qjyt_DTF) {
        
        return NO;
        
    }else if(textField == _m_jdzq_DTF)
    {
        return NO;
    }
    else if(textField == _m_hyy_DTF)
    {
        return NO;
    }else if(textField == _m_pzr_DTF)
    {
        return NO;
        
    }
    

    if (textField == _m_txm_TF ||textField == _m_jlfw_TF ||textField == _m_clfw_TF ||textField == _m_ggxh_TF||textField == _m_sccj_TF ||textField == _m_sl_TF ||textField == _m_bj_TF||textField == _m_wg_TF||textField == _m_fj_TF) {
        
        /**
         *  1为显示 保存
         */
        self.is_sbxq_Edited = @1;
        
    }
    
    if (textField == _m_jddd_TF || textField == _m_hjwd_TF || textField == _m_xdsd_TF || textField == _m_qt_TF || textField == _m_jszt_TF) {
        
        /**
         *  1为显示 保存
         */
        self.is_ggxx_Edited = @1;
        
    }

   
    return YES;
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.y &gt; 0 scrollView.contentOffset.y &lt; 0 ) scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
//}

#pragma mark - AutoCompleteTextFieldDataSource
//TODO:数据回来时必须先更新数据代理，然后再调用autotextfield 的 relodata
-(NSArray *)autoCompleteDataSourceTextField:(AutoCompleteTextField *)textField
{
    if (textField == _m_yqmc_TF) {
        return self.m_autoTFArr;
    }else if (textField == _m_xm_ADTF)
    {
        return self.m_xmAutoTFArr;
    }

    return nil;
}

#pragma mark - AutoCompleteTextFieldDelegate
- (void)autoCompleteTextField:(AutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<AutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if (textField == _m_yqmc_TF) {
        
        /**
         *  1为显示 保存
         */
        self.is_sbxq_Edited = @1;
        
        Yqmc_Auto_Model *yqmcModel = ( Yqmc_Auto_Model *)selectedObject;
        
        @weakify(self)
        [[BaseNetWork getInstance] showDialog];
        NSDictionary *dict =@{@"sfbzid":yqmcModel.sfbzid};
        [[[[[BaseNetWork getInstance] rac_postPath:@"getYqbjxx.do" parameters:dict]map:^(id responseData)
           {
               NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
               
               return [dict valueForKeyPath:@"yqjbxx"];
           }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
         subscribeNext:^(NSArray *arr) {
             
             if (arr.count >0) {
                 
                 //默认区第一条数据
                 NSDictionary *dict = arr[0];
                 
                 Yqjbxx_Model *yqjbxx = [MTLJSONAdapter modelOfClass:[Yqjbxx_Model class] fromJSONDictionary:dict error:nil];
                 
                 @strongify(self)
                 [self update_sbxqViewByYqjbxx_Model:yqjbxx];
                 
             }
             //         Yqjbxx_Model
             
             
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

        
        
    }else if (textField == _m_xm_ADTF)
    {
      xmbh_Auto_Model *xmmcModel = ( xmbh_Auto_Model *)selectedObject;
        
        self.m_Sbxq_saveDataDict[@"xmbh"] = xmmcModel.xmdm;
        
        
        self.is_ggxx_Edited = @1;
        
    
    }
    
    
    
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
    
    
    /**
     *  需要实时的获取更新下面的数据 findJlkhzrBzqsbJsyj.do
     1.4.15.3 结果集 json 格式 {
     "ret": 1, "jlbzkhzsLists": [
     */
    
    
    debug_object([_m_qjxxDict GetLabelWithKey:@"xmbh"]);
    
    @weakify(self)
    /**
     *  获取单位名称
     */
    [[BaseNetWork getInstance] hideDialog];
    [[[[[BaseNetWork getInstance] rac_postPath:@"findJlkhzrBzqsbJsyj.do" parameters:@{@"jdrq":strDate,@"xmbh":self.m_Sbxq_saveDataDict[@"xmbh"]}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary *retDict) {
         @strongify(self)
        
         
         NSArray *jlbzkhzshArr = retDict[@"jlbzkhzsLists"];
         NSArray *bzqsbArr = retDict[@"bzqsbLists"];
         
         NSArray *jsyjArr = retDict[@"jsyjLists"];
         
         self.m_jlbzkhzsh_Arr = [jlbzkhzshArr
                                 linq_select:^id(NSDictionary *dict)
                                 {
                                     
                                     Jlbzkhzsh_Model *model = [MTLJSONAdapter modelOfClass:[Jlbzkhzsh_Model class] fromJSONDictionary:dict error:nil];
                                     model.isSelected = YES;
                                     
                                     return model;
                                 }];
         
         self.m_bzqsb_Arr = [bzqsbArr
                             linq_select:^id(NSDictionary *dict)
                             {
                                 
                                 Bzqsb_Model *model = [MTLJSONAdapter modelOfClass:[Bzqsb_Model class] fromJSONDictionary:dict error:nil];
                                 model.isSelected = YES;
                                 return model;
                             }];
         
         self.m_jsyj_Arr = [jsyjArr
                            linq_select:^id(NSDictionary *dict)
                            {
                                
                                Jsyj_Model *model = [MTLJSONAdapter modelOfClass:[Jsyj_Model class] fromJSONDictionary:dict error:nil];
                                model.isSelected = YES;
                                
                                return model;
                            }];
         
         
         [self.m_jlbzkhzsh_TableView reloadData];
         [self.m_bzqsb_TableView reloadData];
         [self.m_jsyj_TableView reloadData];
         
         
         
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

-(void)load_ysjl_WebViewWithjljspmc:(NSString *) jljspmc
{
    //175.17.22.241:8080
    
    NSString *webysjlStr = [NSString stringWithFormat:@"http://%@/lims/web/pages/detectionTask/record-addc.jsp?yqid=%@&jljspmc=%@",WEBURL,self.yqid_Str,jljspmc];
    
//    self.m_ysjl_WebView.scrollView.scrollEnabled = NO;
    [self.m_ysjl_WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webysjlStr]]];
    
}


-(void)load_zs_WebViewWithjljspmc:(NSString *) jljspmc
{
    
    debug_object(jljspmc);
    
      NSString *webzsStr = [NSString stringWithFormat:@"http://%@/lims/web/pages/detectionTask/certificate-autoc.jsp?zsbh=%@",WEBURL,jljspmc];
    
    self.m_zs_retDict = @{@"UrlStr":webzsStr};
    [self.m_zs_WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webzsStr]]];
    
}


#pragma mark -ZS_TemplatesListVCDelegate
-(void)ZS_TemplatesListVC:(ZS_TemplatesListViewController *) templatestVC didSelectedOKByObj:(id ) data
{
    zsmb_Model *model = (zsmb_Model*)data;
    
    debug_object(self.yqid_Str);
    @weakify(self)
    [[[[[BaseNetWork getInstance] rac_postPath:@"sczs.do" parameters:@{@"zsmbid":model.m_id,@"yqid":self.yqid_Str}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary *retDict) {
         @strongify(self)
         if ([retDict[@"ret"] intValue] == 1) {
             
             
             
             [self load_zs_WebViewWithjljspmc:retDict[@"zsbh"]];
              self.m_zs_saveUrl_Str = retDict[@"zsbh"];
         }
         
         
         
     }error:^(NSError *error){

         
     }];

    

  

}

#pragma mark -YSJL_TemplatesListViewController
-(void)YSJL_TemplatesListVC:(YSJL_TemplatesListViewController *) templatestVC didSelectedOKByObj:(id ) data
{
    jlmb_Model *model = (jlmb_Model*)data;
    /**
     *   原始记录模板 保存
     */
    @weakify(self)
    [[BaseNetWork getInstance] hideDialog];
    [[[[[BaseNetWork getInstance] rac_postPath:@"saveJlmb.do" parameters:@{@"dzjlmbID":model.m_id,@"yqid":self.yqid_Str}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary *retDict) {
         @strongify(self)
         if ([retDict[@"ret"] intValue] ==1) {
             //然后再去 为显示记录模板 而获取 显示记录模板的url地址
             

             [self load_ysjl_WebViewWithjljspmc:model.jljspmc];
             self.m_ysjl_saveUrl_Str = model.jljspmc;
             
             
         }else
         {
             [Dialog toast:self withMessage:@"原始记录模板 保存失败!"];
         }
         
         
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


#pragma mark - 代理协议方法*

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (self.m_hub == nil) {
        RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWave color:[UIColor whiteColor]];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.square = YES;
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = spinner;
        hud.labelText = @"加载中...";
        self.m_hub = hud;
          [self.m_spinner startAnimating];
        self.m_spinner = spinner;
    }else
    {
        [self.m_spinner startAnimating];
        [self.m_hub show:YES];
      
    }
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    [self.m_hub hide:YES];
    [self.m_spinner stopAnimating];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


#pragma mark -DidSelectedValue_XCRY_Delegate

-(void)SelectValue_YSJL_HqsjVC:(YSJL_HqsjVC*) selectValueTVC DidSelectedValue:(id)selectedValue
{
    
}

#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier];
    
    int row = indexPath.row;
    
    if(row == 0){
        cell.textLabel.text = @"获取同名数据";
    }else if (row == 1){
        cell.textLabel.text = @"获取历史数据";
    }
    
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s : %d", __func__, indexPath.row);
    // your code here
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


@end
