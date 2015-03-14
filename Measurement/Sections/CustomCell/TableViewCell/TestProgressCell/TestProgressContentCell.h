//
//  TestProgressContentCell.h
//  Measurement
//
//  Created by DTSoft on 15/1/10.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jcjd_Detail_Model.h"

@interface TestProgressContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *m_indexLB;

@property (weak, nonatomic) IBOutlet UILabel *m_txmLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_yqmc_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_jltxLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_jcfwLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_ggxhLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_sccjLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_lbLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_priceLabel;

- (void)configureCellWithItem:( jcjd_Detail_Model* )product;

- (void)configureCellWithItem:(id )item andIndex:(NSUInteger)index;

@end
