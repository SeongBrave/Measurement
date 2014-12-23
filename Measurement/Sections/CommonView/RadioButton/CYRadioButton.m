//
//  CYRadioButton.m
//  BedsNursingApp
//
//  Created by dt on 14-7-15.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "CYRadioButton.h"
#import "NSLayoutConstraint+ClassMethodPriority.h"


#define CYRadioButton_m_showLabel_Font  [UIFont systemFontOfSize:16]

//m_clickBtn
#define CYRadioButton_m_clickBtn_Padding 4.0f

//m_showLabel
#define CYRadioButton_m_clickBtn_X_m_showLabel 2.0f



@implementation CYRadioButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCYRadioButtonDelegate:(id<CYRadioButtonDelegate>) _myExecDelegate
{
    self = [super init];
    if (self) {
        
        [self UpdateBottomCYRadioButton];
       
        self.m_CYDelegate = _myExecDelegate;
        
        
    }
    return self;
}

-(void)updateConstraints{
    
    [super updateConstraints];

    
    /**
     *  m_clickBtn
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_clickBtn
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeLeading
                         multiplier:1.0f
                         constant:CYRadioButton_m_clickBtn_Padding]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_clickBtn
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                                     constraintWithItem:_m_clickBtn
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                     multiplier:1
                                     constant:22
                                     priority:UILayoutPriorityRequired]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_clickBtn
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1
                         constant:22
                         priority:UILayoutPriorityRequired]];
    
    /**
     *  m_showLabel
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_showLabel
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:_m_clickBtn
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:CYRadioButton_m_clickBtn_X_m_showLabel]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_showLabel
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_showLabel
                         attribute:NSLayoutAttributeTrailing
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:-CYRadioButton_m_clickBtn_Padding]];
    

}
-(void)UpdateBottomCYRadioButton
{
    
    [self addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.m_clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.m_clickBtn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_clickBtn.backgroundColor = [UIColor clearColor];
    [self.m_clickBtn setImage:[UIImage imageNamed:@"radio_UnSelected"] forState:UIControlStateNormal];
     [self.m_clickBtn setImage:[UIImage imageNamed:@"radio_Selected"] forState:UIControlStateSelected];
    [self.m_clickBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_m_clickBtn];

    
    /**
     *  userLabel
     */
    self.m_showLabel = [[UILabel alloc]init];
    self.m_showLabel.textAlignment = NSTextAlignmentRight;
    self.m_showLabel.font = CYRadioButton_m_showLabel_Font;
    self.m_showLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.m_showLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.m_showLabel.numberOfLines = 1;
    self.m_showLabel.backgroundColor = [UIColor clearColor];
    
    
    [self addSubview:_m_showLabel];
    
}

-(void)setShowLabelWithText:(NSString *) str
{
    if (_m_showLabel!= nil) {
        self.m_showLabel.text = [NSString stringWithFormat:@"%@",str];
    }
}
-(void)ClickBtn:(id) sender
{
    if ([_m_CYDelegate respondsToSelector:@selector(didSelectedWithCYRadioButton:)]) {
        [self.m_CYDelegate didSelectedWithCYRadioButton:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
