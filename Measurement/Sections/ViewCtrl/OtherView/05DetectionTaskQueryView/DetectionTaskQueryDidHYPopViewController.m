//
//  DetectionTaskQueryDidHYPopViewController.m
//  Measurement
//
//  Created by DTSoft on 15/1/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "DetectionTaskQueryDidHYPopViewController.h"
#import "FullScreenPreviewVC.h"
#import "WebViewJavascriptBridge.h"
#import "SBJson4Parser.h"
#import "ZS_TemplatesListViewController.h"
#import "YSJL_TemplatesListViewController.h"


@interface DetectionTaskQueryDidHYPopViewController ()<UITextFieldDelegate,ZS_TemplatesListVCDelegate,YSJL_TemplatesListVCDelegate,UIWebViewDelegate>

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



@property (weak, nonatomic) IBOutlet UIScrollView *m_sbxq_ScrollView;

/**
 *  设备详情
 */
@property(nonatomic ,strong) NSDictionary *m_jcsj_Dict;

@property (weak, nonatomic) IBOutlet UILabel *m_txm_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_zsh_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_ssks_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_yqmc_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_ccbh_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_jclx_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_sl_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_bj_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_jltx_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_clfw_LB;


@property (weak, nonatomic) IBOutlet UILabel *m_ggxh_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_sccj_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_wg_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_pj_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_tsyq_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_bz_LB;


/**
 *  流转跟踪
 */
@property (weak, nonatomic) IBOutlet UILabel *m_wtdj_sj_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_wtdj_usr_LB;
@property (weak, nonatomic) IBOutlet UIImageView *m_wtdj_state_ImgV;
@property (weak, nonatomic) IBOutlet UIView *m_wtdj_state_V;

@property (weak, nonatomic) IBOutlet UILabel *m_lydj_sj_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_lydj_usr_LB;
@property (weak, nonatomic) IBOutlet UIImageView *m_lydj_state_ImgV;
@property (weak, nonatomic) IBOutlet UIView *m_lydj_state_V;

@property (weak, nonatomic) IBOutlet UILabel *m_rwlq_sj_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_rwlq_usr_LB;
@property (weak, nonatomic) IBOutlet UIImageView *m_rwlq_state_ImgV;
@property (weak, nonatomic) IBOutlet UIView *m_rwlq_state_V;

@property (weak, nonatomic) IBOutlet UILabel *m_jd_sj_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_jd_usr_LB;
@property (weak, nonatomic) IBOutlet UIImageView *m_jd_state_ImgV;
@property (weak, nonatomic) IBOutlet UIView *m_jd_state_V;


@property (weak, nonatomic) IBOutlet UILabel *m_hy_sj_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_hy_usr_LB;
@property (weak, nonatomic) IBOutlet UIImageView *m_hy_state_ImgV;
@property (weak, nonatomic) IBOutlet UIView *m_hy_state_V;


@property (weak, nonatomic) IBOutlet UILabel *m_pz_sj_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_pz_usr_LB;
@property (weak, nonatomic) IBOutlet UIImageView *m_pz_state_ImgV;
@property (weak, nonatomic) IBOutlet UIView *m_pz_state_V;

@property (weak, nonatomic) IBOutlet UILabel *m_fy_sj_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_fy_usr_LB;
@property (weak, nonatomic) IBOutlet UIImageView *m_fy_state_ImgV;
@property (weak, nonatomic) IBOutlet UIView *m_fy_state_V;


@property (weak, nonatomic) IBOutlet UILabel *m_dy_sj_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_dy_usr_LB;
@property (weak, nonatomic) IBOutlet UIImageView *m_dy_state_ImgV;
@property (weak, nonatomic) IBOutlet UIView *m_dy_state_V;


@property (weak, nonatomic) IBOutlet UILabel *m_fz_sj_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_fz_usr_LB;
@property (weak, nonatomic) IBOutlet UIImageView *m_fz_state_ImgV;
@property (weak, nonatomic) IBOutlet UIView *m_fz_state_V;

@property (weak, nonatomic) IBOutlet UILabel *m_fyg_sj_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_fyg_usr_LB;
@property (weak, nonatomic) IBOutlet UIImageView *m_fyg_state_ImgV;




