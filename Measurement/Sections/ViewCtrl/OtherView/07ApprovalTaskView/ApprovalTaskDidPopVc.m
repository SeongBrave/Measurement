//
//  ApprovalTaskDidPopVc.m
//  Measurement
//
//  Created by DTSoft on 15/3/9.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "ApprovalTaskDidPopVc.h"
#import "FullScreenPreviewVC.h"
#import "WebViewJavascriptBridge.h"
#import "SBJson4Parser.h"
#import "ZS_TemplatesListViewController.h"
#import "YSJL_TemplatesListViewController.h"
#import "DropDownTextField.h"
#import "hyjg_model.h"

@interface ApprovalTaskDidPopVc ()<DropDownTextFieldDelegate,DropDownTextFieldDataSource,UITextFieldDelegate,ZS_TemplatesListVCDelegate,YSJL_TemplatesListVCDelegate,UIWebViewDelegate>

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

@property (weak, nonatomic) IBOutlet UILabel *m_wtdw_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_dwmc_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_txm_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_yqmc_LB;
@property (weak, nonatomic) IBOutlet UILabel *ggxh_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_scbh_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_lb_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_jcjg_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_jlh_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_jllb_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_zsh_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_zslb_LB;

/**
 *  原始记录
 */
@property (weak, nonatomic) IBOutlet UIButton *m_hy_hyItem_Btn;
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

/**
 *  核验
 */
@property (weak, nonatomic) IBOutlet UIScrollView *m_hy_scrollView;

@property (weak, nonatomic) IBOutlet UILabel *m_hy_hyr_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_hy_hysj_LB;

@property (weak, nonatomic) IBOutlet DropDownTextField *m_hy_hyjg_DTF;
@property(nonatomic , strong)NSArray *m_hyjgTFArr;

@property (weak, nonatomic) IBOutlet UITextView *m_bz_Tv;
@property (weak, nonatomic) IBOutlet UIButton *m_hy_qx_Btn;
@property (weak, nonatomic) IBOutlet UIButton *m_hy_tj_Btn;

@property (strong, nonatomic) NSMutableDictionary  *m_hy_saveDict;


@end

@implementation ApprovalTaskDidPopVc

#pragma mark - 系统方法

-(NSMutableDictionary *)m_hy_saveDict
{
    if ( _m_hy_saveDict == nil) {
        _m_hy_saveDict = [[NSMutableDictionary alloc]init];
        [self reset_m_hy_saveDict];
        
    }
    
    return _m_hy_saveDict;
}

