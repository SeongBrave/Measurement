//
//  LoginViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/20.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "MenuModel.h"
#import "DockItem.h"

@interface LoginViewController ()<UIAlertViewDelegate>
{
    BOOL isAutoLogin;
    BOOL isRememberPwd;
}

@property(nonatomic , strong)NSDictionary *updateDict;
@end

@implementation LoginViewController


#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([[FileHelpers GetDataFromNSUserDefaultsWithKey:IS_AUTOUPDATEKEY] boolValue]) {
        [self AutoUpdate];
        
    }
    
}

// TODO: 使用autolayout 布局界面
- (void)updateViewConstraints
{
    [super updateViewConstraints];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
//    HomeViewController
    if ([segue.identifier isEqualToString:@"ToLoginSuccess"] )
    {
        
        HomeViewController *homeVc = ( HomeViewController*)[segue destinationViewController];
    
        homeVc.m_dockListArr = nil;
    
    
    }

    
    
}

#pragma mark - 自定义方法

//TODO: 添加视图
-(void)layoutMainCustomView
{
    //获取上次登录时记录的工号和密码
    NSDictionary *lofinInfo = [FileHelpers GetDataFromNSUserDefaultsWithKey:@"loginInfo"];
    
    

    
     _m_uNameTextField.text = [lofinInfo objectForKey:@"usercode"];
     _m_uPwdTextField.text = [lofinInfo objectForKey:@"password"];
    
    UIImage *leftImage = [UIImage imageNamed:@"login-user"];
    UIImageView *usernameIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 15, 15)];
    usernameIconImage.backgroundColor =[UIColor clearColor];
    usernameIconImage.image = leftImage;
    UIView *usernameIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];

    [usernameIconContainer addSubview:usernameIconImage];
    _m_uNameTextField.leftViewMode = UITextFieldViewModeAlways;
    _m_uNameTextField.leftView = usernameIconContainer;
    
    
    UIImage *PwdleftImage = [UIImage imageNamed:@"login-pass"];
    UIImageView *PwdusernameIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 15, 15)];
    PwdusernameIconImage.backgroundColor =[UIColor clearColor];
    PwdusernameIconImage.image = PwdleftImage;
    UIView *PwdusernameIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    
    [PwdusernameIconContainer addSubview:PwdusernameIconImage];
    _m_uPwdTextField.leftViewMode = UITextFieldViewModeAlways;
    _m_uPwdTextField.leftView = PwdusernameIconContainer;
    
    isRememberPwd= [[FileHelpers GetDataFromNSUserDefaultsWithKey:@"loginState"] boolValue];
    
    [self.m_remberPwdBtn setBackgroundImage:[UIImage imageNamed:@"memory-checkbox-defauit"] forState:UIControlStateNormal];
     [self.m_remberPwdBtn setBackgroundImage:[UIImage imageNamed:@"memory-checkbox-selected"] forState:UIControlStateSelected];
    
    /**
     *  修改m_remberPwdBtn的状态
     */
    self.m_remberPwdBtn.selected = isRememberPwd;
    
}

-(void)SetUpData
{
    [super SetUpData];
    [self layoutMainCustomView];
//    [self AddNavgationBarItem];
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
                 UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:bbxxDict[@"message"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                 
                 [alert show];
                 
                 self.updateDict = bbxxDict;
             }
         }
         
     }error:^(NSError *error){
         
         debug_object(error);
         
     }];
    
}
-(void)AddNavgationBarItem
{
    
    UIBarButtonItem *leftBtn =[[UIBarButtonItem alloc] initWithTitle:@"群组" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBtnClick:)];
    [leftBtn setImage:[UIImage imageNamed:@"nav_Call"]];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc] initWithTitle:@"群组" style:UIBarButtonItemStyleBordered target:self action:@selector(rightBtnClick:)];
    [rightBtn setImage:[UIImage imageNamed:@"nav_MultipartyCalls"]];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
}
-(void)leftBtnClick:(id)sender
{
    [Dialog toast:@"left"];
}

