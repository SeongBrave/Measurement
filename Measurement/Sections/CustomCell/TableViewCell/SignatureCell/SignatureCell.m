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
    
    self.m_txmLabel.text = [NSString stringWithFormat:@"%@",product.txm];
    self.m_jltxLabel.text = [NSString stringWithFormat:@"%@",product.jltx];
    self.m_jcfwLabel.text = [NSString stringWithFormat:@"%@",product.jcfw];
    self.m_ggxhLabel.text = [NSString stringWithFormat:@"%@",product.ggxh];
    self.m_sccjLabel.text = [NSString stringWithFormat:@"%@",product.sccj];
    self.m_lbLabel.text = [NSString stringWithFormat:@"%@",product.jclx];
     self.m_priceLabel.text = [NSString stringWithFormat:@"%@",product.bzsf];
    
    
}

@end
