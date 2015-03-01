//
//  BaseViewController.m
//  FoodDelivery
//
//  Created by DTSoft on 14-10-14.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController



#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.m_showDialog = [[Dialog alloc]initWithParentView:self.view];
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
    
    
}

-(void)SetUpData
{
    /**
     *  如果有导航使得导航之下开始不是顶部
     */
    if (IS_IOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    [self layoutMainCustomView];
}

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
