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

@interface TestingDataRegistViewController ()<DropDownTextFieldDelegate,DropDownTextFieldShowCellTextLabel>

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property(nonatomic ,strong)UIImageView *lineImgV;

@property (weak, nonatomic) IBOutlet UIView *m_menuBarView;

/**
 *  设备详情
 */
@property (weak, nonatomic) IBOutlet UIButton *m_sbxq_Btn;


@property (weak, nonatomic) IBOutlet UITextField *m_txm_TF;

@property (weak, nonatomic) IBOutlet UITextField *m_yqmc_TF;

@property (weak, nonatomic) IBOutlet UITextField *m_jlfw_TF;


@property (weak, nonatomic) IBOutlet UITextField *m_clfw_TF;

@property (weak, nonatomic) IBOutlet UITextField *m_ggxh_TF;


@property (weak, nonatomic) IBOutlet UITextField *m_sccj_TF;

@property (weak, nonatomic) IBOutlet UITextField *m_ccbh_TF;

@property (weak, nonatomic) IBOutlet DropDownTextField *m_jclx_DTF;

@property (weak, nonatomic) IBOutlet UITextField *m_sl_TF;

@property (weak, nonatomic) IBOutlet DropDownTextField *m_dw_DTF;

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


@end

@implementation TestingDataRegistViewController

#pragma mark - 系统方法
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
                        break;
                        
                    case 3:
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
        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:YES];
        
    }];
    
    [[self.m_zs_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
        
        @strongify(self)
        [self updateLineConstraints:next];
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
-(void)update_sbxqViewByDict:(NSDictionary *) sbxqDict
{
    
     self.m_txm_TF.text =  [sbxqDict GetLabelWithKey:@"txm"];
    self.m_yqmc_TF.text =  [sbxqDict GetLabelWithKey:@"yqmc"];
    self.m_jlfw_TF.text =  [sbxqDict GetLabelWithKey:@"jlfw"];
    //TODO:需修改字段
    self.m_clfw_TF.text =  [sbxqDict GetLabelWithKey:@"clfw"];
    self.m_ggxh_TF.text =  [sbxqDict GetLabelWithKey:@"ggxh"];
    self.m_sccj_TF.text =  [sbxqDict GetLabelWithKey:@"sccj"];
    self.m_ccbh_TF.text =  [sbxqDict GetLabelWithKey:@"ccbh"];
    //TODO:需修改字段
    self.m_jclx_DTF.text =  [sbxqDict GetLabelWithKey:@"jclx"];
    self.m_sl_TF.text =  [sbxqDict GetLabelWithKey:@"sl"];
    self.m_dw_DTF.text =  [sbxqDict GetLabelWithKey:@"wtdw"];
    self.m_bj_TF.text =  [sbxqDict GetLabelWithKey:@"bj"];
    self.m_wg_TF.text =  [sbxqDict GetLabelWithKey:@"wg"];
    self.m_xm_TF.text =  [sbxqDict GetLabelWithKey:@"xmmc"];
    //TODO:需修改字段
    self.m_fj_TF.text =  [sbxqDict GetLabelWithKey:@"fj"];
    //TODO:需修改字段
    self.m_txyq_TF.text =  [sbxqDict GetLabelWithKey:@"tsyq"];
    self.m_bz_TV.text =  [sbxqDict GetLabelWithKey:@"bz"];

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
    @weakify(self)
    [[BaseNetWork getInstance] showDialogWithVC:self];
    NSDictionary *dict =@{@"usercode":@"1114",@"yqid":@"EF83462867CE4727BEE9BEA253E15B3E"};
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
    

    
}
- (IBAction)BackToVC:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:^(void){
       
        
    }];
}


- (IBAction)CancleClick:(id)sender {
}


- (IBAction)SaveClick:(id)sender {
}

- (IBAction)NextStepClick:(id)sender {
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



#pragma mark - DropDownTextFieldShowCellTextLabel
/**
 *  用于显示tableviewcell的数据，光显示一个text
 *
 *  @return textlabel要显示的数据
 */
- (NSString *)getShowCellForTextLabel
{
    return @"asdf";
}




 #pragma mark - DropDownTextFieldDelegate

-(void)dropDownTextField:(DropDownTextField *)textField didSelectedWithData:(id<DropDownTextFieldShowCellTextLabel>) data forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.y &gt; 0 scrollView.contentOffset.y &lt; 0 ) scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
//}

@end
