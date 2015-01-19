//
//  BottomTabBarView.h
//  MyScanTest
//
//  Created by DTSoft on 15/1/18.
//  Copyright (c) 2015年 SeongBrave-App-工作室. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BottomTabBarView;

@protocol BottomTabBarViewDelegate <NSObject>

-(void)bottomTabBarView:(BottomTabBarView*) TabBarView didSaveClick:(UIButton *) sender;
-(void)bottomTabBarView:(BottomTabBarView*) TabBarView didCancleClick:(UIButton *) sender;

@end

@interface BottomTabBarView : UIView
@property(nonatomic , strong)UIButton * m_cancelBtn;
@property(nonatomic , strong)UIButton * m_okBtn;

@property(nonatomic , assign)id<BottomTabBarViewDelegate> m_delegate;

-(id)initWithBottomTabBarViewDelegate:(id<BottomTabBarViewDelegate>) mydelegate;

-(void)layoutCustomSubView;
@end