/**
 *  原始记录
 */
@property (weak, nonatomic) IBOutlet UIButton *m_ysjl_Btn;

@property (weak, nonatomic) IBOutlet UIScrollView *m_ysjl_ScrollView;

@property (weak, nonatomic) IBOutlet UIWebView *m_ysjl_WebView;

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
@property (strong, nonatomic) WebViewJavascriptBridge *m_zs_javascriptBridge;

@property(nonatomic , strong)NSDictionary *m_zs_retDict;


@end

@implementation DetectionTaskQueryDidHYPopViewController

#pragma mark - 系统方法


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
    
//    if ([segue.identifier isEqualToString:@"JDRQ_DatePicker"] )
//    {
//        
//        DatePickerViewController *datePickerVC = (DatePickerViewController*)[segue destinationViewController];
//
//    }
    
    
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
    
    self.m_ysjl_WebView.delegate = self;
    self.m_zs_WebView.delegate = self;
    
    
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
    
    
    self.m_ysjl_javascriptBridge = [WebViewJavascriptBridge bridgeForWebView:self.m_ysjl_WebView handler:^(id data, WVJBResponseCallback responseCallback) {
        
    }];
    
    self.m_zs_javascriptBridge = [WebViewJavascriptBridge bridgeForWebView:self.m_zs_WebView handler:^(id data, WVJBResponseCallback responseCallback) {
        
    }];
    
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
                make.top.equalTo(self.m_menuBarView.mas_top).offset(2);
                switch (currentPage) {
                    case 0:
                        make.centerX.equalTo(self.m_sbxq_Btn.mas_centerX);
                        make.width.equalTo(@60);
                        //
                        break;
                    case 1:
                        make.centerX.equalTo(self.m_ysjl_Btn.mas_centerX);
                        make.width.equalTo(@60);
                        
                        break;
                        
                    case 2:
                        make.centerX.equalTo(self.m_zs_Btn.mas_centerX);
                        make.width.equalTo(@30);
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
    
 
    
    [[self.m_sbxq_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
        
        UIButton *button = (UIButton *)next;
        @strongify(self)
        [self.lineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button.mas_centerX);
            make.width.equalTo(@60);
            make.height.equalTo(@4);
            make.top.equalTo(self.m_menuBarView.mas_top).offset(2);
        }];
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            @strongify(self)
            [self.m_menuBarView layoutIfNeeded];
            
        }completion:NULL];
        
        [self.mainScrollView setContentOffset:CGPointZero animated:YES];
        
    }];
    
    

    [[self.m_ysjl_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
        
        UIButton *button = (UIButton *)next;
        @strongify(self)
        [self.lineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button.mas_centerX);
            make.width.equalTo(@60);
            make.height.equalTo(@4);
            make.top.equalTo(self.m_menuBarView.mas_top).offset(2);
        }];
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            @strongify(self)
            [self.m_menuBarView layoutIfNeeded];
            
        }completion:NULL];
        //        [self PopYSJL_TemplatesListViewControllerWithZSretDict:nil];
        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width,0} animated:YES];
        
    }];
    
    [[self.m_zs_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
        
        @strongify(self)
        UIButton *button = (UIButton *)next;
        [self.lineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button.mas_centerX);
            make.width.equalTo(@30);
            make.height.equalTo(@4);
            make.top.equalTo(self.m_menuBarView.mas_top).offset(2);
        }];
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            @strongify(self)
            [self.m_menuBarView layoutIfNeeded];
            
        }completion:NULL];
        //        [self PopZS_TemplatesListViewControllerWithZSretDict:nil];
        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*3,0} animated:YES];
        
    }];
    
    
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

