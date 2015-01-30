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
#import "TemplatesListViewController.h"
#import "FullScreenPreviewVC.h"
#import "AutoCompleteTextField.h"
#import "Yqmc_Auto_Model.h"
#import "Yqjbxx_Model.h"
#import "dmxx_Model.h"

@interface TestingDataRegistViewController ()<DropDownTextFieldDelegate,DropDownTextFieldDataSource,AutoCompleteTextFieldDataSource,AutoCompleteTextFieldDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property(nonatomic ,strong)UIImageView *lineImgV;

@property (weak, nonatomic) IBOutlet UIView *m_menuBarView;

@property(nonatomic , strong) FullScreenPreviewVC *m_fullScreenVc;

/**
 *  设备详情
 */
@property (weak, nonatomic) IBOutlet UIButton *m_sbxq_Btn;


@property (weak, nonatomic) IBOutlet UITextField *m_txm_TF;

@property (weak, nonatomic) IBOutlet AutoCompleteTextField *m_yqmc_TF;
@property(nonatomic , strong)NSArray *m_autoTFArr;

 //TODO:计量范围应该为 计量特性
@property (weak, nonatomic) IBOutlet UITextField *m_jlfw_TF;


@property (weak, nonatomic) IBOutlet UITextField *m_clfw_TF;

@property (weak, nonatomic) IBOutlet UITextField *m_ggxh_TF;


@property (weak, nonatomic) IBOutlet UITextField *m_sccj_TF;

@property (weak, nonatomic) IBOutlet UITextField *m_ccbh_TF;

@property (weak, nonatomic) IBOutlet DropDownTextField *m_jclx_DTF;
@property(nonatomic , strong)NSArray *m_jclxTFArr;


@property (weak, nonatomic) IBOutlet UITextField *m_sl_TF;

@property (weak, nonatomic) IBOutlet DropDownTextField *m_dw_DTF;
@property(nonatomic , strong)NSArray *m_dwTFArr;

@property (weak, nonatomic) IBOutlet UITextField *m_bj_TF;

@property (weak, nonatomic) IBOutlet UITextField *m_wg_TF;

@property (weak, nonatomic) IBOutlet UITextField *m_xm_TF;

@property (weak, nonatomic) IBOutlet UITextField *m_fj_TF;

@property (weak, nonatomic) IBOutlet UITextField *m_txyq_TF;

@property (weak, nonatomic) IBOutlet UITextView *m_bz_TV;

@property (weak, nonatomic) IBOutlet UIScrollView *m_sbxq_ScrollView;

/**
 *  设备详情
 */
@property(nonatomic ,strong) NSDictionary *m_jcsj_Dict;


/**
 *  公共信息
 */
@property (weak, nonatomic) IBOutlet UIButton *m_ggxx_Btn;

@property (weak, nonatomic) IBOutlet UIScrollView *m_ggxx_ScrollView;


@property (weak, nonatomic) IBOutlet UITableView *m_jlbzkhzsh_TableView;
@property(nonatomic , strong)NSArray *m_jlbzkhzsh_Arr;

@property (weak, nonatomic) IBOutlet UITableView *m_bzqsb_TableView;
@property(nonatomic , strong)NSArray *m_bzqsb_Arr;

@property (weak, nonatomic) IBOutlet UITableView *m_jsyj_TableView;
@property(nonatomic , strong)NSArray *m_jsyj_Arr;


/**
 *  原始记录
 */
@property (weak, nonatomic) IBOutlet UIButton *m_ysjl_Btn;

@property (weak, nonatomic) IBOutlet UIScrollView *m_ysjl_ScrollView;

@property (weak, nonatomic) IBOutlet UIWebView *m_ysjl_WebView;





/**
 *  证书
 */
@property (weak, nonatomic) IBOutlet UIButton *m_zs_Btn;

