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
    
      self.m_txmLabel.text = [NSString stringWithFormat:@"%@",product.txm];
    self.m_jltxLabel.text = [NSString stringWithFormat:@"%@",product.jltx];
    self.m_jcfwLabel.text = [NSString stringWithFormat:@"%@",product.jcfw];
    self.m_ggxhLabel.text = [NSString stringWithFormat:@"%@",product.ggxh];
    self.m_sccjLabel.text = [NSString stringWithFormat:@"%@",product.sccj];
    self.m_lbLabel.text = [NSString stringWithFormat:@"%@",product.jclx];
    self.m_priceLabel.text = [NSString stringWithFormat:@"%@",product.bzsf];
}

- (void)configureCellWithItem:(id )item andIndex:(NSUInteger)index
{
    
    jcjd_Detail_Model* product =(jcjd_Detail_Model*)item;
    
    self.m_txmLabel.text = [NSString stringWithFormat:@"%@",product.txm];
    self.m_jltxLabel.text = [NSString stringWithFormat:@"%@",product.jltx];
    self.m_jcfwLabel.text = [NSString stringWithFormat:@"%@",product.jcfw];
    self.m_ggxhLabel.text = [NSString stringWithFormat:@"%@",product.ggxh];
    self.m_sccjLabel.text = [NSString stringWithFormat:@"%@",product.sccj];
    self.m_lbLabel.text = [NSString stringWithFormat:@"%@",product.jclx];
    self.m_priceLabel.text = [NSString stringWithFormat:@"%@",product.bzsf];
    
    self.m_indexLB.text = [NSString stringWithFormat:@"%@",[@(index) stringValue]];
}
@end
