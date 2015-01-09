//
//  UpdatePlanDetailsPopVC.m
//  Measurement
//
//  Created by DTSoft on 15/1/6.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "UpdatePlanDetailsPopVC.h"

#define MaxOffset  100

@interface UpdatePlanDetailsPopVC ()


/**
 *  客户签字
 */
@property (weak, nonatomic) IBOutlet UIScrollView *signatureScrollView;

@property (weak, nonatomic) IBOutlet UIImageView *btnLineImgV;


/**
 * 检测进度
 */
@property (weak, nonatomic) IBOutlet UIScrollView *testProgressScrollView;

/**
 * 计划详情
 */
@property (weak, nonatomic) IBOutlet UIScrollView *planDetailsScrollView;

/**
 *  主scrollview
 */
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UIButton *testProgressBtn;
@property (weak, nonatomic) IBOutlet UIButton *signatureBtn;
@property (weak, nonatomic) IBOutlet UIButton *planBtn;

@property(nonatomic , assign) __block int nIndex;


@end
@implementation UpdatePlanDetailsPopVC



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
    
    [self.btnLineImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.width.equalTo(@60);
        make.height.equalTo(@4);
        make.top.equalTo(self.planBtn.mas_bottom).offset(0);
        make.centerX.equalTo(self.planBtn.mas_centerX);
        
        
    }];
    
}


/**
 *  添加rac检测
 */
