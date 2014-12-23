//
//  CustomBodyTempView.m
//  BedsNursingApp
//
//  Created by 成勇 on 14-5-29.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "CustomBodyTempView.h"
#import "NSLayoutConstraint+ClassMethodPriority.h"


#define  tempMax  38.0

#define CustomBodyTempView_common_Label_font  [UIFont systemFontOfSize:12]   //所有label的字体都一样

#define CustomBodyTempView_common_Label_Height 22.0f

#define CustomBodyTempView_common_Label_Y_Label 3.0f

#define CustomBodyTempView_common_Label_padding 5.0f   //指的距离边框的距离

//m_title_label   标头
#define CustomBodyTempView_m_title_label_Height 22.0f

//bodyTemp_label;  体温
#define CustomVitalSignsView_bodyTemp_label_Padding 6.0f
#define CustomVitalSignsView_bodyTemp_label_Width 24.0f
//oldbodyTemp_label;  原体温
#define CustomVitalSignsView_oldbodyTemp_label_Padding 1.0f
#define CustomVitalSignsView_oldbodyTemp_label_Width 24.0f
//tempType_label;  体温类型
#define CustomVitalSignsView_tempType_label_Padding 1.0f
#define CustomVitalSignsView_tempType_label_Width 24.0f

//m_bodyTemp_label;  体温
#define CustomVitalSignsView_bodyTemp_label_X_m_bodyTemp_label 4.0f
#define CustomVitalSignsView_m_bodyTemp_label_right_Padding 6.0f
//m_oldbodyTemp_label;  原体温
#define CustomVitalSignsView_oldbodyTemp_label_X_m_oldbodyTemp_label 4.0f
#define CustomVitalSignsView_m_oldbodyTemp_label_right_Padding 6.0f
//m_tempType_label;  体温类型
#define CustomVitalSignsView_tempType_label_X_m_tempType_label 4.0f
#define CustomVitalSignsView_m_tempType_label_right_Padding 6.0f



@interface CustomBodyTempView ()
{
   
    UILabel *bodyTemp_label;  //体温
    UILabel *oldbodyTemp_label; //原体温
    
    UILabel *tempType_label; //体温类型
    
    
    
}
@end