-(void)changeLabelStateWithDict:(NSDictionary *) dict
{
    /**
     *  "FZFY": null,
     "FZFZ": null,
     "LYDJ": null,
     "RWLQ": "1,领取人:张健(医化),2014-07-08 13:51:32,2014-07-08 13:52:28",
     "SFDY": null,
     "SFHY": "1,魏宇林(通过),2014-07-08 00:00:00,2014-07-08 00:00:00",
     "SFJD": "1,张健(医化)(已检),2014-07-08 00:00:00",
     "SFPZ": "1,张健(医化)(通过),2014-07-08 00:00:00,2014-07-08 00:00:00",
     "SFSY": null,
     "wtdbh": "1407082031",
     "WTDJ": "张健(医化),2014-07-08 13:51:31",
     "yqid": "5FC074F103524B31972DBEB39DA13AC0",
     "zsbh": "YL95146002"
     */
    

    
    
    
    
    
    
    
}
/**
 *  更新设备详情界面
 *
 */
-(void)update_ggxxViewByDict:(NSDictionary *) dict
{

    self.m_txm_LB.text = [dict[@"txm"] GetNotNullStr];
    self.m_zsh_LB.text = [dict[@"zsbh"] GetNotNullStr];
    self.m_ssks_LB.text = [dict[@"ks"] GetNotNullStr];
    self.m_yqmc_LB.text = [dict[@"yqmc"] GetNotNullStr];
    self.m_ccbh_LB.text = [dict[@"ccbh"] GetNotNullStr];
    self.m_jclx_LB.text = [dict[@"jclx"] GetNotNullStr];
    self.m_sl_LB.text = [dict[@"sl"] GetNotNullStr];
    
    
    self.m_bj_LB.text = [dict[@"bzsf"] GetNotNullStr];
    self.m_jltx_LB.text = [dict[@"jltx"] GetNotNullStr];
    self.m_clfw_LB.text = [dict[@"jcfw"] GetNotNullStr];
    self.m_ggxh_LB.text = [dict[@"ggxh"] GetNotNullStr];
    self.m_sccj_LB.text = [dict[@"sccj"] GetNotNullStr];
    self.m_wg_LB.text = [dict[@"wg"] GetNotNullStr];
    self.m_pj_LB.text = [dict[@"pj"] GetNotNullStr];
    
    self.m_tsyq_LB.text = [dict[@"tsyq"] GetNotNullStr];
    
    self.m_bz_LB.text = [dict[@"bz"] GetNotNullStr];

    [self loadwebView];
    
}

-(void)loadwebView
{
    //设备详情    
//    http://IPaddress:port/lims/web/pages/detectionTask/record-autoc.jsp
    
    [self load_ysjl_WebViewWithjljspmc:self.m_jcrwcx_Model.yqid];
    //证书
//    http://IPaddress:port/lims/web/pages/detectionTask/certificate-autoc.jsp
    
    [self load_zs_WebViewWithjljspmc:self.m_jcrwcx_Model.zsbh];
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
    
    /**
     *  设备信息-流转跟踪
     *  yqid
     */
    //findLiuzhuangz.do
    
        @weakify(self)
    
    [[BaseNetWork getInstance] hideDialog];
    [[[[[BaseNetWork getInstance] rac_postPath:@"findLiuzhuangz.do" parameters:@{@"yqid":[self.m_showDict[@"yqid"] isNotNull]?self.m_showDict[@"yqid"]:@"yqid"}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary *retDict) {
         
         @strongify(self)
         if ([retDict[@"ret"] intValue] == 0)
         {
             
             [self.m_showDialog WarningNotificationWithMessage:@"获取数据失败!"];
             
         }else
         {
             [self changeLabelStateWithDict:retDict[@"yqlzgz"]];
         }
         
     }error:^(NSError *error){
         
     }];

    
    [[BaseNetWork getInstance] hideDialog];
    [[[[[BaseNetWork getInstance] rac_postPath:@"findWtdxxxxByYqid.do" parameters:@{@"yqid":[self.m_jcrwcx_Model.yqid isNotNull]?self.m_jcrwcx_Model.yqid:@"yqid"}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary *retDict) {
         
         @strongify(self)
         if ([retDict[@"ret"] intValue] == 0)
         {
             
             [self.m_showDialog WarningNotificationWithMessage:@"获取数据失败!"];
             
         }else
         {
             [self update_ggxxViewByDict:retDict[@"qjxx"]];
         }
         
     }error:^(NSError *error){
         
     }];
    
    
//    [self update_ggxxViewByYretJcrwcx_Model:self.m_jcrwcx_Model];

}
- (IBAction)BackToVC:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        
    }];
}


/**
 *  原始记录 底部按钮事件
 *
 *  @param sender
 */
- (IBAction)Ysjl_SaveBtnClick:(id)sender {
    
    
    //    [self.m_ysjl_javascriptBridge callHandler:@"hqlssj" data:self.yqid_Str responseCallback:^(id response)
    //     {
    //
    //
    //         debug_object(response);
    //
    //
    //
    //     }];
    
    
    
    @weakify(self)
    id data = @{ @"name": @"杨智",@"title":@"成功了嘛？" };
    [self.m_ysjl_javascriptBridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id response)
     {
         @strongify(self)
         
         [self pasteWithDictStr:response];
         
         
     }];
    
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
                     
                     [Dialog toast:self withMessage:@"保存失败!"];
                     
                 }else
                 {
                     [Dialog toast:self withMessage:@"保存成功!"];
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
                 
                 [Dialog toast:self withMessage:@"保存失败!"];
                 
             }else
             {
                 [Dialog toast:self withMessage:@"保存成功!"];
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
    
    
}

