//
//  Wlqsb_TableViewCell.m
//  Measurement
//
//  Created by DTSoft on 15/2/9.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "Wlqsb_TableViewCell.h"
#import "wlqsb_Model.h"

@implementation Wlqsb_TableViewCell

- (void)configureCellWithItem:(id )item andIndex:(NSUInteger)index
{
    wlqsb_Model *sblbModel = (wlqsb_Model *)item;
    
    self.m_txmLabel.text = [sblbModel.txm GetNotNullStr];
    self.m_jltxLabel.text = [sblbModel.jltx GetNotNullStr];
    self.m_jcfwLabel.text = [sblbModel.jcfw GetNotNullStr];
    self.m_ggxhLabel.text = [sblbModel.ggxh GetNotNullStr];
    self.m_sccjLabel.text = [sblbModel.sccj GetNotNullStr];
    self.m_lbLabel.text = [sblbModel.jclx GetNotNullStr];
    self.m_priceLabel.text = [NSString stringWithFormat:@"%@",sblbModel.bzsf];
    self.m_dwmcLabel.text = [sblbModel.yqmc GetNotNullStr];
    
    self.numberLabel.text = [NSString stringWithFormat:@"00%@",[@(index) stringValue]];
    
    
    
    if (sblbModel.isSelected) {
        
        [self.m_State_ImgV setImage:[UIImage imageNamed:@"checkbox-selected"]];
    }else
    {
        [self.m_State_ImgV setImage:[UIImage imageNamed:@"checkbox-defauit"]];
    }
    
    
    /**
     *  rac_prepareForReuseSignal 很关键 否则重用的时候会崩溃
     *
     */
    RAC(self.m_State_ImgV,image) =
    [[RACObserve(sblbModel,isSelected)
      
      takeUntil:self.rac_prepareForReuseSignal]
     
     map:^id(NSNumber *number)
     {
         if ([number boolValue]) {
             return [UIImage imageNamed:@"checkbox-selected"];
         }else
         {
             return [UIImage imageNamed:@"checkbox-defauit"];
         }
         
     }];
    
    
    
}

@end