-(void)Add_RAC_Attention
{
    
    [self.view showPlaceHolder];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.showsHorizontalScrollIndicator = FALSE;
    @weakify(self)
    [RACObserve(self.mainScrollView, contentOffset) subscribeNext:^(NSValue *value) {
        
        @strongify(self);
        CGPoint offset = [value CGPointValue];
        if (offset.x < 0.0f) {
            [self.mainScrollView setContentOffset:CGPointZero animated:NO];
        }
        else if (offset.x >= self.view.frame.size.width*2){
            [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:NO];
        }
        
    }];
    
    
    /**
     *  计划详情
     *
     */
    [RACObserve(self.planDetailsScrollView, contentOffset) subscribeNext:^(NSValue *value) {
        
        @strongify(self);
        CGPoint offset = [value CGPointValue];
        if (offset.x < 0.0f) {
            [self.mainScrollView setContentOffset:CGPointZero animated:NO];
        }
        else if (offset.x >= self.view.frame.size.width*2){
            [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:NO];
        }
        
    }];
    
    
    
    /**
     *  客服签字
     *
     */
    [RACObserve(self.signatureScrollView, contentOffset) subscribeNext:^(NSValue *value) {
        
        @strongify(self);
        CGPoint offset = [value CGPointValue];
        if (offset.x < 0.0f) {
            [self.mainScrollView setContentOffset:CGPointZero animated:NO];
        }
        else if (offset.x >= self.view.frame.size.width*2){
            [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:NO];
        }
        
    }];
    
 
    
    
    
    [[[[[RACObserve(self.mainScrollView, contentOffset)
         filter:^BOOL(NSValue *value) {
             
             @strongify(self);
             CGPoint offset = [value CGPointValue];
             CGFloat scrollViewWidth = self.view.frame.size.width;
             return  offset.x < scrollViewWidth/2 ;
         }] map:^id(NSValue *value){
             @strongify(self);
             if (self.nIndex ==0) {
                 
                 
                 return @NO;
             }else
             {
                 
                 self.nIndex = 0;
                 return @YES;
             }
             
             
         }]distinctUntilChanged]
      filter:^BOOL(NSNumber *bNum){
          
          return [bNum boolValue];
      }]
     subscribeNext:^(NSValue *value){
         
         //触发进入计划详情
         
         debug_object(@"触发进入计划详情");
         
//        btnLineImgV
         [self.btnLineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
             
            
             make.width.equalTo(@60);
             make.height.equalTo(@4);
             make.top.equalTo(self.planBtn.mas_bottom).offset(0);
             make.centerX.equalTo(self.planBtn.mas_centerX);
                make.leading.equalTo(self.planBtn.mas_leading).offset(0);
             
         }];
         
         [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
             [self.view layoutIfNeeded];
             
         }completion:NULL];
         
         
     }];
    
    
    [[[[[RACObserve(self.mainScrollView, contentOffset)
         filter:^BOOL(NSValue *value) {
             
             @strongify(self);
             CGPoint offset = [value CGPointValue];
             CGFloat scrollViewWidth = self.view.frame.size.width;
             return  (offset.x > scrollViewWidth/2)&&(offset.x < scrollViewWidth/2+scrollViewWidth) ;
         }] map:^id(NSValue *value){
             @strongify(self);
             if (self.nIndex ==1) {
                 
                 
                 return @NO;
             }else
             {
                 
                  self.nIndex = 1;
                 return @YES;
             }
             
             
         }]distinctUntilChanged]
      filter:^BOOL(NSNumber *bNum){
          
          return [bNum boolValue];
      }]
     subscribeNext:^(NSValue *value){
         
        
         [self.btnLineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
             
             
             make.width.equalTo(@60);
             make.height.equalTo(@4);
             make.top.equalTo(self.testProgressBtn.mas_bottom).offset(0);
             make.centerX.equalTo(self.testProgressBtn.mas_centerX);
              make.leading.equalTo(self.testProgressBtn.mas_leading).offset(0);
             
         }];
         
         [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
             [self.view layoutIfNeeded];
             
         }completion:NULL];
         
         //触发进入检测进度界面
         debug_object(@"触发进入检测进度界面");
         
     }];
    
    
    [[[[[RACObserve(self.mainScrollView, contentOffset)
         filter:^BOOL(NSValue *value) {
             
             @strongify(self);
             CGPoint offset = [value CGPointValue];
             CGFloat scrollViewWidth = self.view.frame.size.width;
             return  (offset.x > scrollViewWidth/2+scrollViewWidth)&&(offset.x < scrollViewWidth*2) ;
         }] map:^id(NSValue *value){
             @strongify(self);
             if (self.nIndex ==2) {
                 
                 return @NO;
             }else
             {
                 self.nIndex =2;
                 return @YES;
             }
             
             
         }]distinctUntilChanged]
      filter:^BOOL(NSNumber *bNum){
          
          return [bNum boolValue];
      }]
     subscribeNext:^(NSValue *value){
         
         
         
         [self.btnLineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
             
             
             make.width.equalTo(@60);
             make.height.equalTo(@4);
             make.top.equalTo(self.signatureBtn.mas_bottom).offset(0);
             make.centerX.equalTo(self.signatureBtn.mas_centerX);
             make.leading.equalTo(self.signatureBtn.mas_leading).offset(0);
             
             
         }];
         
         [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
             [self.view layoutIfNeeded];
             
         }completion:NULL];
         //触发进入客户签字界面
         
         debug_object(@"触发进入客户签字界面");
         
         
     }];
    
    [[self.planBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
       
        
        [self.btnLineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            
            make.width.equalTo(@60);
            make.height.equalTo(@4);
            make.top.equalTo(self.planBtn.mas_bottom).offset(0);
            make.centerX.equalTo(self.planBtn.mas_centerX);
            make.leading.equalTo(self.planBtn.mas_leading).offset(0);
            
        }];
        
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [self.view layoutIfNeeded];
            
        }completion:NULL];

        [self.mainScrollView setContentOffset:CGPointZero animated:YES];
        
    }];
    
    
    [[self.testProgressBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
        
        
        [self.btnLineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            
            make.width.equalTo(@60);
            make.height.equalTo(@4);
            make.top.equalTo(self.testProgressBtn.mas_bottom).offset(0);
            make.centerX.equalTo(self.testProgressBtn.mas_centerX);
            make.leading.equalTo(self.testProgressBtn.mas_leading).offset(0);
            
        }];
        
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [self.view layoutIfNeeded];
            
        }completion:NULL];
        
        [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width,0} animated:YES];
        
    }];
    
    [[self.signatureBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id next){
        
        
        [self.btnLineImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            
            make.width.equalTo(@60);
            make.height.equalTo(@4);
            make.top.equalTo(self.signatureBtn.mas_bottom).offset(0);
            make.centerX.equalTo(self.signatureBtn.mas_centerX);
            make.leading.equalTo(self.signatureBtn.mas_leading).offset(0);
            
            
        }];
        
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [self.view layoutIfNeeded];
            
        }completion:NULL];
        
         [self.mainScrollView setContentOffset:(CGPoint){self.view.frame.size.width*2,0} animated:YES];
        
        
    }];
    
    
//    self.self.planBtn.r
    
    
}
-(void)SetUpData
{
    [self layoutMainCustomView];
    
    [self Add_RAC_Attention];
    
    
}


#pragma mark - 代理协议方法*




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _mainScrollView) {
        
        
        if (scrollView.contentOffset.x < 0.0f) {
            [self.mainScrollView setContentOffset:CGPointZero animated:NO];
        }else if(scrollView.contentOffset.x > scrollView.frame.size.width)
        {
            
            [scrollView setContentOffset:(CGPoint){self.view.frame.size.width,0} animated:NO];
            //        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0
            //) ;
        }
        
        
    }
    
    
}

@end
