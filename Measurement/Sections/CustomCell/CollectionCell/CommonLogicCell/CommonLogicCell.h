//
//  CommonLogicCell.h
//  Measurement
//
//  Created by DTSoft on 14/12/23.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonLogicCell : UICollectionViewCell

/**
 *  日期 ：今天
 */
@property(nonatomic , strong) UILabel *m_dateL;

/**
 *  公司姓名： ***有限公司
 */
@property(nonatomic , strong) UILabel *m_companyNameL;

/**
 *  公司地址
 */
@property(nonatomic , strong) UILabel *m_companyAddrL;

/*
 *  联系人姓名
 */
@property(nonatomic , strong) UILabel *m_contactNameL;


/**
 *  联系电话
 */
@property(nonatomic , strong) UILabel *m_contactTelL;

/**
 *  下厂时间
 */
@property(nonatomic , strong) UILabel *m_inFactoryTimeL;

/**
 *  负责人
 */
@property(nonatomic , strong) UILabel *m_headManNameL;

/**
 *  下厂人员
 */
@property(nonatomic , strong) UILabel *m_inFactoryMansL;

/**
 *  备注
 */
@property(nonatomic , strong) UILabel *m_noteL;


-(void)updateCommonLogicCellWith:(NSDictionary*) commonLogicDict;

-(void)updateOldCollectionCell;

@end
