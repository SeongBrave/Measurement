//
//  BaseTableViewController.m
//  FoodDelivery
//
//  Created by DTSoft on 14-10-14.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController



#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SetUpData];
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
@end
