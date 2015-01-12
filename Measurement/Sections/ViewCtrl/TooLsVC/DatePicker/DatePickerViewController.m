//
//  DatePickerViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/30.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()<DatePickerDelegate>

@end

@implementation DatePickerViewController

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
    
    [self.m_datePicker setDate:_m_date animated:NO];
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
    

    [self.m_datePicker  setDatePickerMode:UIDatePickerModeDate];
    [self layoutMainCustomView];
    [self AddNavgationBarItem];
    
}
-(void)AddNavgationBarItem
{

    
    
}

- (IBAction)DateValueChanged:(id)sender {
    
    UIDatePicker *control = (UIDatePicker*)sender;
    
    // 把当前控件设置的时间赋给date
    
    NSDate *date = control.date;
    
    
    if ([self.dateDelegate respondsToSelector:@selector(DatePickerVC:DidseletedDate:)]) {
        
        [self.dateDelegate DatePickerVC:self DidseletedDate:date];
        
        
    }
    

}

#pragma mark - 代理协议方法*



@end
