//
//  SystemSettingsViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/23.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "SystemSettingsViewController.h"

@interface SystemSettingsViewController ()

@end

@implementation SystemSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backToVCBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}
- (IBAction)exitBtnClick:(id)sender {
    
 

     
   
    [self dismissViewControllerAnimated:NO completion:^(void){
        
        
        NSNotification *notification = [NSNotification notificationWithName:@"TCDL" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
    
    
    
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