@implementation CustomBodyTempView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initWithCustomBodyTempView
{
    self = [super init];
    if (self) {
        self = [[CustomBodyTempView alloc]init];
      
        self.backgroundColor = [UIColor lightGrayColor];
        
          //self.layer.cornerRadius = 10.0f;
        //_m_title_label
        _m_title_label = [[UILabel alloc]init];
        _m_title_label.layer.cornerRadius = 10.0f;
        _m_title_label.textColor = [UIColor whiteColor];
        _m_title_label.text = @"体温";
        _m_title_label.textAlignment = NSTextAlignmentCenter;
        _m_title_label.font = CustomBodyTempView_common_Label_font;
        _m_title_label.lineBreakMode = NSLineBreakByWordWrapping;
        _m_title_label.numberOfLines = 1;
        [_m_title_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        _m_title_label.backgroundColor = [UIColor blackColor];
        [self addSubview:_m_title_label];
        
        
        //bodyTemp_label
        bodyTemp_label = [[UILabel alloc]init];
        bodyTemp_label.text = @"体温";
        bodyTemp_label.textAlignment = NSTextAlignmentLeft;
        bodyTemp_label.font = CustomBodyTempView_common_Label_font;
        bodyTemp_label.lineBreakMode = NSLineBreakByWordWrapping;
        bodyTemp_label.numberOfLines = 1;
        [bodyTemp_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        bodyTemp_label.backgroundColor = [UIColor clearColor];
        [self addSubview:bodyTemp_label];
        
        //oldbodyTemp_label
        oldbodyTemp_label = [[UILabel alloc]init];
        oldbodyTemp_label.text = @"原体温";
        oldbodyTemp_label.textAlignment = NSTextAlignmentLeft;
        oldbodyTemp_label.font = CustomBodyTempView_common_Label_font;
        oldbodyTemp_label.lineBreakMode = NSLineBreakByWordWrapping;
        oldbodyTemp_label.numberOfLines = 1;
        [oldbodyTemp_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        oldbodyTemp_label.backgroundColor = [UIColor clearColor];
        [self addSubview:oldbodyTemp_label];
        
        //tempType_label
        tempType_label = [[UILabel alloc]init];
        tempType_label.text = @"类型";
        tempType_label.textAlignment = NSTextAlignmentLeft;
        tempType_label.font = CustomBodyTempView_common_Label_font;
        tempType_label.lineBreakMode = NSLineBreakByWordWrapping;
        tempType_label.numberOfLines = 1;
        [tempType_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        tempType_label.backgroundColor = [UIColor clearColor];
        [self addSubview:tempType_label];
        
        //m_bodyTemp_label
        _m_bodyTemp_label = [[UILabel alloc]init];
        _m_bodyTemp_label.textAlignment = NSTextAlignmentCenter;
        _m_bodyTemp_label.font = CustomBodyTempView_common_Label_font;
        _m_bodyTemp_label.lineBreakMode = NSLineBreakByWordWrapping;
        _m_bodyTemp_label.numberOfLines = 1;
        [_m_bodyTemp_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        _m_bodyTemp_label.backgroundColor = [UIColor clearColor];
        [self addSubview:_m_bodyTemp_label];
        
        //m_oldbodyTemp_label
        _m_oldbodyTemp_label = [[UILabel alloc]init];
        _m_oldbodyTemp_label.textAlignment = NSTextAlignmentCenter;
        _m_oldbodyTemp_label.font = CustomBodyTempView_common_Label_font;
        _m_oldbodyTemp_label.lineBreakMode = NSLineBreakByWordWrapping;
        _m_oldbodyTemp_label.numberOfLines = 1;
        [_m_oldbodyTemp_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        _m_oldbodyTemp_label.backgroundColor = [UIColor clearColor];
        [self addSubview:_m_oldbodyTemp_label];
        
        //m_tempType_label
        _m_tempType_label = [[UILabel alloc]init];
        _m_tempType_label.textAlignment = NSTextAlignmentCenter;
        _m_tempType_label.font = CustomBodyTempView_common_Label_font;
        _m_tempType_label.lineBreakMode = NSLineBreakByWordWrapping;
        _m_tempType_label.numberOfLines = 1;
        [_m_tempType_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        _m_tempType_label.backgroundColor = [UIColor clearColor];
        [self addSubview:_m_tempType_label];
        
        
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
                         constant:CustomBodyTempView_m_title_label_Height
                         priority:UILayoutPriorityRequired]];
    
    /**
     *  breathe_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:bodyTemp_label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeLeading
                         multiplier:1.0f
                         constant:CustomVitalSignsView_bodyTemp_label_Padding]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:bodyTemp_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:_m_title_label
                         attribute:NSLayoutAttributeBottom
                         multiplier:1.0f
                         constant:CustomBodyTempView_common_Label_Y_Label]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:bodyTemp_label
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1
                         constant:CustomVitalSignsView_bodyTemp_label_Width
                         priority:UILayoutPriorityRequired]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:bodyTemp_label
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationGreaterThanOrEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1
                         constant:CustomBodyTempView_common_Label_Height
                         priority:UILayoutPriorityRequired]];
    
    
    /**
     *  m_bodyTemp_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_bodyTemp_label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:bodyTemp_label
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:CustomVitalSignsView_bodyTemp_label_X_m_bodyTemp_label]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_bodyTemp_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:bodyTemp_label
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_bodyTemp_label
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:bodyTemp_label
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_bodyTemp_label
                         attribute:NSLayoutAttributeTrailing
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:-CustomVitalSignsView_m_bodyTemp_label_right_Padding]];
    /**
     *  oldbodyTemp_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:oldbodyTemp_label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:bodyTemp_label
                         attribute:NSLayoutAttributeLeading
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:oldbodyTemp_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:bodyTemp_label
                         attribute:NSLayoutAttributeBottom
                         multiplier:1.0f
                         constant:CustomBodyTempView_common_Label_Y_Label]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:oldbodyTemp_label
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:bodyTemp_label
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0
                         priority:UILayoutPriorityRequired]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:oldbodyTemp_label
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationGreaterThanOrEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1
                         constant:CustomBodyTempView_common_Label_Height
                         priority:UILayoutPriorityRequired]];
    

    /**
     *  m_oldbodyTemp_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_oldbodyTemp_label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:oldbodyTemp_label
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:CustomVitalSignsView_oldbodyTemp_label_X_m_oldbodyTemp_label]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_oldbodyTemp_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:oldbodyTemp_label
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_oldbodyTemp_label
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:oldbodyTemp_label
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_oldbodyTemp_label
                         attribute:NSLayoutAttributeTrailing
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:-CustomVitalSignsView_m_bodyTemp_label_right_Padding]];
    
    /**
     *  tempType_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:tempType_label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:oldbodyTemp_label
                         attribute:NSLayoutAttributeLeading
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:tempType_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:oldbodyTemp_label
                         attribute:NSLayoutAttributeBottom
                         multiplier:1.0f
                         constant:CustomBodyTempView_common_Label_Y_Label]];
    //最后一行距离下边框的距离
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:tempType_label
                         attribute:NSLayoutAttributeBottom
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1.0f
                         constant: - CustomBodyTempView_common_Label_Y_Label]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:tempType_label
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:oldbodyTemp_label
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0
                         priority:UILayoutPriorityRequired]];
    
//    [self addConstraint:[NSLayoutConstraint
//                         constraintWithItem:tempType_label
//                         attribute:NSLayoutAttributeHeight
//                         relatedBy:NSLayoutRelationGreaterThanOrEqual
//                         toItem:nil
//                         attribute:NSLayoutAttributeNotAnAttribute
//                         multiplier:1
//                         constant:CustomBodyTempView_common_Label_Height
//                         priority:UILayoutPriorityRequired]];
//    
    
    /**
     *  m_tempType_label
     */
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_tempType_label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:tempType_label
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:CustomVitalSignsView_tempType_label_X_m_tempType_label]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_tempType_label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:tempType_label
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_tempType_label
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:tempType_label
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1.0f
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_m_tempType_label
                         attribute:NSLayoutAttributeTrailing
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:-CustomVitalSignsView_m_bodyTemp_label_right_Padding]];
  

}
-(void)UpdateCustomBodyTempViewDataWithDict:(NSDictionary *)_dict
{
    NSString *bodyTemp = [_dict objectForKey:@"iBodyHeat"];
    
    if (![bodyTemp isEqual:[NSNull null]] && bodyTemp) {
        
        float resutl = [bodyTemp floatValue];
        
        if (resutl > tempMax) {
            self.m_bodyTemp_label.textColor = [UIColor redColor];
        }else
        {
            self.m_bodyTemp_label.textColor = [UIColor blackColor];
        }
        
        
        self.m_bodyTemp_label.text = bodyTemp;
    }else
    {
        self.m_bodyTemp_label.text = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
    }
    
    NSString *oldbodyTemp = [_dict objectForKey:@"nHighBodyHeat"];
    
    if (![oldbodyTemp isEqual:[NSNull null]] && oldbodyTemp) {
        
        self.m_oldbodyTemp_label.text = oldbodyTemp;
    }else
    {
        self.m_oldbodyTemp_label.text = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
    }
    
    NSString *tempType = [_dict objectForKey:@"iBodyHeatType"];
    
    if (![tempType isEqual:[NSNull null]] && tempType) {
        
        self.m_tempType_label.text = tempType;
    }else
    {
        self.m_tempType_label.text = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
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
