//
//  PlanningDepartmentViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/22.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "PlanningDepartmentViewController.h"

@interface PlanningDepartmentViewController ()

@end

@implementation PlanningDepartmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SetUpData
{
    [super SetUpData];
    self.title = @"科室计划";
    self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.283 blue:0.151 alpha:1.000];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
