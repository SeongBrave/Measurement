//
//  HeaderView.m
//  Measurement
//
//  Created by DTSoft on 14/12/22.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "HeaderView.h"
#import "VendorMacro.h"
#import "LoginedUser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation HeaderView


-(id)initWithHeaderView
{
    self = [super init];
    if (self) {
        
        
        
        LoginedUser *loginer = [LoginedUser sharedInstance];
        
        
        self.m_usrNameLabel = [[UILabel alloc]init];

        self.m_usrNameLabel.text = loginer.username;
        self.m_usrNameLabel.textAlignment = NSTextAlignmentCenter;
        self.m_usrNameLabel.textColor = UIColorFromRGB(255,255,255);
        self.m_usrNameLabel.font = [UIFont systemFontOfSize:12];

        self.m_usrNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.m_usrNameLabel.numberOfLines = 1;
          self.m_usrNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_m_usrNameLabel];
        
        //欢迎你!
        UILabel * showLabel = [[UILabel alloc]init];
        showLabel.text = @"欢迎你!";
        showLabel.textColor = UIColorFromRGB(255,255,255);
        showLabel.textAlignment = NSTextAlignmentCenter;
        showLabel.font = [UIFont systemFontOfSize:9];
        showLabel.lineBreakMode = NSLineBreakByWordWrapping;
        showLabel.numberOfLines = 1;
        showLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:showLabel];
        
        //m_imgV
        self.m_imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"left-head-images"]];
        self.m_imgV.backgroundColor = [UIColor clearColor];
        [self addSubview:_m_imgV];
        
    //  http://192.168.10.169:8080/mbs/convey/querypicture.do?usercode=1187
        
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@querypicture.do?usercode=%@",defaultWebServiceUrl,loginer.usercode]];
        [self.m_imgV sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"left-head-images"]];
//        self.m_imgV

         @weakify(self)
        /**
         *  showLabel
         *
         *  @param make
         *
         *  @return
         */
        [ showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            @strongify(self)
            make.leading.equalTo(self.m_imgV.mas_right).offset(7);
            make.bottom.equalTo(self.m_usrNameLabel.mas_top).offset(0);
            
            
        }];
    
        /**
         *  m_usrNameLabel
         *
         *  @param make
         *
         *  @return
         */
        [ self.m_usrNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            

            make.leading.equalTo(showLabel.mas_leading).offset(0);
            make.bottom.equalTo(@-20);

            
            
        }];
        
        
        /**
         *  m_imgV
         *
         *  @param make
         *
         *  @return
         */
        [ self.m_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.equalTo(@11);
            make.bottom.equalTo(@-13);
            make.width.equalTo(@40);
            make.height.equalTo(@40);

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
