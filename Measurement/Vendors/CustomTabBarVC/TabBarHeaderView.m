//
//  TabBarHeaderView.m
//  ChildViewTest
//
//  Created by DTSoft on 14/10/20.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import "TabBarHeaderView.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>


@interface TabBarHeaderView ()

@property(nonatomic , assign)id<TabBarHeaderViewDelegate> myTabBarViewDelete;
@property(nonatomic , strong)UIViewController *secondTabBarVC;
@property(nonatomic , strong)UILabel *bottomLineLabel;
@property(nonatomic , strong)UILabel *m_lineV;

@property (nonatomic, strong) UIButton *m_firstTabBtn;
@property (nonatomic, strong) UIButton *m_secondTabBtn;

@end

@implementation TabBarHeaderView


- (instancetype)initWithViewModel:(id<TabBarHeaderViewDelegate> )tabBarViewdelete
{
    self = [super init];
    if (self ) {
        self.myTabBarViewDelete = tabBarViewdelete;
        
        
        UIButton *firstTabBtn = [[UIButton alloc]init];
        firstTabBtn.backgroundColor = [UIColor whiteColor];
        [firstTabBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [firstTabBtn setTitle:@"餐厅菜单" forState:UIControlStateNormal];
        @weakify(self)
        [[firstTabBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id sender){
            @strongify(self)
            [self selectedLeftLine];
           
            
        }];
        
        self.m_firstTabBtn = firstTabBtn;
        
        [self addSubview:_m_firstTabBtn];
        
        
        //uibutton视图的布局
   
        
        
        UIButton *secondTabBtn = [[UIButton alloc]init];
        secondTabBtn.backgroundColor = [UIColor whiteColor];
        [secondTabBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [secondTabBtn setTitle:@"餐厅简介" forState:UIControlStateNormal];
        [[secondTabBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id sender){
            @strongify(self)
            [self selectedRightLine];
//              self.m_bottomLineLabelConstraint.mas_equalTo  left.equalTo(@0);
            
            
        }];
        
        self.m_secondTabBtn = secondTabBtn;
        [self addSubview:_m_secondTabBtn];
        
        
      
        
        self.bottomLineLabel = [[UILabel alloc]init];
        
        self.bottomLineLabel.backgroundColor = [UIColor redColor];
        
        [self addSubview:_bottomLineLabel];

        
        
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor = [UIColor blackColor];
        [self addSubview:lineV];
        
        
    
        
        //uibutton视图的布局
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(firstTabBtn.mas_right).offset(0); //设置中线视图
            
            make.top.equalTo(firstTabBtn.mas_top).offset(0);
            
            make.centerY.equalTo(firstTabBtn.mas_centerY).offset(0);
            
            make.width.equalTo(@1.4);
            
        }];
        
        
        [firstTabBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.top.equalTo(@0);
            
            make.bottom.equalTo(@0);
            
            make.width.equalTo(secondTabBtn.mas_width).offset(0);
            
        }];
        
        
        [secondTabBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(lineV.mas_right);
            make.right.equalTo(@0);//注意对比对象，self.titleLabel在其父视图的左侧，所以数值为负数
            
            make.top.equalTo(firstTabBtn.mas_top);
            
            make.centerY.equalTo(firstTabBtn.mas_centerY).offset(0);
            
            make.width.equalTo(firstTabBtn.mas_width).offset(0);
            
        }];
        
        
        [ self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(@0);
            
            make.bottom.equalTo(@0);
            
            make.width.equalTo(self.m_firstTabBtn.mas_width).offset(0);
            
            make.height.equalTo(@3);
            
        }];
        
    }
    return self;
}


-(void)selectedRightLine
{
    
    
    
    [ self.bottomLineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(@0);
        
        make.bottom.equalTo(@0);
        
        make.width.equalTo(self.m_secondTabBtn.mas_width).offset(0);
        
        make.height.equalTo(@3);
        
    }];
    [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [self layoutIfNeeded];
        [self.myTabBarViewDelete didSelectedWithIndex:TabBarSecond];
    }completion:NULL];
}

-(void)selectedLeftLine
{
    
    
    
    [ self.bottomLineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(@0);
        
        make.bottom.equalTo(@0);
        
        make.width.equalTo(self.m_firstTabBtn.mas_width).offset(0);
        
        make.height.equalTo(@3);
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        [self layoutIfNeeded];
        [self.myTabBarViewDelete didSelectedWithIndex:TabBarFirst];
    }completion:NULL];
    
}

//-(void)updateConstraints
//{
//
//}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
