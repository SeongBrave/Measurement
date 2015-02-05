//
//  FullScreenPreviewVC.m
//  Measurement
//
//  Created by DTSoft on 15/1/27.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "FullScreenPreviewVC.h"

@interface FullScreenPreviewVC ()<UIWebViewDelegate>


@property(nonatomic , strong)Dialog *m_dialog;

@end

@implementation FullScreenPreviewVC

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
    
}

#pragma mark - 自定义方法

/**
 *  初始化一些数据 父类中调用了
 */
-(void)SetUpData
{
    [self layoutMainCustomView];
    
    [self Add_RAC_Attention];
    
    
}


/**
 *  添加视图
 */
-(void)layoutMainCustomView
{
     self.m_dialog = [[Dialog alloc]init];
    self.m_webView.delegate = self;
    [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://139.212.89.77:8080/lims/web/pages/detectionTask/certificate-autoc.jsp?zsbh=CD02146019"]]];
}
- (IBAction)BackToVC:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}

/**
 *  添加rac检测
 */
-(void)Add_RAC_Attention
{
    
    
    
}

/**
 *  获取  的数据
 */
-(void)loadNetData
{
    
    
}

#pragma mark - 代理协议方法*

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.m_dialog showProgress:self];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.m_dialog hideProgress];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


@end
