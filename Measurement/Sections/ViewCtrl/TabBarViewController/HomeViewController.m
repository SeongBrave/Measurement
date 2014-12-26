//
//  HomeViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/22.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "HomeViewController.h"
#import "Dock.h"
#import "DockItem.h"
@interface HomeViewController ()
{
    Dock *_dock;
    
    // 存放所有要显示的子控制器
    NSMutableDictionary *_allChilds;
    
    // 当前正在显示的子控制器
    UIViewController *_currentChild;
}
@end

@implementation HomeViewController

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
    
    _allChilds = [NSMutableDictionary dictionary];
    __unsafe_unretained HomeViewController *home = self;
    
    // 1.添加dock
    _dock = [[Dock alloc] initWithDockView];
    _dock.dockItemClickBlock = ^(DockItem *item) {
        // 根据切换控制器
        [home selectChildWithItem:item];
    };
    
    [self.view addSubview:_dock];
    
    [ _dock mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.leading.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@144);
        make.bottom.equalTo(@0);
        
        
    }];
    
    // 4.默认选中全部状态
    [home selectChildWithItem:[DockItem itemWithIcon:nil className:@"ProgramOverviewViewController"]];
    
    
}

-(void)SetUpData
{
    [self layoutMainCustomView];
    [self AddNavgationBarItem];
    
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
#pragma mark 切换控制器
- (void)selectChildWithItem:(DockItem *)item
{
    // 1.从字典中取出即将要显示的子控制器
    UIViewController *nav = _allChilds[item.className];
    if (nav == nil) {
        
        UIStoryboard * mstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *vc = [mstoryboard instantiateViewControllerWithIdentifier:item.className];;
        nav = vc;
        // 不要自动伸缩
        nav.view.autoresizingMask = UIViewAutoresizingNone;
    
        
        // 模型形式展示控制器
        if (item.modal) {
            
            
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:nav animated:YES completion:nil];
            
            
            return;
        }
        
        // 添加手势监听器
//        [nav.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragNavView:)]];
        
        // 建立控制器之间的父子关系
        // 建议：两个控制器互为父子关系，那么它们的view也应该互为父子关系
        [self addChildViewController:nav];
        
        
        [_allChilds setObject:nav forKey:item.className];
    }
    
    if (_currentChild == nav) return;
    
    // 2.移除旧控制器的view
    [_currentChild.view removeFromSuperview];
    
    
    [self.view addSubview:nav.view];
    
    [ nav.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.leading.equalTo(_dock.mas_trailing).offset(0);
        
        make.trailing.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        
        
    }];
    
    _currentChild = nav;
}

#pragma mark 监听拖拽手势
- (void)dragNavView:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {// 手势结束
        [UIView animateWithDuration:0.2 animations:^{
            pan.view.transform = CGAffineTransformIdentity;
        }];
    } else {
        CGFloat tx = [pan translationInView:pan.view].x;
        pan.view.transform = CGAffineTransformMakeTranslation(tx * 0.5, 0);
    }
}
#pragma mark - 代理协议方法*



@end
