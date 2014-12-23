//
//  CustomVitalSignsView.m
//  BedsNursingApp
//
//  Created by 成勇 on 14-5-29.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "CustomVitalSignsView.h"
#import "NSLayoutConstraint+ClassMethodPriority.h"

#define CustomVitalSignsView_common_Label_font  [UIFont systemFontOfSize:12]   //所有label的字体都一样

#define CustomVitalSignsView_common_Label_Height 22.0f

#define CustomVitalSignsView_common_Label_Y_Label 3.0f

#define CustomVitalSignsView_common_Label_padding 5.0f   //指的距离边框的距离

//m_title_label   标头
#define CustomVitalSignsView_m_title_label_Height 22.0f

//unit_label   单位
#define CustomVitalSignsView_unit_label_Width 22.0f
#define CustomVitalSignsView_unit_label_Padding 10.0f

//breathe_label   呼吸
#define CustomVitalSignsView_breathe_label_Padding 6.0f
#define CustomVitalSignsView_breathe_label_Width 23.0f
//pulse_label   脉搏
#define CustomVitalSignsView_pulse_label_Width 23.0f
//heartRate_label  心率
#define CustomVitalSignsView_heartRate_label_Width 23.0f


//m_breathe_label   呼吸
#define CustomVitalSignsView_breathe_label_X_m_breathe_label 10.0f
#define CustomVitalSignsView_m_breathe_label_Width 23.0f
//m_pulse_label   脉搏
#define CustomVitalSignsView_pulse_label_X_m_pulse_label 10.0f
#define CustomVitalSignsView_m_pulse_label_Width 23.0f
//m_heartRate_label  心率
#define CustomVitalSignsView_heartRate_label_X_m_heartRate 10.0f
#define CustomVitalSignsView_m_heartRate_label_Width 23.0f



@interface CustomVitalSignsView ()
{
    UILabel *breathe_label;  //呼吸
    UILabel *pulse_label;  //脉搏
    UILabel *heartRate_label; //心率
    
    UILabel *unit_label; //单位
    
    
    
}
@end


