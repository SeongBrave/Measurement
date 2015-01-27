//
//  BottomTabBarView.m
//  MyScanTest
//
//  Created by DTSoft on 15/1/18.
//  Copyright (c) 2015年 SeongBrave-App-工作室. All rights reserved.
//

#import "BottomTabBarView.h"
#import <Masonry/Masonry.h>

#define BottomTabBarView_Btn_FONT  [UIFont fontWithName:@"Helvetica-Bold" size:30]

@implementation BottomTabBarView


-(id)initWithBottomTabBarViewDelegate:(id<BottomTabBarViewDelegate>) mydelegate
{
    self = [super init];
    if (self) {
        
        if (mydelegate) {
            self.m_delegate = mydelegate;
        }
        
    }
    return self;
}

-(void)layoutCustomSubView
{
    self.m_cancelBtn = [[UIButton alloc]init];
    [self.m_cancelBtn addTarget:self action:@selector(CancelClick:) forControlEvents:UIControlEventTouchUpInside];
    self.m_cancelBtn.titleLabel.font = BottomTabBarView_Btn_FONT;
    [self.m_cancelBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.m_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.m_cancelBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_m_cancelBtn];
    
    [self.m_cancelBtn mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.centerX.equalTo(self.mas_centerX).offset(-80);
        maker.centerY.equalTo(self.mas_centerY);
        
    }];
    
    self.m_okBtn = [[UIButton alloc]init];
    [self.m_okBtn addTarget:self action:@selector(OKClick:) forControlEvents:UIControlEventTouchUpInside];
    self.m_okBtn.titleLabel.font = BottomTabBarView_Btn_FONT;
    [self.m_okBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.m_okBtn setTitle:@"跳过" forState:UIControlStateNormal];
    self.m_okBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_m_okBtn];
    
    [self.m_okBtn mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.centerX.equalTo(self.mas_centerX).offset(80);
        maker.centerY.equalTo(self.mas_centerY);
        
    }];
    
    
    

}

-(void)CancelClick:(UIButton *) sender
{
    if ([self.m_delegate respondsToSelector:@selector(bottomTabBarView:didCancleClick:)]) {
        [self.m_delegate bottomTabBarView:self didCancleClick:sender];
    }
    
}

-(void)OKClick:(UIButton *) sender
{
    if ([self.m_delegate respondsToSelector:@selector(bottomTabBarView:didSaveClick:)]) {
        [self.m_delegate bottomTabBarView:self didSaveClick:sender];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
