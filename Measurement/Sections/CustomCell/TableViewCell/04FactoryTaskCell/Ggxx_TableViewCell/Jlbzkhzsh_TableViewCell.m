//
//  Jlbzkhzsh_TableViewCell.m
//  Measurement
//
//  Created by DTSoft on 15/1/22.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "Jlbzkhzsh_TableViewCell.h"

@implementation Jlbzkhzsh_TableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)configureCellWithItem:(Jlbzkhzsh_Model* )item
{
    self.m_sbbh_Lb.text = [item.bzxh GetNotNullStr];
    self.m_sbmc_LB.text = [item.shgyzsh GetNotNullStr];
    
    self.m_yxqz_LB.text =  [item.jlbzkhzsh GetNotNullStr];
    
    
    if (item.isSelected) {
        
        [self.m_isSelected_Imgv setImage:[UIImage imageNamed:@"checkbox-selected"]];
    }else
    {
       [self.m_isSelected_Imgv setImage:[UIImage imageNamed:@"checkbox-defauit"]];
    }

    
    /**
     *  rac_prepareForReuseSignal 很关键 否则重用的时候会崩溃
     *
     */
    RAC(self.m_isSelected_Imgv,image) =
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
