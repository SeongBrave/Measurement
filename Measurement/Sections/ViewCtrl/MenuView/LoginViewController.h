//
//  LoginViewController.h
//  Measurement
//
//  Created by DTSoft on 14/12/20.
//  Copyright (c) 2014年 成勇. All rights reserved.
//


/// 登录
#import "BaseViewController.h"

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UITextField *m_uNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *m_uPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *m_autoLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *m_remberPwdBtn;

@end
