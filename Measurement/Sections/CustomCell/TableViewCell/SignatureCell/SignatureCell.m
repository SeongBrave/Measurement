//
//  SignatureCell.m
//  Measurement
//
//  Created by DTSoft on 15/1/10.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "SignatureCell.h"

@implementation SignatureCell


- (void)configureCellWithItem:( wtdbh_Model* )product
{
    self.m_txmLabel.text =  [product.txm GetNotNullStr];
    self.m_jltxLabel.text = [product.jcfw GetNotNullStr];
    self.m_yqmc_LB.text = [product.yqmc GetNotNullStr];
    self.m_jcfwLabel.text = [product.jcfw GetNotNullStr];
    self.m_ggxhLabel.text = [product.ggxh GetNotNullStr];
    self.m_sccjLabel.text =[product.sccj GetNotNullStr];
    self.m_lbLabel.text = [product.jclx GetNotNullStr];
    self.m_priceLabel.text =[product.bzsf GetNotNullStr];
}

- (void)configureCellWithItem:(id )item andIndex:(NSUInteger)index
{
    
     wtdbh_Model* product = (wtdbh_Model*)item;
    self.m_txmLabel.text =  [product.txm GetNotNullStr];
    self.m_jltxLabel.text = [product.jcfw GetNotNullStr];
    self.m_yqmc_LB.text = [product.yqmc GetNotNullStr];
    self.m_jcfwLabel.text = [product.jcfw GetNotNullStr];
    self.m_ggxhLabel.text = [product.ggxh GetNotNullStr];
    self.m_sccjLabel.text =[product.sccj GetNotNullStr];
    self.m_lbLabel.text = [product.jclx GetNotNullStr];
    self.m_priceLabel.text =[product.bzsf GetNotNullStr];
    
    self.m_indexLB.text = [NSString stringWithFormat:@"%@",[@(index) stringValue]];
}

@end