- (IBAction)Ysjl_ghzsmb_btnClick:(id)sender {
    
}


- (IBAction)Ysjl_CancleBtbClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        
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
    
    if ([self.m_zs_retDict[@"UrlStr"] isNotNull]) {
        
        FullScreenPreviewVC *tempLasteVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FullScreenPreviewVC"];
        tempLasteVC.m_urlStr = self.m_zs_retDict[@"UrlStr"] ;
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
        
    }];
}

- (IBAction)m_UpBtnClick:(id)sender {
}


#pragma mark - 代理协议方法*


-(void)load_ysjl_WebViewWithjljspmc:(NSString *) yqid
{
    //175.17.22.241:8080
    
    NSString *webysjlStr = [NSString stringWithFormat:@"http://%@/lims/web/pages/detectionTask/record-autoc.jsp?yqid=%@",WEBURL,yqid];
    
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


//#pragma mark -ZS_TemplatesListVCDelegate
//-(void)ZS_TemplatesListVC:(ZS_TemplatesListViewController *) templatestVC didSelectedOKByObj:(id ) data
//{
//    zsmb_Model *model = (zsmb_Model*)data;
//    
//    debug_object(self.yqid_Str);
//    @weakify(self)
//    [[[[[BaseNetWork getInstance] rac_postPath:@"sczs.do" parameters:@{@"zsmbid":model.m_id,@"yqid":self.yqid_Str}]map:^(id responseData)
//       {
//           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
//           
//           return dict;
//       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
//     subscribeNext:^(NSDictionary *retDict) {
//         @strongify(self)
//         if ([retDict[@"ret"] intValue] == 1) {
//             
//             
//             
//             [self load_zs_WebViewWithjljspmc:retDict[@"zsbh"]];
//             
//         }
//         
//         
//         
//     }error:^(NSError *error){
//         
//         
//     }];
//    
//    
//    
//    
//    
//}
//
//#pragma mark -YSJL_TemplatesListViewController
//-(void)YSJL_TemplatesListVC:(YSJL_TemplatesListViewController *) templatestVC didSelectedOKByObj:(id ) data
//{
//    jlmb_Model *model = (jlmb_Model*)data;
//    /**
//     *   原始记录模板 保存
//     */
//    @weakify(self)
//    [[BaseNetWork getInstance] hideDialog];
//    [[[[[BaseNetWork getInstance] rac_postPath:@"saveJlmb.do" parameters:@{@"dzjlmbID":model.m_id,@"yqid":self.yqid_Str}]map:^(id responseData)
//       {
//           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
//           
//           return dict;
//       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
//     subscribeNext:^(NSDictionary *retDict) {
//         @strongify(self)
//         if ([retDict[@"ret"] intValue] ==1) {
//             //然后再去 为显示记录模板 而获取 显示记录模板的url地址
//             
//             
//             [self load_ysjl_WebViewWithjljspmc:model.jljspmc];
//             
//             
//             
//         }else
//         {
//             [Dialog toast:self withMessage:@"原始记录模板 保存失败!"];
//         }
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
//    
//}
//

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

@end
