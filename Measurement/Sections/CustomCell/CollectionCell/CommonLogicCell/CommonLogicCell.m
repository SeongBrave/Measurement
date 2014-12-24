//
//  CommonLogicCell.m
//  Measurement
//
//  Created by DTSoft on 14/12/23.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#define COMMONLOGICCELL_COMMONSHOWLABEL_FONT [UIFont fontWithName:@"Helvetica" size:14]
#define COMMONLOGICCELL_COMPANYNAMEL_FONT [UIFont fontWithName:@"Helvetica-Bold" size:20]

#import "CommonLogicCell.h"

@implementation CommonLogicCell



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        /**
         m_dateL
         */
        self.m_dateL = [[UILabel alloc]init];
        self.m_dateL.numberOfLines = 1;
        self.m_dateL.textColor = [UIColor blackColor];
        self.m_dateL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_m_dateL];
        
        /**
         m_companyNameL
         */
        self.m_companyNameL = [[UILabel alloc]init];
        self.m_companyNameL.numberOfLines = 1;
        self.m_companyNameL.textColor = [UIColor blackColor];
        self.m_companyNameL.font =COMMONLOGICCELL_COMPANYNAMEL_FONT;
        [self.contentView addSubview:_m_companyNameL];
        
        
        /**
         m_companyAddrL
         */
        self.m_companyAddrL = [[UILabel alloc]init];
        self.m_companyAddrL.numberOfLines = 1;
        self.m_companyAddrL.textColor = [UIColor blackColor];
        self.m_companyAddrL.font = COMMONLOGICCELL_COMMONSHOWLABEL_FONT;
        [self.contentView addSubview:_m_companyAddrL];
        
        /**
         m_contactNameL
         */
        self.m_contactNameL = [[UILabel alloc]init];
        self.m_contactNameL.numberOfLines = 1;
        self.m_contactNameL.textColor = [UIColor blackColor];
        self.m_contactNameL.font = COMMONLOGICCELL_COMMONSHOWLABEL_FONT;
        [self.contentView addSubview:_m_contactNameL];
        
        UILabel *contactNameL = [[UILabel alloc]init];
        contactNameL.numberOfLines = 1;
        contactNameL.text = @"联系人";
        contactNameL.textColor = [UIColor blackColor];
        contactNameL.font = COMMONLOGICCELL_COMMONSHOWLABEL_FONT;
        [self.contentView addSubview:contactNameL];
        
        /**
         m_contactTelL
         */
        self.m_contactTelL = [[UILabel alloc]init];
        self.m_contactTelL.numberOfLines = 1;
        self.m_contactTelL.textColor = [UIColor blackColor];
        self.m_contactTelL.font = COMMONLOGICCELL_COMMONSHOWLABEL_FONT;
        [self.contentView addSubview:_m_contactTelL];
        
        UILabel *contactTelL = [[UILabel alloc]init];
        contactTelL.numberOfLines = 1;
        contactTelL.text = @"联系电话";
        contactTelL.textColor = [UIColor blackColor];
        contactTelL.font = COMMONLOGICCELL_COMMONSHOWLABEL_FONT;
        [self.contentView addSubview:contactTelL];
        
        
        /**
         m_inFactoryTimeL
         */
        self.m_inFactoryTimeL = [[UILabel alloc]init];
        self.m_inFactoryTimeL.numberOfLines = 1;
        self.m_inFactoryTimeL.textColor = [UIColor blackColor];
        self.m_inFactoryTimeL.font = COMMONLOGICCELL_COMMONSHOWLABEL_FONT;
        [self.contentView addSubview:_m_inFactoryTimeL];
        
        UILabel *inFactoryTimeL = [[UILabel alloc]init];
        inFactoryTimeL.numberOfLines = 1;
        inFactoryTimeL.text = @"下厂时间";
        inFactoryTimeL.textColor = [UIColor blackColor];
        inFactoryTimeL.font = COMMONLOGICCELL_COMMONSHOWLABEL_FONT;
        [self.contentView addSubview:inFactoryTimeL];
        
        
        /**
         m_headManNameL
         */
        self.m_headManNameL = [[UILabel alloc]init];
        self.m_headManNameL.numberOfLines = 1;
        self.m_headManNameL.textColor = [UIColor blackColor];
        self.m_headManNameL.font = COMMONLOGICCELL_COMMONSHOWLABEL_FONT;
        [self.contentView addSubview:_m_headManNameL];
        
        UILabel *headManNameL = [[UILabel alloc]init];
        headManNameL.numberOfLines = 1;
        headManNameL.text = @"负责人";
        headManNameL.textColor = [UIColor blackColor];
        headManNameL.font = COMMONLOGICCELL_COMMONSHOWLABEL_FONT;
        [self.contentView addSubview:headManNameL];
        
        
        /**
         m_inFactoryMansL
         */
        self.m_inFactoryMansL = [[UILabel alloc]init];
        self.m_inFactoryMansL.numberOfLines = 1;
        self.m_inFactoryMansL.textColor = [UIColor blackColor];
        self.m_inFactoryMansL.font = COMMONLOGICCELL_COMMONSHOWLABEL_FONT;
        [self.contentView addSubview:_m_inFactoryMansL];
        
        UILabel *inFactoryMansL = [[UILabel alloc]init];
        inFactoryMansL.numberOfLines = 1;
        inFactoryMansL.text = @"下厂人员";
        inFactoryMansL.textColor = [UIColor blackColor];
        inFactoryMansL.font = COMMONLOGICCELL_COMMONSHOWLABEL_FONT;
        [self.contentView addSubview:inFactoryMansL];
        
        
        /**
         m_noteL
         */
        self.m_noteL = [[UILabel alloc]init];
        self.m_noteL.numberOfLines = 1;
        self.m_noteL.textColor = [UIColor blackColor];
        self.m_noteL.font = COMMONLOGICCELL_COMMONSHOWLABEL_FONT;
        [self.contentView addSubview:_m_noteL];
        
        UILabel *noteL = [[UILabel alloc]init];
        noteL.numberOfLines = 1;
        noteL.text = @"备注";
        noteL.textColor = [UIColor blackColor];
        noteL.font = COMMONLOGICCELL_COMMONSHOWLABEL_FONT;
        [self.contentView addSubview:noteL];
        
        
        /**
         *  m_dateL
         *
         *  @param make 日期
         *
         *  @return
         */
        [ self.m_dateL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.equalTo(@5);
            make.top.equalTo(@0);
        }];
        
        /**
         *  m_companyNameL
         *
         *  @param make 公司姓名
         *
         *  @return
         */
        [ self.m_companyNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_dateL.mas_bottom).offset(2);
            make.leading.equalTo(@5);
            make.trailing.equalTo(@-5);
        }];
        
        /**
         *  m_companyNameL
         *
         *  @param make 公司地址
         *
         *  @return
         */
        [ self.m_companyAddrL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_companyNameL.mas_bottom).offset(0);
            make.leading.equalTo(self.m_companyNameL.mas_leading).offset(0);
        }];
        
        
        /**
         *  m_contactNameL
         *
         *  @param make 联系人姓名
         *
         *  @return
         */
        
        [ contactNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_companyAddrL.mas_bottom).offset(0);
            make.leading.equalTo(@8);
        }];
        
        [ self.m_contactNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(contactNameL.mas_centerY).offset(0);
            make.trailing.equalTo(@0);
            make.height.equalTo(contactNameL.mas_height).offset(0);
        }];
        
        /**
         *  m_contactTelL
         *
         *  @param make 联系电话
         *
         *  @return
         */
        
        [ contactTelL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_contactNameL.mas_bottom).offset(0);
            make.leading.equalTo(@8);
        }];
        
        [ self.m_contactTelL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(contactTelL.mas_centerY).offset(0);
            make.trailing.equalTo(@0);
            make.height.equalTo(contactTelL.mas_height).offset(0);
        }];
        
        /**
         *  m_inFactoryTimeL
         *
         *  @param make 下厂时间
         *
         *  @return
         */
        
        [ inFactoryTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_contactTelL.mas_bottom).offset(0);
            make.leading.equalTo(@8);
        }];
        
        [ self.m_inFactoryTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(inFactoryTimeL.mas_centerY).offset(0);
            make.trailing.equalTo(@0);
            make.height.equalTo(inFactoryTimeL.mas_height).offset(0);
        }];
        
        /**
         *  m_headManNameL
         *
         *  @param make 负责人
         *
         *  @return
         */
        
        [ headManNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_inFactoryTimeL.mas_bottom).offset(0);
            make.leading.equalTo(@8);
        }];
        
        [ self.m_headManNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(headManNameL.mas_centerY).offset(0);
            make.trailing.equalTo(@0);
            make.height.equalTo(headManNameL.mas_height).offset(0);
        }];
        
        /**
         *  m_inFactoryMansL
         *
         *  @param make 下厂人员
         *
         *  @return
         */
        
        [ inFactoryMansL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_headManNameL.mas_bottom).offset(0);
            make.leading.equalTo(@8);
        }];
        
        [ self.m_inFactoryMansL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(inFactoryMansL.mas_centerY).offset(0);
            make.trailing.equalTo(@0);
            make.height.equalTo(inFactoryMansL.mas_height).offset(0);
        }];
        
        /**
         *  m_noteL
         *
         *  @param make 备注
         *
         *  @return
         */
        
        [noteL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_inFactoryMansL.mas_bottom).offset(0);
            make.leading.equalTo(@8);
        }];
        
        [ self.m_noteL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(noteL.mas_centerY).offset(0);
            make.trailing.equalTo(@0);
            make.height.equalTo(noteL.mas_height).offset(0);
        }];
        
        

    }
    
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    
        
        /**
         m_dateL
         */
        self.m_dateL = [[UILabel alloc]init];
        self.m_dateL.numberOfLines = 1;
        self.m_dateL.textColor = [UIColor blackColor];
        self.m_dateL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_m_dateL];
        
        /**
         m_companyNameL
         */
        self.m_companyNameL = [[UILabel alloc]init];
        self.m_companyNameL.numberOfLines = 0;
        self.m_companyNameL.textColor = [UIColor blackColor];
        self.m_companyNameL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_m_companyNameL];
        
        
        /**
         m_companyAddrL
         */
        self.m_companyAddrL = [[UILabel alloc]init];
        self.m_companyAddrL.numberOfLines = 1;
        self.m_companyAddrL.textColor = [UIColor blackColor];
        self.m_companyAddrL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_m_companyAddrL];
        
        /**
         m_contactNameL
         */
        self.m_contactNameL = [[UILabel alloc]init];
        self.m_contactNameL.numberOfLines = 1;
        self.m_contactNameL.textColor = [UIColor blackColor];
        self.m_contactNameL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_m_contactNameL];
        
        UILabel *contactNameL = [[UILabel alloc]init];
        contactNameL.numberOfLines = 1;
        contactNameL.text = @"联系人";
        contactNameL.textColor = [UIColor blackColor];
        contactNameL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:contactNameL];
        
        /**
         m_contactTelL
         */
        self.m_contactTelL = [[UILabel alloc]init];
        self.m_contactTelL.numberOfLines = 1;
        self.m_contactTelL.textColor = [UIColor blackColor];
        self.m_contactTelL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_m_contactTelL];
        
        UILabel *contactTelL = [[UILabel alloc]init];
        contactTelL.numberOfLines = 1;
        contactTelL.text = @"联系电话";
        contactTelL.textColor = [UIColor blackColor];
        contactTelL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:contactTelL];
        
        
        /**
         m_inFactoryTimeL
         */
        self.m_inFactoryTimeL = [[UILabel alloc]init];
        self.m_inFactoryTimeL.numberOfLines = 1;
        self.m_inFactoryTimeL.textColor = [UIColor blackColor];
        self.m_inFactoryTimeL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_m_inFactoryTimeL];
        
        UILabel *inFactoryTimeL = [[UILabel alloc]init];
        inFactoryTimeL.numberOfLines = 1;
        inFactoryTimeL.text = @"下厂时间";
        inFactoryTimeL.textColor = [UIColor blackColor];
        inFactoryTimeL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:inFactoryTimeL];
        
        
        /**
         m_headManNameL
         */
        self.m_headManNameL = [[UILabel alloc]init];
        self.m_headManNameL.numberOfLines = 1;
        self.m_headManNameL.textColor = [UIColor blackColor];
        self.m_headManNameL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_m_headManNameL];
        
        UILabel *headManNameL = [[UILabel alloc]init];
        headManNameL.numberOfLines = 1;
        headManNameL.text = @"负责人";
        headManNameL.textColor = [UIColor blackColor];
        headManNameL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:headManNameL];
        
        
        /**
         m_inFactoryMansL
         */
        self.m_inFactoryMansL = [[UILabel alloc]init];
        self.m_inFactoryMansL.numberOfLines = 1;
        self.m_inFactoryMansL.textColor = [UIColor blackColor];
        self.m_inFactoryMansL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_m_inFactoryMansL];
        
        UILabel *inFactoryMansL = [[UILabel alloc]init];
        inFactoryMansL.numberOfLines = 1;
        inFactoryMansL.text = @"下厂人员";
        inFactoryMansL.textColor = [UIColor blackColor];
        inFactoryMansL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:inFactoryMansL];
        
        
        /**
         m_noteL
         */
        self.m_noteL = [[UILabel alloc]init];
        self.m_noteL.numberOfLines = 1;
        self.m_noteL.textColor = [UIColor blackColor];
        self.m_noteL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_m_noteL];
        
        UILabel *noteL = [[UILabel alloc]init];
        noteL.numberOfLines = 1;
        noteL.text = @"备注";
        noteL.textColor = [UIColor blackColor];
        noteL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:noteL];
        
        
        /**
         *  m_dateL
         *
         *  @param make 日期
         *
         *  @return
         */
        [ self.m_dateL mas_makeConstraints:^(MASConstraintMaker *make) {

            make.leading.equalTo(@0);
            make.top.equalTo(@0);
        }];
        
        /**
         *  m_companyNameL
         *
         *  @param make 公司姓名
         *
         *  @return
         */
        [ self.m_companyNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            

            make.top.equalTo(self.m_dateL.mas_bottom).offset(2);
            make.leading.equalTo(@5);
            make.trailing.equalTo(@-5);
        }];
        
        /**
         *  m_companyNameL
         *
         *  @param make 公司地址
         *
         *  @return
         */
        [ self.m_companyAddrL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_companyNameL.mas_bottom).offset(0);
            make.leading.equalTo(self.m_companyNameL.mas_leading).offset(0);
        }];
        
        
        /**
         *  m_contactNameL
         *
         *  @param make 联系人姓名
         *
         *  @return
         */
        
        [ contactNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_companyAddrL.mas_bottom).offset(0);
            make.leading.equalTo(@8);
        }];
        
        [ self.m_contactNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(contactNameL.mas_centerY).offset(0);
            make.trailing.equalTo(@0);
            make.height.equalTo(contactNameL.mas_height).offset(0);
        }];
        
        /**
         *  m_contactTelL
         *
         *  @param make 联系电话
         *
         *  @return
         */
        
        [ contactTelL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_contactNameL.mas_bottom).offset(0);
            make.leading.equalTo(@8);
        }];
        
        [ self.m_contactTelL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(contactTelL.mas_centerY).offset(0);
            make.trailing.equalTo(@0);
            make.height.equalTo(contactTelL.mas_height).offset(0);
        }];
        
        /**
         *  m_inFactoryTimeL
         *
         *  @param make 下厂时间
         *
         *  @return
         */
        
        [ inFactoryTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_contactTelL.mas_bottom).offset(0);
            make.leading.equalTo(@8);
        }];
        
        [ self.m_inFactoryTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(inFactoryTimeL.mas_centerY).offset(0);
            make.trailing.equalTo(@0);
            make.height.equalTo(inFactoryTimeL.mas_height).offset(0);
        }];
        
        /**
         *  m_headManNameL
         *
         *  @param make 负责人
         *
         *  @return
         */
        
        [ headManNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_inFactoryTimeL.mas_bottom).offset(0);
            make.leading.equalTo(@8);
        }];
        
        [ self.m_headManNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(headManNameL.mas_centerY).offset(0);
            make.trailing.equalTo(@0);
            make.height.equalTo(headManNameL.mas_height).offset(0);
        }];
        
        /**
         *  m_inFactoryMansL
         *
         *  @param make 下厂人员
         *
         *  @return
         */
        
        [ inFactoryMansL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_headManNameL.mas_bottom).offset(0);
            make.leading.equalTo(@8);
        }];
        
        [ self.m_inFactoryMansL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(inFactoryMansL.mas_centerY).offset(0);
            make.trailing.equalTo(@0);
            make.height.equalTo(inFactoryMansL.mas_height).offset(0);
        }];
        
        /**
         *  m_noteL
         *
         *  @param make 备注
         *
         *  @return
         */
        
        [noteL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(self.m_inFactoryMansL.mas_bottom).offset(0);
            make.leading.equalTo(@8);
        }];
        
        [ self.m_noteL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(noteL.mas_centerY).offset(0);
            make.trailing.equalTo(@0);
            make.height.equalTo(noteL.mas_height).offset(0);
        }];
        
        
    }
    return self;
}

