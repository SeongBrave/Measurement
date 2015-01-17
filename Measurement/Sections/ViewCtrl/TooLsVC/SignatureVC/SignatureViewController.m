//
//  SignatureViewController.m
//  Measurement
//
//  Created by 凌晨 on 1/2/15.
//  Copyright (c) 2015 成勇. All rights reserved.
//

#import "SignatureViewController.h"
#import <PPSSignatureView.h>

@interface SignatureViewController ()

@property (strong, nonatomic) IBOutlet PPSSignatureView *signatureView;

@end

@implementation SignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signatureView.hasSignature = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)eraseButtonPress:(id)sender{
    [self.signatureView erase];
}

- (IBAction)confirmButtonPress:(id)sender{
    

    UIImage *signatureImage = self.signatureView.signatureImage;
    
    if ([self.m_delegate respondsToSelector:@selector(SignatureVC:saveUpWithImage:)]) {
        [self.m_delegate SignatureVC:self saveUpWithImage:signatureImage];
        
    }
    
//    网络请求发送签名图片
    
    @weakify(self)
    [[BaseNetWork getInstance] hideDialog];
    NSDictionary *dict =@{@"image":self.signatureView.signatureImage};
    [[[[[BaseNetWork getInstance] rac_postPath:@"khqrqz.do" parameters:dict]map:^(id responseData)
       {
           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
           
           return [dict valueForKeyPath:@"wtdwList"];
       }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
     subscribeNext:^(NSArray *arr) {
         @strongify(self)
         
     
         
         
     }error:^(NSError *error){
         //          @strongify(self)
         ////          NSArray *arr = [self.m_store getObjectById:@"page.result" fromTable:self.m_tableName];
         ////          self.m_DataSourceArr = arr;
         ////          [_header endRefreshing];
         ////          [_footer endRefreshing];
         ////
         ////          [self failedGetDataWithResponseData:arr];
         //          //          [self.m_collectionView reloadData];
         
         
     }];

}

- (IBAction)dismissVC:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
    
        
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
