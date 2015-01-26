//
//  FullScreenPreviewVC.m
//  Measurement
//
//  Created by DTSoft on 15/1/27.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "FullScreenPreviewVC.h"

@interface FullScreenPreviewVC ()

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
    [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.10.169:8080/lims/web/pages/detectionTask/record-addc.jsp?yqid=5F96662544EA4D769784B663BFC521F9&jljspmc=1005522"]]];
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

@end
