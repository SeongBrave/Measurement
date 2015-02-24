//
//  Sblb_TableViewCell.m
//  Measurement
//
//  Created by DTSoft on 15/1/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "Sblb_TableViewCell.h"
#import "sblb_Model.h"

@implementation Sblb_TableViewCell



- (void)configureCellWithItem:(id )item andIndex:(NSUInteger)index
{
    sblb_Model *sblbModel = (sblb_Model *)item;
    
    self.m_txmLabel.text = [sblbModel.txm GetNotNullStr];
    self.m_jltxLabel.text = [sblbModel.jltx GetNotNullStr];
    self.m_jcfwLabel.text = [sblbModel.jcfw GetNotNullStr];
    self.m_ggxhLabel.text = [sblbModel.ggxh GetNotNullStr];
    self.m_sccjLabel.text = [sblbModel.sccj GetNotNullStr];
    self.m_lbLabel.text = [sblbModel.jclx GetNotNullStr];
    self.m_priceLabel.text = [sblbModel.bzsf GetNotNullStr];
    self.m_dwmcLabel.text = [sblbModel.yqmc GetNotNullStr];
    
    self.numberLabel.text = [NSString stringWithFormat:@"%@",[@(index) stringValue]];
    
}
@end