-(void)rightBtnClick:(id)sender
{
    [Dialog toast:@"right"];
}


-(void)Test
{
    NSDictionary *dict =@{@"user":@"root",@"pass":@"lovefox7"};
    
    [[[BaseNetWork getInstance] rac_postPath:@"http://www.uumatch.com/root/Login.php" parameters:dict]
     subscribeNext:^(id responseData){
         
         NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
         
         debug_object(dict);
         
     }error:^(NSError *error){
         
         debug_object(error);
         
     }];

}
/**
 *  登录
 *
 *  @param sender btn
 */
- (IBAction)loginBtnClick:(id)sender {
    
    
//    [self Test];
    
    NSString *uNameStr = self.m_uNameTextField.text;
    NSString *uPwdStr = self.m_uPwdTextField.text;
    
    if (uNameStr.length == 0) {
        [Dialog toast:@"用户名不能为空!"];
        return;
    }
    
    if (uPwdStr.length == 0) {
        [Dialog toast:@"密码不能为空!"];
        return;
    }

    
    NSDictionary *reqDict = @{@"usercode":uNameStr,@"password":uPwdStr};
    [[BaseNetWork getInstance] showDialog];
    @weakify(self)
    [[[[BaseNetWork getInstance] rac_postPath:@"login.do" parameters:reqDict]deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(id responseData){
         @strongify(self)
         NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
         //登录成功过
         if ([dict[@"ret"] integerValue] == 1)
         {
             
             /**
              *  登陆成功了就给LoginedUser 初始化
              *
              */
             
             LoginedUser *loginedUser = [[LoginedUser alloc]initWithDict:dict[@"user"]];

             NSArray *ls =dict[@"ls"];
             loginedUser.menuList = [ls linq_select:^id(NSDictionary *dict){
                 
        
                 MenuModel *yqmcModel = [MTLJSONAdapter modelOfClass:[MenuModel class] fromJSONDictionary:dict error:nil];
                 
                 if ([yqmcModel.des isEqualToString:@"jhzl"]) {
                     
                     return  [DockItem itemWithIcon:@"tab-nav-jhzl-defauit" title:@"计划总揽" className:@"ProgramOverviewViewController" modal:NO andSelectedIcon:@"tab-nav-jhzl-selected"isSelected:NO];
                 }else if ([yqmcModel.des isEqualToString:@"ksjhlq"]) {
                     
                     return  [DockItem itemWithIcon:@"tab-nav-ksrwfp-defauit" title:@"科室任务分配" className:@"PlanningDepartmentViewController" modal:NO andSelectedIcon:@"tab-nav-ksrwfp-selected"isSelected:NO];
                 }else  if ([yqmcModel.des isEqualToString:@"ksjh"]) {
                     
                     return  [DockItem itemWithIcon:@"tab-nav-ksrw-defauit" title:@"科室任务" className:@"DepartmentTaskVc" modal:NO andSelectedIcon:@"tab-nav-ksrw-selected"isSelected:NO];
                 }else if ([yqmcModel.des isEqualToString:@"wcjdjh"]) {
                     
                     return  [DockItem itemWithIcon:@"tab-nav-wcjdjh-defauit" title:@"我创建的计划" className:@"MyPlanViewController" modal:NO andSelectedIcon:@"tab-nav-wcjdjh-selected"isSelected:NO];
                 }else if ([yqmcModel.des isEqualToString:@"xcrw"]) {
                     
                     return  [DockItem itemWithIcon:@"tab-nav-xcrw-defauit" title:@"下厂任务" className:@"FactoryTaskViewController" modal:NO andSelectedIcon:@"tab-nav-xcrw-selected"isSelected:NO];
                 }else if ([yqmcModel.des isEqualToString:@"jcrwcx"]) {
                     
                     return  [DockItem itemWithIcon:@"tab-nav-jcrwcx-defauit" title:@"监测任务查询" className:@"DetectionTaskQueryViewController" modal:NO andSelectedIcon:@"tab-nav-jcrwcx-selected"isSelected:NO];
                 }else if ([yqmcModel.des isEqualToString:@"shwtg"]) {
                     
                     return  [DockItem itemWithIcon:@"tab-nav-shwtg-defauit" title:@"审核未通过" className:@"AuditNotPassViewController" modal:NO andSelectedIcon:@"tab-nav-shwtg-selected"isSelected:NO];
                 }else if ([yqmcModel.des isEqualToString:@"hyrw"]) {
                     
                     return  [DockItem itemWithIcon:@"tab-nav-hyrw-defauit" title:@"核验任务" className:@"CheckTaskViewController" modal:NO andSelectedIcon:@"tab-nav-hyrw-selected"isSelected:NO];
                 }else if ([yqmcModel.des isEqualToString:@"pz1rw"]) {
                     
                     return  [DockItem itemWithIcon:@"tab-nav-pzrw-defauit" title:@"批准任务" className:@"ApprovalTaskViewController" modal:NO andSelectedIcon:@"tab-nav-pzrw-selected"isSelected:NO];
                 }else if ([yqmcModel.des isEqualToString:@"pzrw"]) {
                     
                     return  [DockItem itemWithIcon:@"tab-nav-xtsz-defauit" title:@"系统设置" className:@"SystemSettingsViewController" modal:YES andSelectedIcon:@"tab-nav-xtsz-selected"isSelected:NO];
                 }
                 return nil;
             }];
             
             loginedUser.menuList = [loginedUser.menuList linq_where:^BOOL( id value)
             {
                 if (value !=[NSNull null]) {
                     return YES;
                 }else
                 {
                     return NO;
                 }
                 
             }];

             /**
              *  如果勾选了记住密码则将密码保存到文件中
              */
             if(isRememberPwd == 1)
             {
                 
                 [FileHelpers SaveDataWithNSUserDefaultsForData:reqDict andWithKey:@"loginInfo"];
                 
                 
             }else
             {
                 [FileHelpers SaveDataWithNSUserDefaultsForData:@{@"usercode":loginedUser.usercode,@"password":@""} andWithKey:@"loginInfo"];
             }
             
             [FileHelpers SaveDataWithNSUserDefaultsForData:[[NSNumber alloc]initWithBool:isRememberPwd] andWithKey:@"loginState"];
             [self performSegueWithIdentifier:@"ToLoginSuccess" sender:loginedUser];
             
         }else //登录失败
         {
             [Dialog toast:dict[@"message"]];
         }
         
         
         
     }error:^(NSError *error){
         
         debug_object(error);
         
         
     }];

    

    
//    [self performSegueWithIdentifier:@"ToLoginSuccess" sender:nil];


    
    //ToLoginSuccess
}

/**
 *  记住密码
 *
 *  @param sender btn
 */
- (IBAction)rememberPwd_BtnClick:(id)sender
{
    UIButton * remberPwdBtn = (UIButton *)sender;
    
    // 1.取反
    remberPwdBtn.selected = !remberPwdBtn.isSelected;
    
    // 2.取消选中自动登录
    if (!remberPwdBtn.isSelected) {
        
        self.m_autoLoginBtn.selected = NO;
        isAutoLogin = NO;
        isRememberPwd = NO;

    }else
    {
        isRememberPwd = YES;
    }
    
}
/**
 *  自动登录
 *
 *  @param sender btn
 */
- (IBAction)rememberAutoLoginBtnClick:(id)sender {
    
    UIButton * autoLoginBtn = (UIButton *)sender;
    // 1.取反
    autoLoginBtn.selected = !autoLoginBtn.isSelected;
    
    // 2.选中记住密码
    if (autoLoginBtn.isSelected) {
        self.m_remberPwdBtn.selected = YES;
        isAutoLogin = YES;
        isRememberPwd = YES;
    }else
    {
        isAutoLogin = NO;
    }
    
}

#pragma mark - 代理协议方法*


#pragma  mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateDict[@"url"]]];
        
    }
    
}


@end
