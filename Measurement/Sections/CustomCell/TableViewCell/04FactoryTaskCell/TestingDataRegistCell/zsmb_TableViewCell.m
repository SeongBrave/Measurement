//
//  zsmb_TableViewCell.m
//  Measurement
//
//  Created by DTSoft on 15/2/5.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "zsmb_TableViewCell.h"
#import "zsmb_Model.h"
@implementation zsmb_TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureCellWithItem:(id )item andIndex:(NSUInteger)index
{
    zsmb_Model *zsmbModel = (zsmb_Model *)item;
    
    self.m_jlmbbh_LB.text = [zsmbModel.zsmbbh GetNotNullStr];
    self.m_jlmbmc_LB.text = [zsmbModel.zsmbmc GetNotNullStr];
    self.m_syfw_LB.text = [zsmbModel.zssyfw GetNotNullStr];
    self.m_lx_LB.text = [zsmbModel.zsmbbh GetNotNullStr];
    self.m_cjr_LB.text = [zsmbModel.cjr GetNotNullStr];
    self.m_cjsj_LB.text = [zsmbModel.cjsj GetNotNullStr];
    
    
    self.m_index_LB.text = [NSString stringWithFormat:@"%@",[@(index) stringValue]];
    
    
    /**
     *  rac_prepareForReuseSignal 很关键 否则重用的时候会崩溃
     *
     */
    RAC(self.m_state_ImgV,image) =
    [[RACObserve(zsmbModel,isSelected)
      
      takeUntil:self.rac_prepareForReuseSignal]
     
     map:^id(NSNumber *number)
     {
         
         if ([number boolValue]) {
             return [UIImage imageNamed:@"radio-selected"];
         }else
         {
             return [UIImage imageNamed:@"radio-defauit"];
         }
         
     }];
    
    if (zsmbModel.isSelected) {
        
        [self.m_state_ImgV setImage:[UIImage imageNamed:@"radio-selected"]];
        
    }else
    {
        [self.m_state_ImgV setImage:[UIImage imageNamed:@"radio-defauit"]];
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
