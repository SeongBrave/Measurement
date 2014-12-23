//
//  HeaderView.m
//  Measurement
//
//  Created by DTSoft on 14/12/22.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "HeaderView.h"
#import "VendorMacro.h"

@implementation HeaderView


-(id)initWithHeaderView
{
    self = [super init];
    if (self) {
        
        self.m_usrNameLabel = [[UILabel alloc]init];

        self.m_usrNameLabel.text = @"核验员Aris";
        self.m_usrNameLabel.textAlignment = NSTextAlignmentCenter;
        self.m_usrNameLabel.textColor = [UIColor whiteColor];
        self.m_usrNameLabel.font = [UIFont systemFontOfSize:24];

        self.m_usrNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.m_usrNameLabel.numberOfLines = 1;
          self.m_usrNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_m_usrNameLabel];
        
        //欢迎你!
        UILabel * showLabel = [[UILabel alloc]init];
        showLabel.text = @"欢迎你!";
        showLabel.textColor = [UIColor whiteColor];
        showLabel.textAlignment = NSTextAlignmentCenter;
        showLabel.font = [UIFont systemFontOfSize:18];
        showLabel.lineBreakMode = NSLineBreakByWordWrapping;
        showLabel.numberOfLines = 1;
        showLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:showLabel];
        
        //m_imgV
        self.m_imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"left-head-images"]];
        self.m_imgV.backgroundColor = [UIColor clearColor];
        [self addSubview:_m_imgV];

        
        /**
         *  showLabel
         *
         *  @param make
         *
         *  @return
         */
        [ showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
     

            make.leading.equalTo(self.m_imgV.mas_trailing).offset(0);
            make.top.equalTo(self.m_imgV.mas_top).offset(0);
            
            
        }];
    
        /**
         *  m_usrNameLabel
         *
         *  @param make
         *
         *  @return
         */
        [ self.m_usrNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@30);

            make.leading.equalTo(self.m_imgV.mas_trailing).offset(2);
            make.bottom.equalTo(@-10);

            
            
        }];
        
        
        /**
         *  m_imgV
         *
         *  @param make
         *
         *  @return
         */
        [ self.m_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            
      
            make.leading.equalTo(@10);

            make.bottom.equalTo(@-20);

        }];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
