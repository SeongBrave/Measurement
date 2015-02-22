//
//  jlmb_TableViewCell.m
//  Measurement
//
//  Created by DTSoft on 15/1/23.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "jlmb_TableViewCell.h"
#import "jlmb_Model.h"
@implementation jlmb_TableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configureCellWithItem:(id )item andIndex:(NSUInteger)index
{
        jlmb_Model *jlmbModel = (jlmb_Model *)item;
    
        self.m_jlmbbh_LB.text = [jlmbModel.jlmbbh GetNotNullStr];
        self.m_jlmbmc_LB.text = [jlmbModel.jlmbmc GetNotNullStr];
        self.m_syfw_LB.text = [jlmbModel.jlsyfw GetNotNullStr];
        self.m_lx_LB.text = [jlmbModel.jlmbbh GetNotNullStr];
        self.m_cjr_LB.text = [jlmbModel.cjr GetNotNullStr];
        self.m_cjsj_LB.text = [jlmbModel.cjsj GetNotNullStr];

    
        self.m_index_LB.text = [NSString stringWithFormat:@"%@",[@(index) stringValue]];
    
    
    /**
     *  rac_prepareForReuseSignal 很关键 否则重用的时候会崩溃
     *
     */
    RAC(self.m_state_ImgV,image) =
    [[RACObserve(jlmbModel,isSelected)
      
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
    
    if (jlmbModel.isSelected) {
        
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
