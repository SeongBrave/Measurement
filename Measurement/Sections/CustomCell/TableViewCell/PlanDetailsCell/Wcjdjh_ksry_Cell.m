//
//  Wcjdjh_ksry_Cell.m
//  Measurement
//
//  Created by DTSoft on 15/3/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "Wcjdjh_ksry_Cell.h"

@implementation Wcjdjh_ksry_Cell


- (void)configureCellWithItem:( Wcjdjh_ksry_Model* )product
{
//    Wcjdjh_ksry_Model *model = product;
//    
//    if ([model.state intValue] == 0) {
//        
//        model.state = @1;
//    }else
//    {
//        model.state = @0;
//    }
//    
    
    
    /**
     *  rac_prepareForReuseSignal 很关键 否则重用的时候会崩溃
     *
     */
    RAC(self.m_isSelectedImg,image) =  [[RACObserve(product,state) takeUntil:self.rac_prepareForReuseSignal] map:^id(NSNumber *number)
                                        {
                                            
                                            if ([number intValue] == 1) {
                                                return [UIImage imageNamed:@"checkbox-selected"];
                                            }else
                                            {
                                                return [UIImage imageNamed:@"checkbox-defauit"];
                                            }
                                        }];
    
    
    
    
    self.m_userNameLabel.text = [NSString stringWithFormat:@"%@",product.username];
    
    if ([product.state intValue] == 1) {
        self.m_isSelectedImg.image = [UIImage imageNamed:@"checkbox-selected"];
    }else
    {
        self.m_isSelectedImg.image = [UIImage imageNamed:@"checkbox-defauit"];
    }
    
    
    self.m_stateLabel.text = @"";

    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
