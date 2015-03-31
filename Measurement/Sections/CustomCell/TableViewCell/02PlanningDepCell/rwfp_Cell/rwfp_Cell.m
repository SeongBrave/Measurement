//
//  rwfp_Cell.m
//  Measurement
//
//  Created by DTSoft on 15/3/31.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "rwfp_Cell.h"

@implementation rwfp_Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithItem:( rwfp_model* )product
{
    
    /**
     *  rac_prepareForReuseSignal 很关键 否则重用的时候会崩溃
     *
     */
    RAC(self.m_isSelectedImg,image) =  [[RACObserve(product,sffp) takeUntil:self.rac_prepareForReuseSignal] map:^id(NSNumber *number)
                                        {
                                            if ([number intValue] == 1) {
                                                return [UIImage imageNamed:@"checkbox-selected"];
                                            }else
                                            {
                                                return [UIImage imageNamed:@"checkbox-defauit"];
                                            }
                                            
                                            
                                        }];
    
    
    
    
    self.m_userNameLabel.text = [NSString stringWithFormat:@"%@",product.username];
    
    if ([product.sffp intValue] == 1) {
        self.m_isSelectedImg.image = [UIImage imageNamed:@"checkbox-selected"];
    }else
    {
        self.m_isSelectedImg.image = [UIImage imageNamed:@"checkbox-defauit"];
    }
    
    
    
    self.m_stateLabel.text = @"";
    
    
}


@end