@property (weak, nonatomic) IBOutlet UIScrollView *m_zs_ScrollView;
@property (weak, nonatomic) IBOutlet UIWebView *m_zs_WebView;


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
    
    _m_Sbxq_saveDataDict[@"usercode"] = user.usercode;
    _m_Sbxq_saveDataDict[@"yqid"] = MBS_XTBS;
    _m_Sbxq_saveDataDict[@"xmbh"] = @"";
    _m_Sbxq_saveDataDict[@"qjytbh"] = @"";
    _m_Sbxq_saveDataDict[@"jdrq"] = @"";
    
    _m_Sbxq_saveDataDict[@"jdzq"] = @"";
    _m_Sbxq_saveDataDict[@"jdzqbh"] = @"";
    _m_Sbxq_saveDataDict[@"hjwd"] = @"";
    _m_Sbxq_saveDataDict[@"hjsd"] = @"";
    _m_Sbxq_saveDataDict[@"jdrbh"] = @"";
    
    _m_Sbxq_saveDataDict[@"hyrbh"] = @"";
    _m_Sbxq_saveDataDict[@"pzrbh"] = @"";
    _m_Sbxq_saveDataDict[@"jddd"] = @"";
    _m_Sbxq_saveDataDict[@"jszt"] = @"";
    _m_Sbxq_saveDataDict[@"qt"] = @"";
    
    _m_Sbxq_saveDataDict[@"jlbzkhzsID"] = @"";
    _m_Sbxq_saveDataDict[@"bzsbbhs"] = @"";
    _m_Sbxq_saveDataDict[@"syzshs"] = @"";
    _m_Sbxq_saveDataDict[@"jsyjID"] = @"";

}

