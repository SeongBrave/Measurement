//
//  FactoryTaskCell.m
//  Measurement
//
//  Created by beik on 12/26/14.
//  Copyright (c) 2014 成勇. All rights reserved.
//

#import "FactoryTaskCell.h"

@interface FactoryTaskCell ()



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


@property(nonatomic , strong) IBOutlet UILabel *numberLabel;



@end

@implementation FactoryTaskCell

- (void)configureCellWithItem:(id )item andIndex:(NSUInteger)index{
    self.numberLabel.text = [@(index) stringValue];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
