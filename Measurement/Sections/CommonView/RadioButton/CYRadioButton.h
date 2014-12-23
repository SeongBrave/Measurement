//
//  CYRadioButton.h
//  BedsNursingApp
//
//  Created by dt on 14-7-15.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  CYRadioButton;

@protocol CYRadioButtonDelegate <NSObject>

-(void)didSelectedWithCYRadioButton:(CYRadioButton *) selectedBtn;

@end

@interface CYRadioButton : UIControl


@property(nonatomic , assign)id <CYRadioButtonDelegate> m_CYDelegate;
/**
 *  点击按钮，其实是当做图标使用
 */
@property(nonatomic , strong) UIButton *m_clickBtn;

/**
 *  显示label
 */
@property(nonatomic , strong) UILabel *m_showLabel;

-(void)setShowLabelWithText:(NSString *) str;


-(id)initWithCYRadioButtonDelegate:(id<CYRadioButtonDelegate>) _myExecDelegate ;

@end