-(void)reset_Sbxq_SaveDict
{
    
    LoginedUser *user = [LoginedUser sharedInstance];
    
    _m_Sbxq_saveDataDict[@"rwbh"] = @"";
    _m_Sbxq_saveDataDict[@"xtbs"] = MBS_XTBS;
    _m_Sbxq_saveDataDict[@"usercode"] = user.usercode;
    _m_Sbxq_saveDataDict[@"HYLBMC"] = @"";
    _m_Sbxq_saveDataDict[@"txm"] = @"";
    _m_Sbxq_saveDataDict[@"yqmc"] = @"";
    _m_Sbxq_saveDataDict[@"ksbh"] = @"";
    _m_Sbxq_saveDataDict[@"ks"] = @"";
    _m_Sbxq_saveDataDict[@"jltx"] = @"";
    _m_Sbxq_saveDataDict[@"xmbh"] = @"";
    _m_Sbxq_saveDataDict[@"jcfw"] = @"";
    _m_Sbxq_saveDataDict[@"ggxh"] = @"";
    _m_Sbxq_saveDataDict[@"sccj"] = @"";
    _m_Sbxq_saveDataDict[@"ccbh"] = @"";
    _m_Sbxq_saveDataDict[@"jclxbh"] = @"";
    _m_Sbxq_saveDataDict[@"jclx"] = @"";
    _m_Sbxq_saveDataDict[@"sl"] = @"";
    _m_Sbxq_saveDataDict[@"bzsf"] = @"";
    _m_Sbxq_saveDataDict[@"bzsfbh"] = @"";
    _m_Sbxq_saveDataDict[@"wg"] = @"";
    _m_Sbxq_saveDataDict[@"pj"] = @"";
    _m_Sbxq_saveDataDict[@"bz"] = @"";
    _m_Sbxq_saveDataDict[@"jdzqbh"] = @"";
    _m_Sbxq_saveDataDict[@"by1"] = @"";
    _m_Sbxq_saveDataDict[@"by2"] = @"";
    _m_Sbxq_saveDataDict[@"sfsq"] = @"";

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self update_sbxqViewByDict:_m_qjxxDict];
    
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
    
    self.m_jclx_DTF.dropDownDelegate = self;
    self.m_jclx_DTF.dropDownDataSource= self;
    self.m_jclx_DTF.delegate = self;
    
    self.m_dw_DTF.dropDownDelegate = self;
    self.m_dw_DTF.dropDownDataSource= self;
    self.m_dw_DTF.delegate = self;
    
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
                        make.centerX.equalTo(self.m_ggxx_Btn.mas_centerX);
                        make.width.equalTo(@60);
                        break;
                        
                    case 2:
                        make.centerX.equalTo(self.m_ysjl_Btn.mas_centerX);
                        make.width.equalTo(@60);
                        [self PopTemplatesListViewControllerWithTemplatesListType:RecordType];
                        break;
                        
                    case 3:
                        make.centerX.equalTo(self.m_zs_Btn.mas_centerX);
                        make.width.equalTo(@30);
                        [self PopTemplatesListViewControllerWithTemplatesListType:CertificateType];
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

    [[self.m_sbxq_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
        
        @strongify(self)
        [self updateLineConstraints:next];
        
        [self.mainScrollView setContentOffset:CGPointZero animated:YES];
        
    }];
    
    
    [[self.m_ggxx_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
        @strongify(self)
        [self updateLineConstraints:next];
        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width,0} animated:YES];
        
    }];
    
    [[self.m_ysjl_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
        
        @strongify(self)
        [self updateLineConstraints:next];
        [self PopTemplatesListViewControllerWithTemplatesListType:RecordType];
        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:YES];
        
    }];
    
    [[self.m_zs_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
        
        @strongify(self)
        [self updateLineConstraints:next];
        [self PopTemplatesListViewControllerWithTemplatesListType:CertificateType];
        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*3,0} animated:YES];
        
    }];
    
    
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
         
         self.m_dwTFArr = [arr linq_select:^id(NSDictionary *dict){
             
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

    
    /**
     *  获取单位名称
     */
    [[BaseNetWork getInstance] hideDialog];
    [[[[[BaseNetWork getInstance] rac_postPath:@"findDmxx.do" parameters:@{@"zdbm":@"dw"}]map:^(id responseData)
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
 *  TODO:需要把dwbh 改成by2
 *  by2  数量单位编号  ,    findJiliangqjByTxm.do : dwbh
 *
 */
-(void)update_sbxqViewByDict:(NSDictionary *) sbxqDict
{
    
     self.m_txm_TF.text =  [sbxqDict GetLabelWithKey:@"txm"];
    self.m_yqmc_TF.text =  [sbxqDict GetLabelWithKey:@"yqmc"];
    
    // TODO: **注意意思这块是通过 findJiliangqjByTxm.do 扫描条码获取到得 ，需要把dwbh 改成by2
    self.m_yqmc_TF.m_bm = [sbxqDict GetLabelWithKey:@"dwbh"];
    
     //TODO:需修改字段 计量特性
    self.m_jlfw_TF.text =  [sbxqDict GetLabelWithKey:@"jltx"];
    
    self.m_jclx_DTF.m_bm = [sbxqDict GetLabelWithKey:@"jclxbh"];
    
    //TODO:需修改字段
    self.m_clfw_TF.text =  [sbxqDict GetLabelWithKey:@"jcfw"];
    
    self.m_ggxh_TF.text =  [sbxqDict GetLabelWithKey:@"ggxh"];
    
    self.m_sccj_TF.text =  [sbxqDict GetLabelWithKey:@"sccj"];
    self.m_ccbh_TF.text =  [sbxqDict GetLabelWithKey:@"ccbh"];
    //通过条形码得到数据 by4 是指的检测类型
    self.m_jclx_DTF.text =  [sbxqDict GetLabelWithKey:@"by4"];
    
    self.m_sl_TF.text =  [sbxqDict GetLabelWithKey:@"sl"];
    self.m_dw_DTF.text =  [sbxqDict GetLabelWithKey:@"wtdw"];
    self.m_dw_DTF.m_bm =  [sbxqDict GetLabelWithKey:@"wtdwbh"];
    
    self.m_bj_TF.text =  [sbxqDict GetLabelWithKey:@"bj"];
    self.m_wg_TF.text =  [sbxqDict GetLabelWithKey:@"wg"];
    self.m_xm_TF.text =  [sbxqDict GetLabelWithKey:@"xmmc"];
    self.m_fj_TF.text =  [sbxqDict GetLabelWithKey:@"pj"];
    self.m_bz_TV.text =  [sbxqDict GetLabelWithKey:@"bz"];

}

/**
 *  更新设备详情界面
 *
 */
-(void)update_sbxqViewByYqjbxx_Model:(Yqjbxx_Model *) sbxqDict
{
   
    self.m_yqmc_TF.text =  [sbxqDict.jlqjmc GetNotNullStr];
    //TODO:需修改字段
    self.m_jlfw_TF.text =  [sbxqDict.clfw GetNotNullStr];
    //TODO:计量范围应该为 计量特性
    self.m_clfw_TF.text =  [sbxqDict.jltx GetNotNullStr];
    self.m_ggxh_TF.text =  [sbxqDict.ggxh GetNotNullStr];
     //TODO:生产厂家
    self.m_sccj_TF.text =  [sbxqDict.jlqjmc GetNotNullStr];
    
     //TODO:出厂编号
    self.m_ccbh_TF.text =  [sbxqDict.jlqjmc GetNotNullStr];
    //TODO:需修改字段
    self.m_jclx_DTF.text =  [sbxqDict.jclx GetNotNullStr];
    self.m_jclx_DTF.m_bm = [sbxqDict.jclxbh GetNotNullStr];
    
    self.m_sl_TF.text =  [sbxqDict.jlqjmc GetNotNullStr];
    
    self.m_dw_DTF.text =  [sbxqDict.dw GetNotNullStr];
    self.m_dw_DTF.m_bm =  [sbxqDict.dwbh GetNotNullStr];
    
    self.m_bj_TF.text =  [sbxqDict.bj GetNotNullStr];
    
    //TODO:需要要求添加 项目字段代替
    self.m_xm_TF.text =  [sbxqDict.xmbh GetNotNullStr];
    
    //TODO:外观
    self.m_wg_TF.text = [sbxqDict.xmbh GetNotNullStr];
    //TODO:需修改字段 需确认
    self.m_fj_TF.text =  [sbxqDict.by5 GetNotNullStr];
//    //TODO:需修改字段
//    self.m_txyq_TF.text =  [sbxqDict.jlqjmc GetNotNullStr];
//    self.m_bz_TV.text =  [sbxqDict.jlqjmc GetNotNullStr];
    
}

//layoutMainCustomView
-(void)PopTemplatesListViewControllerWithTemplatesListType:(TemplatesListType )type
{
    TemplatesListViewController *tempLasteVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TemplatesListViewController"];
    tempLasteVC.m_templatesType = type;
    tempLasteVC.modalPresentationStyle = UIModalPresentationFormSheet;
    tempLasteVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:tempLasteVC animated:YES completion:nil];
    
    
    
}
/**
 *  获取  的数据
 */
-(void)loadNetData
{
//    @weakify(self)
//    [[BaseNetWork getInstance] showDialogWithVC:self];
//    NSDictionary *dict =@{@"txm":@"140000009"};
//    [[[[[BaseNetWork getInstance] rac_postPath:@"findJiliangqjByTxm.do" parameters:dict]map:^(id responseData)
//       {
//           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
//           
//           return [dict valueForKeyPath:@"qjxx"];
//       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
//     subscribeNext:^(NSDictionary *retDict) {
//         
//         @strongify(self)
//         [self update_sbxqViewByDict:retDict];
//         
//
//         
//     }error:^(NSError *error){
//    
//         
//         
//     }];
    
//    usercode=1114&yqid=EF83462867CE4727BEE9BEA253E15B3E
    
    LoginedUser *loginUsr = [LoginedUser sharedInstance];
    
    @weakify(self)
    [[BaseNetWork getInstance] showDialogWithVC:self];
    NSDictionary *dict =@{@"usercode":loginUsr.usercode,@"yqid":@"8914CE467ADE4DE4863BF59C64BF04B8"};
    [[[[[BaseNetWork getInstance] rac_postPath:@"initDetectionDataRegistration.do" parameters:dict]map:^(id responseData)
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
                                     
                                     return model;
                                 }];
         
         self.m_bzqsb_Arr = [bzqsbArr
                             linq_select:^id(NSDictionary *dict)
                             {
                                 
                                 Bzqsb_Model *model = [MTLJSONAdapter modelOfClass:[Bzqsb_Model class] fromJSONDictionary:dict error:nil];
                                 
                                 return model;
                             }];
         
         self.m_jsyj_Arr = [jsyjArr
                            linq_select:^id(NSDictionary *dict)
                            {
                                
                                Jsyj_Model *model = [MTLJSONAdapter modelOfClass:[Jsyj_Model class] fromJSONDictionary:dict error:nil];
                                
                                return model;
                            }];
         
         
         [self.m_jlbzkhzsh_TableView reloadData];
         [self.m_bzqsb_TableView reloadData];
         [self.m_jsyj_TableView reloadData];
         
         
     }error:^(NSError *error){
         
         
         
     }];
    
    
    
    
    self.m_ysjl_WebView.scrollView.scrollEnabled = NO;
    [self.m_ysjl_WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.10.169:8080/lims/web/pages/detectionTask/record-addc.jsp?yqid=5F96662544EA4D769784B663BFC521F9&jljspmc=1005522"]]];
    
    [self.m_zs_WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.10.169:8080/lims/web/pages/detectionTask/record-addc.jsp?yqid=5F96662544EA4D769784B663BFC521F9&jljspmc=1005522"]]];
    
    

    
}
- (IBAction)BackToVC:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:^(void){
       
        
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
    
    
    [self saveData];
    
    //    @weakify(self)
    [[BaseNetWork getInstance] hideDialog];
    [[[[[BaseNetWork getInstance] rac_postPath:@"addEquipment.do" parameters:_m_Sbxq_saveDataDict]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return [dict valueForKeyPath:@"ret"];
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSString *retStr) {
         
         if ([retStr intValue] == 1) {
             [Dialog toast:self withMessage:@"保存成功！"];
         }else
         {
             [Dialog toast:self withMessage:@"保存失败！"];
         }
         
         
         
     }error:^(NSError *error){
         
         
         
     }];
}

- (IBAction)Sbxq_CancleBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        
    }];

}



- (IBAction)Sbxq_NextStepBtnClick:(id)sender {
    
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
    
    
    
    [self saveData];
    
    //    @weakify(self)
    [[BaseNetWork getInstance] hideDialog];
    [[[[[BaseNetWork getInstance] rac_postPath:@"saveDdrTojson.do" parameters:_m_Ggxx_saveDataDict]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return [dict valueForKeyPath:@"ret"];
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSString *retStr) {
         
         if ([retStr intValue] == 1) {
             [Dialog toast:self withMessage:@"保存成功！"];
         }else
         {
             [Dialog toast:self withMessage:@"保存失败！"];
         }
         
         
         
     }error:^(NSError *error){
         
         
         
     }];
    
}

- (IBAction)Ggxx_CancleBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        
    }];

}

- (IBAction)Ggxx_NextStepBtnClick:(id)sender {
    
    
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
    
    
    [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width,0} animated:YES];
    
}


