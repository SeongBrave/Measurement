//
//  TestProgressContentCell.m
//  Measurement
//
//  Created by DTSoft on 15/1/10.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "TestProgressContentCell.h"

@implementation TestProgressContentCell


- (void)configureCellWithItem:( jcjd_Detail_Model* )product
{
    
      self.m_txmLabel.text = [product.txm GetNotNullStr];
    self.m_yqmc_LB.text = [product.yqmc GetNotNullStr];
    self.m_jltxLabel.text = [product.jltx GetNotNullStr];
    self.m_jcfwLabel.text = [product.jcfw GetNotNullStr];
    self.m_ggxhLabel.text = [product.ggxh GetNotNullStr];
    self.m_sccjLabel.text = [product.sccj GetNotNullStr];
    self.m_lbLabel.text = [product.jclx GetNotNullStr];
    self.m_priceLabel.text = [product.bzsf GetNotNullStr];
}

- (void)configureCellWithItem:(id )item andIndex:(NSUInteger)index
{
    
    jcjd_Detail_Model* product =(jcjd_Detail_Model*)item;
    
    self.m_txmLabel.text = [product.txm GetNotNullStr];
    self.m_yqmc_LB.text = [product.yqmc GetNotNullStr];
    self.m_jltxLabel.text = [product.jltx GetNotNullStr];
    self.m_jcfwLabel.text = [product.jcfw GetNotNullStr];
    self.m_ggxhLabel.text = [product.ggxh GetNotNullStr];
    self.m_sccjLabel.text = [product.sccj GetNotNullStr];
    self.m_lbLabel.text = [product.jclx GetNotNullStr];
    self.m_priceLabel.text = [product.bzsf GetNotNullStr];
    
    self.m_indexLB.text = [NSString stringWithFormat:@"%@",[@(index) stringValue]];
}
@end