@implementation CustomVitalSignsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCustomVitalSignsView
{
    
    self = [super init];
    if (self) {
        self = [[CustomVitalSignsView alloc]init];
     
        
        //self.layer.cornerRadius = 10.0f;
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        //_m_title_label
        _m_title_label = [[UILabel alloc]init];
       
        _m_title_label.textAlignment = NSTextAlignmentCenter;
        _m_title_label.textColor = [UIColor whiteColor];
        _m_title_label.text = @"生命体征";
        _m_title_label.font = CustomVitalSignsView_common_Label_font;
        _m_title_label.lineBreakMode = NSLineBreakByWordWrapping;
        _m_title_label.numberOfLines = 1;
        [_m_title_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        _m_title_label.backgroundColor = [UIColor blackColor];
        [self addSubview:_m_title_label];
        
        //m_breathe_label
        _m_breathe_label = [[UILabel alloc]init];
        _m_breathe_label.textAlignment = NSTextAlignmentCenter;
        _m_breathe_label.font = CustomVitalSignsView_common_Label_font;
        _m_breathe_label.lineBreakMode = NSLineBreakByWordWrapping;
        _m_breathe_label.numberOfLines = 1;
        [_m_breathe_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        _m_breathe_label.backgroundColor = [UIColor clearColor];
        [self addSubview:_m_breathe_label];
        
        //m_pulse_label
        _m_pulse_label = [[UILabel alloc]init];
        _m_pulse_label.textAlignment = NSTextAlignmentCenter;
        _m_pulse_label.font = CustomVitalSignsView_common_Label_font;
        _m_pulse_label.lineBreakMode = NSLineBreakByWordWrapping;
        _m_pulse_label.numberOfLines = 1;
        [_m_pulse_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        _m_pulse_label.backgroundColor = [UIColor clearColor];
        [self addSubview:_m_pulse_label];
        
        //m_heartRate_label
        _m_heartRate_label = [[UILabel alloc]init];
        _m_heartRate_label.textAlignment = NSTextAlignmentCenter;
        _m_heartRate_label.font = CustomVitalSignsView_common_Label_font;
        _m_heartRate_label.lineBreakMode = NSLineBreakByWordWrapping;
        _m_heartRate_label.numberOfLines = 1;
        [_m_heartRate_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        _m_heartRate_label.backgroundColor = [UIColor clearColor];
        [self addSubview:_m_heartRate_label];
        
        
        /**
         *
         */
        //breathe_label
        breathe_label = [[UILabel alloc]init];
        breathe_label.text = @"呼吸";
        breathe_label.textAlignment = NSTextAlignmentLeft;
        breathe_label.font = CustomVitalSignsView_common_Label_font;
        breathe_label.lineBreakMode = NSLineBreakByWordWrapping;
        breathe_label.numberOfLines = 1;
        [breathe_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        breathe_label.backgroundColor = [UIColor clearColor];
        [self addSubview:breathe_label];
        
        //pulse_label
        pulse_label = [[UILabel alloc]init];
        pulse_label.text = @"脉搏";
        pulse_label.textAlignment = NSTextAlignmentLeft;
        pulse_label.font = CustomVitalSignsView_common_Label_font;
        pulse_label.lineBreakMode = NSLineBreakByWordWrapping;
        pulse_label.numberOfLines = 1;
        [pulse_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        pulse_label.backgroundColor = [UIColor clearColor];
        [self addSubview:pulse_label];
        
        //heartRate_label
        heartRate_label = [[UILabel alloc]init];
        heartRate_label.text = @"心率";
        heartRate_label.textAlignment = NSTextAlignmentLeft;
        heartRate_label.font = CustomVitalSignsView_common_Label_font;
        heartRate_label.lineBreakMode = NSLineBreakByWordWrapping;
        heartRate_label.numberOfLines = 1;
        [heartRate_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        heartRate_label.backgroundColor = [UIColor clearColor];
        [self addSubview:heartRate_label];

        //unit_label
        unit_label = [[UILabel alloc]init];
        unit_label.text = @"次\n/\n分";
        unit_label.textAlignment = NSTextAlignmentCenter;
        unit_label.font = CustomVitalSignsView_common_Label_font;
        unit_label.lineBreakMode = NSLineBreakByWordWrapping;
        unit_label.numberOfLines = 3;
        [unit_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        unit_label.backgroundColor = [UIColor clearColor];
        [self addSubview:unit_label];
        
    }
    return self;
    
}
-(void)updateConstraints{
    
    [super updateConstraints];


    /**
     *  m_title_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_title_label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeLeading
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_title_label
                         attribute:NSLayoutAttributeTrailing
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_title_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_title_label
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1
                         constant:CustomVitalSignsView_m_title_label_Height
                         priority:UILayoutPriorityRequired]];
    
    /**
     *  breathe_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:breathe_label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeLeading
                         multiplier:1.0f
                         constant:CustomVitalSignsView_breathe_label_Padding]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:breathe_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:_m_title_label
                         attribute:NSLayoutAttributeBottom
                         multiplier:1.0f
                         constant:CustomVitalSignsView_common_Label_Y_Label]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:breathe_label
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1
                         constant:CustomVitalSignsView_breathe_label_Width
                         priority:UILayoutPriorityRequired]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:breathe_label
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationGreaterThanOrEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1
                         constant:CustomVitalSignsView_common_Label_Height
                         priority:UILayoutPriorityRequired]];
    
    /**
     *  m_breathe_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_breathe_label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:breathe_label
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:CustomVitalSignsView_breathe_label_X_m_breathe_label]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_breathe_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:breathe_label
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_breathe_label
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:breathe_label
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_breathe_label
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1
                         constant:CustomVitalSignsView_m_breathe_label_Width
                         priority:UILayoutPriorityRequired]];
    

    
    /**
     *  pulse_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:pulse_label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:breathe_label
                         attribute:NSLayoutAttributeLeading
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:pulse_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:breathe_label
                         attribute:NSLayoutAttributeBottom
                         multiplier:1.0f
                         constant:CustomVitalSignsView_common_Label_Y_Label]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:pulse_label
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:breathe_label
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0
                         priority:UILayoutPriorityRequired]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:pulse_label
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationEqual
                         toItem:breathe_label
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:0
                         priority:UILayoutPriorityRequired]];
    
    /**
     *  m_pulse_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_pulse_label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:pulse_label
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:CustomVitalSignsView_pulse_label_X_m_pulse_label]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_pulse_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:pulse_label
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_pulse_label
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:pulse_label
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_pulse_label
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1
                         constant:CustomVitalSignsView_m_pulse_label_Width
                         priority:UILayoutPriorityRequired]];
    
    /**
     *  pulse_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:heartRate_label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:pulse_label
                         attribute:NSLayoutAttributeLeading
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:heartRate_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:pulse_label
                         attribute:NSLayoutAttributeBottom
                         multiplier:1.0f
                         constant:CustomVitalSignsView_common_Label_Y_Label]];
    
//    [self addConstraint:[NSLayoutConstraint
//                         constraintWithItem:heartRate_label
//                         attribute:NSLayoutAttributeBottom
//                         relatedBy:NSLayoutRelationEqual
//                         toItem:self
//                         attribute:NSLayoutAttributeBottom
//                         multiplier:1.0f
//                         constant:-CustomVitalSignsView_common_Label_Y_Label]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:heartRate_label
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:breathe_label
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0
                         priority:UILayoutPriorityRequired]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:heartRate_label
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationEqual
                         toItem:breathe_label
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:0
                         priority:UILayoutPriorityRequired]];
    
    /**
     *  m_heartRate_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_heartRate_label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:heartRate_label
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:CustomVitalSignsView_heartRate_label_X_m_heartRate]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_heartRate_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:heartRate_label
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_heartRate_label
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:heartRate_label
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_heartRate_label
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1
                         constant:CustomVitalSignsView_m_heartRate_label_Width
                         priority:UILayoutPriorityRequired]];

    
    /**
     *  unit_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:unit_label
                         attribute:NSLayoutAttributeTrailing
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:-CustomVitalSignsView_unit_label_Padding]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:unit_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:breathe_label
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:unit_label
                         attribute:NSLayoutAttributeBottom
                         relatedBy:NSLayoutRelationEqual
                         toItem:heartRate_label
                         attribute:NSLayoutAttributeBottom
                         multiplier:1.0f
                         constant:0]];

    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:unit_label
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1
                         constant:CustomVitalSignsView_unit_label_Width
                         priority:UILayoutPriorityRequired]];


}
-(void)UpdateCustomVitalSignsViewDataWithDict:(NSDictionary *)_dict
{
    NSString *breathe = [_dict objectForKey:@"iBreath"];
    
    if (![breathe isEqual:[NSNull null]] && breathe) {
        
        self.m_breathe_label.text = breathe;
    }else
    {
        self.m_breathe_label.text = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
    }
    
    NSString *pulse = [_dict objectForKey:@"iPulse"];
    
    if (![pulse isEqual:[NSNull null]] && pulse) {
        
        self.m_pulse_label.text = pulse;
    }else
    {
        self.m_pulse_label.text = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
    }
    
    NSString *heartRate = [_dict objectForKey:@"iPulseHeat"];
    
    if (![heartRate isEqual:[NSNull null]] && heartRate) {
        
        self.m_heartRate_label.text = heartRate;
    }else
    {
        self.m_heartRate_label.text = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
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