/**
 *  原始记录 底部按钮事件
 *
 *  @param sender
 */
- (IBAction)Ysjl_SaveBtnClick:(id)sender {
}
- (IBAction)Ysjl_CancleBtbClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        
    }];

}

- (IBAction)Ysjl_NextStepBtnClick:(id)sender {
    
    
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
    
     [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:YES];
    
    
}

/**
 *  证书 底部按钮事件
 *
 *  @param sender
 */
- (IBAction)Zs_SaveBtnClick:(id)sender {
}

- (IBAction)Zs_CancleBtnClick:(id)sender {
}


- (IBAction)FullScreenPreviewBtnClick:(id)sender {
    
    
//    FullScreenPreviewVC
    
    FullScreenPreviewVC *tempLasteVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FullScreenPreviewVC"];
    tempLasteVC.modalPresentationStyle = UIModalPresentationFormSheet;
    tempLasteVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:tempLasteVC animated:YES completion:^(void){
       
        
//        /**
//         点击webview页面两次就会隐藏
//         */
//        @strongify(self)
//        
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
//        tapGesture.numberOfTapsRequired  = 2;
//        
//        [tempLasteVC.m_webView.superview addGestureRecognizer:tapGesture];
//        
//        self.m_fullScreenVc = tempLasteVC;

    }];
    
    
    
}