-(void)updateCommonLogicCellWith:(NSDictionary*) commonLogicDict
{
    self.m_dateL.text = [NSString stringWithFormat:@"今天"];
    self.m_companyNameL.text = [NSString stringWithFormat:@"%@",commonLogicDict[@"WTDWMC"]];
    self.m_companyAddrL.text = [NSString stringWithFormat:@"%@",commonLogicDict[@"SZDQ"]];
    self.m_contactNameL.text = [NSString stringWithFormat:@"张科长"];
    self.m_contactTelL.text = [NSString stringWithFormat:@"%@",commonLogicDict[@"LXDH"]];
    self.m_inFactoryTimeL.text = [NSString stringWithFormat:@"%@",commonLogicDict[@"CJSJ"]];
    self.m_headManNameL.text = [NSString stringWithFormat:@"%@",commonLogicDict[@"YWFZR"]];
    self.m_inFactoryMansL.text = [NSString stringWithFormat:@"刘淑敏、蔡小凡"];
    self.m_noteL.text = [NSString stringWithFormat:@"%@",commonLogicDict[@"BZ"]];
    
}

-(void)updateOldCollectionCell
{
    self.m_dateL.text = [NSString stringWithFormat:@"今天"];
    self.m_companyNameL.text = [NSString stringWithFormat:@"长春美味食品有限公司"];
    self.m_companyAddrL.text = [NSString stringWithFormat:@"产新区建华西路北街108号"];
    self.m_contactNameL.text = [NSString stringWithFormat:@"张科长"];
    self.m_contactTelL.text = [NSString stringWithFormat:@"186123456"];
    self.m_inFactoryTimeL.text = [NSString stringWithFormat:@"2014-10-25 09：30"];
    self.m_headManNameL.text = [NSString stringWithFormat:@"李莉"];
    self.m_inFactoryMansL.text = [NSString stringWithFormat:@"刘淑敏、蔡小凡"];
    self.m_noteL.text = [NSString stringWithFormat:@"无"];
}
@end