-(void)reset_m_hy_saveDict
{
    LoginedUser *usr = [LoginedUser sharedInstance];
    
    //TODO:界面显示信息
    _m_hy_saveDict[@"usercode"] = usr.usercode;
    _m_hy_saveDict[@"yqid"] = @"";
    _m_hy_saveDict[@"hyjg"] = @"";
    _m_hy_saveDict[@"hybz"] = @"";
    
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
    
    self.m_hy_hyjg_DTF.dropDownDataSource = self;
    self.m_hy_hyjg_DTF.dropDownDelegate = self;
     self.m_hy_hyjg_DTF.delegate = self;
    self.m_hy_hyjg_DTF.required = YES;
    
    
    hyjg_model *model2 = [[hyjg_model alloc]init];
    
    model2.m_showTitle = @"批准通过";
    model2.m_code = @"1";
    
    hyjg_model *model3 = [[hyjg_model alloc]init];
    
    model3.m_showTitle = @"批准未通过";
    model3.m_code = @"0";
    
    self.m_hyjgTFArr = @[model2,model3];
   
    
    
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
    
    
    self.m_bz_Tv.layer.borderWidth = 2.0;
    self.m_bz_Tv.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
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
        else if (offset.x >= self.view.frame.size.width*3){
            [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*3,0} animated:NO];
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
                    case 3:
                        make.centerX.equalTo(self.m_hy_hyItem_Btn.mas_centerX);
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
        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:YES];
        
    }];
    
    
    [[self.m_hy_hyItem_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
        
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

/**
 *  更新设备详情界面
 *
 */
-(void)update_sbxxViewByDict:(Jcrwcx_Model *) model
{
    
    
    self.m_hy_saveDict[@"yqid"]  = [model.yqid GetNotNullStr];
    
    
    LoginedUser *usr = [LoginedUser sharedInstance];
    
    self.m_hy_hyr_LB.text = usr.username;
    
    
    // 将NSDate格式装换成NSString类型
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    // 设置日历显示格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // 把日历时间传给字符串
    
    NSString *strDate = [dateFormatter stringFromDate:[NSDate new]];
    
    self.m_hy_hysj_LB.text = strDate;
    
    
    self.m_wtdw_LB.text = [model.wtdbh GetNotNullStr];
    
    self.m_dwmc_LB.text = [model.wtdw GetNotNullStr];
    
    self.m_txm_LB.text = [model.txm GetNotNullStr];
    
    self.m_yqmc_LB.text = [model.yqmc GetNotNullStr];
    
    self.ggxh_LB.text = [model.ggxh GetNotNullStr];
    
    self.m_scbh_LB.text = [model.ccbh GetNotNullStr];
    
  
    self.m_lb_LB.text = [model.jclx GetNotNullStr];
    self.m_jcjg_LB.text = [model.jdjg GetNotNullStr];
    
    self.m_jlh_LB.text = [model.jllx GetNotNullStr];
    
    self.m_zsh_LB.text = [model.zsbh GetNotNullStr];
    
    self.m_zslb_LB.text = [model.by1 GetNotNullStr];
    
    [self loadwebView];
    
}

-(void)loadwebView
{
    //设备详情
    //    http://IPaddress:port/lims/web/pages/detectionTask/record-autoc.jsp
    
    [self load_ysjl_WebViewWithjljspmc:self.jcrwcxModel.yqid];
    //证书
    //    http://IPaddress:port/lims/web/pages/detectionTask/certificate-autoc.jsp
    
    [self load_zs_WebViewWithjljspmc:self.jcrwcxModel.zsbh];
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
    [self update_sbxxViewByDict:self.jcrwcxModel];
    
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
- (IBAction)hy_qx_BtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)hy_tj_BtnClick:(id)sender {
    
    if (![self.m_hy_hyjg_DTF validate]) {
        [self.m_hy_hyjg_DTF verifyshowDropDownTableView];
        [self.m_showDialog WarningNotificationWithMessage:@"请补全信息!"];
        
    }else
    {
        self.m_hy_saveDict[@"hybz"] = self.m_bz_Tv.text;
        
        //    bchyjg.do
        //    @weakify(self)
        [[[[[BaseNetWork getInstance] rac_postPath:@"bcpzjg.do" parameters:self.m_hy_saveDict]map:^(id responseData)
           {
               NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
               
               return dict;
           }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
         subscribeNext:^(NSDictionary *retDict) {
             
             self.m_ysjl_retDict = retDict;
             
             if ([retDict[@"ret"] intValue] == 0)
             {
                 
                 [Dialog toastError:@"批准失败!"];
                 
             }else
             {
                 [Dialog toastSuccess:@"批准成功！"];
             }
             
         }error:^(NSError *error){
             
             
         }];
        

        
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


#pragma  mark - DropDownTextFieldDataSource
-(NSArray *)dropDownTextFieldDataSourceTextField:(DropDownTextField *)textField;

{
    
    if (textField == _m_hy_hyjg_DTF) {
        
        return _m_hyjgTFArr;
        
    }
    
    return nil;
}


#pragma mark - DropDownTextFieldDelegate

-(void)dropDownTextField:(DropDownTextField *)textField didSelectedWithData:(id<DropDownTextFieldShowCellTextLabel>) data forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (textField == _m_hy_hyjg_DTF) {
        
        hyjg_model *model = self.m_hyjgTFArr[indexPath.row];
        
        self.m_hy_saveDict[@"hyjg"] = model.m_code;
        
    }
    
}

#pragma  mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _m_hy_hyjg_DTF) {
        return NO;
        
    }else
    {
        return YES;
    }
    
}


@end
