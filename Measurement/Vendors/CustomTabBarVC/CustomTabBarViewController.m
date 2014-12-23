//
//  CustomTabBarViewController.m
//  ChildViewTest
//
//  Created by DTSoft on 14/10/20.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "TabBarHeaderView.h"
#import <Masonry/Masonry.h>

@interface CustomTabBarViewController ()<TabBarHeaderViewDelegate>

@property(nonatomic , strong)UIViewController *firstTabBarVC;
@property(nonatomic , strong)UIViewController *secondTabBarVC;
@property(nonatomic , strong)UIView *m_firstView;
@property(nonatomic , strong)UIView *m_secondView;
@property(nonatomic , strong)TabBarHeaderView *m_headerV;
@property(nonatomic , strong)UIViewController *currentViewController;
@property(nonatomic , strong)UIView *mainView;

@end

@implementation CustomTabBarViewController

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
#pragma mark - 自定义方法
- (instancetype)initWithViewModel:(UIViewController *)firstTabVC andSecondTabVC:(UIViewController *)secondTabVC
{
    self = [super init];
    if (self ) {
        
        self.firstTabBarVC = firstTabVC;
        self.secondTabBarVC = secondTabVC;
    }
    return self;
}

- (instancetype)initWithFirstView:(UIView *)firstView andSecondView:(UIView *)secondView
{
    self = [super init];
    if (self ) {
        
        self.m_firstView = firstView;
        self.m_secondView = secondView;
    }
    return self;
    
}
-(void)SetUpData
{
    
    /**
     *  有导航时必须有这行代码，否则顶部将从最顶端开始，使得有部分视图被遮挡
     */
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addCustomView];
    
    [self addChildViewController:_firstTabBarVC];
    [self addChildViewController:_secondTabBarVC];
    
    _currentViewController = self.firstTabBarVC;
    [self.mainView addSubview:_firstTabBarVC.view];
    
}
-(void)addCustomView
{
//    self.mainView = [[UIView alloc]init];
//    self.mainView.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:_mainView];
    
    [self.view addSubview:self.m_firstView];
    [self.view addSubview:self.m_secondView];
    
    self.m_secondView.hidden = YES;
    
    [self.m_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.leading.equalTo(self.view.mas_leading); //设置中线视图
        
        make.top.equalTo(self.m_headerV.mas_bottom).offset(0);
        
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
    [self.m_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.leading.equalTo(self.view.mas_leading); //设置中线视图
        
        make.top.equalTo(self.m_headerV.mas_bottom).offset(0);
        
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
    self.m_headerV = [[TabBarHeaderView alloc]initWithViewModel:self];
    
    [self.view addSubview:_m_headerV];
    
    [self.m_headerV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.leading.equalTo(self.view.mas_leading); //设置中线视图
        
        make.top.equalTo(self.view.mas_top);
        
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.height.equalTo(@45);
        
    }];
    
//    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        
//        make.leading.equalTo(self.view.mas_leading); //设置中线视图
//        
//        make.top.equalTo(self.m_headerV.mas_bottom).offset(0);
//        
//        make.centerX.equalTo(self.view.mas_centerX);
//        
//        make.bottom.equalTo(self.view.mas_bottom);
//        
//    }];
}


#pragma mark - 代理协议方法
#pragma mark - TabBarHeaderViewDelegate
-(void)didSelectedWithIndex:(TabBarItem )tabBarItem
{
    
    if (tabBarItem ==0 && _currentViewController != self.firstTabBarVC) {
        
        
        [self transitionFromViewController:_currentViewController toViewController:self.firstTabBarVC duration:1 options:UIViewAnimationOptionTransitionNone animations:^{
        }  completion:^(BOOL finished) {
            if (finished) {
                
                _currentViewController = self.firstTabBarVC;
            }else{
                
            }
        }];
        
    }
    
    if (tabBarItem ==1 && _currentViewController != self.secondTabBarVC) {
        
        
        [self transitionFromViewController:_currentViewController toViewController:self.secondTabBarVC duration:1 options:UIViewAnimationOptionTransitionNone animations:^{
        }  completion:^(BOOL finished) {
            if (finished) {
                
                _currentViewController = self.secondTabBarVC;
            }else{
                
            }
        }];
        
    }
    
    
}


@end
