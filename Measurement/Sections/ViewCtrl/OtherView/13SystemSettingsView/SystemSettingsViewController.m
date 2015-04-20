//
//  SystemSettingsViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/23.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "SystemSettingsViewController.h"
#import"MMPlaceHolder.h"
#import "NSDictionary+GetNotNilValue.h"

@interface SystemSettingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *m_bb_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_lqsj_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_sbmc_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_lqr_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_lqks_LB;

@property (weak, nonatomic) IBOutlet UISwitch *m_zdgx_SW;

@property (weak, nonatomic) IBOutlet UIButton *m_jcgx_Btn;

@end

@implementation SystemSettingsViewController

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"系统设置";

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.view  showPlaceHolder];
    
    /**
     *  如果是自动更新则为选中状态否则未选中
     */
    if ([[FileHelpers GetDataFromNSUserDefaultsWithKey:IS_AUTOUPDATEKEY] boolValue]) {
        
        self.m_zdgx_SW.on = YES;
    }else
    {
        self.m_zdgx_SW.on = NO;
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (IBAction)zdgx_Changed:(id)sender {
    
    UISwitch *myswitch = (UISwitch *) sender;
    
    if ([myswitch isOn]) {
        
        [FileHelpers SaveDataWithNSUserDefaultsForData:@1 andWithKey:IS_AUTOUPDATEKEY];
        
        
    }else
    {
        [FileHelpers SaveDataWithNSUserDefaultsForData:@0 andWithKey:IS_AUTOUPDATEKEY];
    }
}

#pragma mark - 自定义方法


- (IBAction)backToVCBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}
- (IBAction)exitBtnClick:(id)sender {
    
    
    
    
    
    [self dismissViewControllerAnimated:NO completion:^(void){
        
        
        NSNotification *notification = [NSNotification notificationWithName:@"TCDL" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
    
    
    
}
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
    
    //获取设备信息
    //获取版本号
    NSString *version = [[FileHelpers getMyAppVersionInfo] objectForKey:@"version"];
    
    self.m_bb_LB.text = version;
    //    隐藏多余行的分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
//     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"popup-ret1urn"] landscapeImagePhone:[UIImage imageNamed:@"popup-retu1rn"] style:UIBarButtonItemStylePlain target:self action:@selector(backToVCBtnClick:)];
    
    
    UIButton *backButton = [UIButton buttonWithType:101];
    [backButton addTarget:self action:@selector(backToVCBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setFrame:CGRectMake(0, 0, 45, 15)];
//    [backButton setImage:[UIImage imageNamed:@"popup-return"] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;

    
    self.tableView.allowsSelection = NO;
}

/**
 *  添加rac检测
 */
-(void)Add_RAC_Attention
{
    
    [[self.m_jcgx_Btn
      rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(UIButton *jcgx){
        
         [self AutoUpdate];
    }error:^(NSError *error){
        
    }];
    
}
-(void)AutoUpdate
{
    //    IS_AUTOUPDATEKEY
    
    
    //获取设备信息
    UIDevice *device = [UIDevice currentDevice];
    
    NSUUID* identifier = device.identifierForVendor;
    
    //    66B88D8C-6AE8-45E6-9E2E-4AF5016B4C91
    
    //获取版本号
    NSString *version = [[FileHelpers getMyAppVersionInfo] objectForKey:@"version"];
    
    //获取ip地址
    //    NSString *adviceIP = [GetAdeviceIP getIPAddress:YES];
    
    //    findBbgx.do
    NSDictionary *dict =@{@"bbh":version,@"sbbh":identifier.UUIDString};
    
    [[[BaseNetWork getInstance] rac_postPath:@"findBbgx.do" parameters:dict]
     subscribeNext:^(id responseData){
         
         NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
         
         if(dict[@"ret"])
         {
             
             NSDictionary * bbxxDict = dict[@"bbxx"];
             if (![bbxxDict[@"bbh"]isEqualToString:bbxxDict[@"bbhx"]]) {
                 
                 UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:bbxxDict[@"message"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                 [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
                     if ([indexNumber intValue] == 1) {
                       
                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:bbxxDict[@"url"]]];
                         
                     }
                 }];
                 [alertView show];
                 
             }
         }
         
     }error:^(NSError *error){
         
         debug_object(error);
         
     }];
    
}
/**
 *  获取  的数据
 */
-(void)loadNetData
{
    LoginedUser *usr = [LoginedUser sharedInstance];
    
    //获取设备信息
    UIDevice *device = [UIDevice currentDevice];
    
    NSUUID* identifier = device.identifierForVendor;
    @weakify(self)
    /**
     *  获取检测进度数据
     */
    [[BaseNetWork getInstance] hideDialog];
    [[[[[BaseNetWork getInstance] rac_postPath:@"initSysSet.do" parameters:@{@"usercode":usr.usercode,@"sbbh":identifier.UUIDString}]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return dict;
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSDictionary  *retDict) {
         
          @strongify(self)
         if ([retDict[@"ret"] integerValue] == 1) {
            
             NSDictionary *xtxxDict = [retDict valueForKeyPath:@"xtxx.sbxx"];
            
             self.m_lqsj_LB.text = [xtxxDict GetNotNilValueByKey:@"lqsj"];
             self.m_sbmc_LB.text = [xtxxDict GetNotNilValueByKey:@"sbmc"];
             self.m_lqr_LB.text = [xtxxDict GetNotNilValueByKey:@"lqr"];
             self.m_lqks_LB.text = [xtxxDict GetNotNilValueByKey:@"lqks"];
             
         }else
         {
             self.m_lqsj_LB.text = @"";
             self.m_sbmc_LB.text = @"";
             self.m_lqr_LB.text = @"";
             self.m_lqks_LB.text = @"";
         }
  
         
         
     }error:^(NSError *error){
         
         
     }];
    

    
}

#pragma mark - 代理协议方法*
/**
 *  超级牛x的隐藏 键盘的方法
 *
 *  @param touches
 *  @param event
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


//#pragma mark Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//    return 0;
//}
///*
// -(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
// {
// 
// return nil;
// }
// 
// -(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
// {
// 
// return nil;
// }
// -(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
// {
// return 0;
// }
// 
// 
// - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
// 
// return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
// 
// }
// 
// 
// - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
// {
// return @"";
// 
// }*/
//#pragma mark - UITableView Delegate
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    
//    static NSString *cellIdentifier = @"certificate_TableViewCellTitle";
//    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//    return cell;
//    
//    
//    
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    
//    return 0;
//}
///*
// //设置cell的行高
// - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
// {
// return 70;
// }
// 
// //设置cell的隔行换色
// - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
// {
// if ([indexPath row] % 2 == 0) {
// cell.backgroundColor = [UIColor blueColor];
// } else {
// cell.backgroundColor = [UIColor greenColor];
// }
// }
// //滑动选择的行后删除
// - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
// {
// NSLog(@"执行删除操作");
// }
// 
// */


@end