- (void)tapClick:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.m_fullScreenVc dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}

- (IBAction)m_UpBtnClick:(id)sender {
}


-(void)saveData
{
    //测试用的任务编号
    //8bb405f2714e4c71ab4acf77179d67f1
    self.m_Sbxq_saveDataDict[@"rwbh"] = @"8bb405f2714e4c71ab4acf77179d67f1";// [self.m_showDict GetLabelWithKey:@"RWBH"];
    self.m_Sbxq_saveDataDict[@"txm"] = [_m_txm_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"yqmc"] = [_m_yqmc_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"ksbh"] = [_m_qjxxDict GetLabelWithKey:@"ksbh"];
    self.m_Sbxq_saveDataDict[@"ks"] = [_m_qjxxDict GetLabelWithKey:@"ksbh"];
    self.m_Sbxq_saveDataDict[@"jltx"] = [_m_jlfw_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"xmbh"] = [_m_qjxxDict GetLabelWithKey:@"xmbh"];
    self.m_Sbxq_saveDataDict[@"jcfw"] = [_m_clfw_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"ggxh"] = [_m_ggxh_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"sccj"] = [_m_sccj_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"ccbh"] = [_m_ccbh_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"jclxbh"] = [_m_jclx_DTF.m_bm GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"jclx"] = [_m_jclx_DTF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"sl"] = [_m_sl_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"bzsf"] = [_m_qjxxDict GetLabelWithKey:@"bzsf"];
    self.m_Sbxq_saveDataDict[@"bzsfbh"] = [_m_qjxxDict GetLabelWithKey:@"bzsfbh"];
    self.m_Sbxq_saveDataDict[@"wg"] = [_m_wg_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"pj"] = [_m_sl_TF.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"bz"] = [_m_bz_TV.text GetNotNullStr];
    self.m_Sbxq_saveDataDict[@"jdzqbh"] = [_m_qjxxDict GetLabelWithKey:@"jdzqbh"];
    self.m_Sbxq_saveDataDict[@"by1"] = [_m_dw_DTF.text GetNotNullStr];
    
    //单位编号
    self.m_Sbxq_saveDataDict[@"by2"] = [_m_dw_DTF.m_bm GetNotNullStr];
    
    //TODO:先默认授权把
    self.m_Sbxq_saveDataDict[@"sfsq"] = @"0";
    
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
    }
    return nil;
}


 #pragma mark - DropDownTextFieldDelegate

