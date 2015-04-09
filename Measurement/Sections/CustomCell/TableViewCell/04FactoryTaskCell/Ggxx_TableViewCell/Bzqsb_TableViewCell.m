//
//  Bzqsb_TableViewCell.m
//  Measurement
//
//  Created by DTSoft on 15/1/22.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "Bzqsb_TableViewCell.h"

@implementation Bzqsb_TableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)configureCellWithItem:(Bzqsb_Model* )item
{
    
    self.m_sbbh_LB.text = [item.bzsbbh GetNotNullStr];
    self.m_sbmc_LB.text = [item.sbmc GetNotNullStr];
    
    self.m_zsbh_LB.text = [item.syzsh GetNotNullStr];
    self.m_clfw_LB.text = [item.clfw GetNotNullStr];
    
    self.m_jddj_LB.text = [item.jltx GetNotNullStr];
    self.m_cldw_LB.text = [item.clfw GetNotNullStr];
    
    self.m_yxqz_LB.text = [item.yxq GetNotNullStr];

    
    if (item.isSelected) {
        
        [self.m_isSelected_ImgV setImage:[UIImage imageNamed:@"checkbox-selected"]];
    }else
    {
        [self.m_isSelected_ImgV setImage:[UIImage imageNamed:@"checkbox-defauit"]];
    }
    
    /**
     *  rac_prepareForReuseSignal 很关键 否则重用的时候会崩溃
     *
     */
    RAC(self.m_isSelected_ImgV,image) =
    [[RACObserve(item,isSelected)
      
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
