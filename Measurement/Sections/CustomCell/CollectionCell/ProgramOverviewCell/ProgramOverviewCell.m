//
//  ProgramOverviewCell.m
//  Measurement
//
//  Created by DTSoft on 14/12/25.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "ProgramOverviewCell.h"



@interface ProgramOverviewCell ()
/**
 *  日期 ：今天
 */
@property(nonatomic , strong)IBOutlet UILabel *m_dateL;

/**
 *  公司姓名： ***有限公司
 */
@property(nonatomic , strong)IBOutlet UILabel *m_companyNameL;

/**
 *  公司地址
 */
@property(nonatomic , strong)IBOutlet UILabel *m_companyAddrL;

/*
 *  联系人姓名
 */
@property(nonatomic , strong)IBOutlet UILabel  *m_contactNameL;


/**
 *  联系电话
 */
@property(nonatomic , strong)IBOutlet UILabel *m_contactTelL;

/**
 *  下厂时间
 */
@property(nonatomic , strong)IBOutlet UILabel *m_inFactoryTimeL;

/**
 *  负责人
 */
@property(nonatomic , strong)IBOutlet UILabel *m_headManNameL;

/**
 *  下厂人员
 */
@property(nonatomic , strong)IBOutlet UILabel *m_inFactoryMansL;

/**
 *  横线
 */
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *lineViews;

/**
 *  备注
 */
@property(nonatomic , strong)IBOutlet UILabel *m_noteL;


@end

@implementation ProgramOverviewCell


- (void)awakeFromNib{
    
    for (UIView *view  in _lineViews) {
        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"collectionLabelLine"]];
    }
    
}

- (void)configureCellWithItem:(id )product
{
  
//    collectionLabelLine

    NSDictionary * commonLogicDict = (NSDictionary *)product;
    
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


@end