-(void)dropDownTextField:(DropDownTextField *)textField didSelectedWithData:(id<DropDownTextFieldShowCellTextLabel>) data forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (textField == _m_jclx_DTF) {
         dmxx_Model *model = _m_jclxTFArr[indexPath.row];
        
        self.m_jclx_DTF.m_bm = model.dmxxmc;
        
        [self.m_Sbxq_saveDataDict setObject:model.dmxxmc forKey:@"jclxbh"];
         [self.m_Sbxq_saveDataDict setObject:model.dmbm forKey:@"jclx"];
    
    }else if(textField == _m_dw_DTF) {
        
        dmxx_Model *model = _m_dwTFArr[indexPath.row];
        
        self.m_dw_DTF.m_bm = model.dmxxmc;
        
         [self.m_Sbxq_saveDataDict setObject:model.dmxxmc forKey:@"by1"];
         [self.m_Sbxq_saveDataDict setObject:model.dmbm forKey:@"by2"];
        
    }
    
    
}

#pragma  mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _m_jclx_DTF) {
        return NO;
        
    }else if(textField == _m_dw_DTF) {
        
         return NO;
        
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
    return self.m_autoTFArr;
}

#pragma mark - AutoCompleteTextFieldDelegate
- (void)autoCompleteTextField:(AutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<AutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    
    
}


@end
