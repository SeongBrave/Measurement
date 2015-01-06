//
//  LoginViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/20.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
{
    BOOL isAutoLogin;
    BOOL isRememberPwd;
}

@end

@implementation LoginViewController


#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUpData];
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
    
    
//    UIImage *PwdleftImage = [UIImage imageNamed:@"login-pass"];
//    UIImageView *PwdusernameIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 20, 20)];
//    PwdusernameIconImage.backgroundColor =[UIColor clearColor];
//    PwdusernameIconImage.image = PwdleftImage;
//    UIView *PwdusernameIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    
//    [usernameIconContainer addSubview:PwdusernameIconContainer];
//    _m_uPwdTextField.leftViewMode = UITextFieldViewModeAlways;
//    _m_uPwdTextField.leftView = usernameIconContainer;
    
    
}

-(void)SetUpData
{
    [self layoutMainCustomView];
//    [self AddNavgationBarItem];
    
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


/**
 *  登录
 *
 *  @param sender btn
 */
- (IBAction)loginBtnClick:(id)sender {
    
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
    [[[BaseNetWork getInstance] rac_getPath:@"login.do" parameters:reqDict]
     subscribeNext:^(id responseData){
         @strongify(self)
         NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
         //登录成功过
         if ([dict[@"ret"] integerValue] == 1) {
             
             /**
              *  如果勾选了记住密码则将密码保存到文件中
              */
             if(isRememberPwd == 1)
             {
                 
                 [FileHelpers SaveDataWithNSUserDefaultsForData:reqDict andWithKey:@"loginInfo"];
                
                 
             }else
             {
                 [FileHelpers SaveDataWithNSUserDefaultsForData:@{@"usercode":uNameStr,@"password":@""} andWithKey:@"loginInfo"];
             }
             
              [FileHelpers SaveDataWithNSUserDefaultsForData:[[NSNumber alloc]initWithBool:isRememberPwd] andWithKey:@"loginState"];
              [self performSegueWithIdentifier:@"ToLoginSuccess" sender:nil];
             
         }else //登录失败
         {
             [Dialog toast:dict[@"message"]];
         }
         
         
         
     }error:^(NSError *error){
         
         
         
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




@end
