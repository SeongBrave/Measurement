//
//  DepMans_Cell.m
//  Measurement
//
//  Created by DTSoft on 15/1/8.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "DepMans_Cell.h"

@implementation DepMans_Cell


- (void)configureCellWithItem:( ry_Model* )product
{
    
    /**
     *  rac_prepareForReuseSignal 很关键 否则重用的时候会崩溃
     *
     */
    RAC(self.m_isSelectedImg,image) =  [[RACObserve(product,isSelected) takeUntil:self.rac_prepareForReuseSignal] map:^id(NSNumber *number)
                                        {
                                            
                                            if (product.isCheckBox) {
                                                
                                                if ([number boolValue]) {
                                                    return [UIImage imageNamed:@"checkbox-selected"];
                                                }else
                                                {
                                                    return [UIImage imageNamed:@"checkbox-defauit"];
                                                }
                                                
                                            }else
                                            {
                                                if ([number boolValue]) {
                                                    return [UIImage imageNamed:@"radio-selected"];
                                                }else
                                                {
                                                    return [UIImage imageNamed:@"radio-defauit"];
                                                }
                                            }
                                            
                                            
                                        }];
    
    
    
    
    self.m_userNameLabel.text = [NSString stringWithFormat:@"%@",product.username];
    
    if (product.isCheckBox) {
        
        if (product.isSelected) {
            self.m_isSelectedImg.image = [UIImage imageNamed:@"checkbox-selected"];
        }else
        {
            self.m_isSelectedImg.image = [UIImage imageNamed:@"checkbox-defauit"];
        }
        
    }else
    {
        if (product.isSelected) {
            self.m_isSelectedImg.image = [UIImage imageNamed:@"radio-selected"];
        }else
        {
            self.m_isSelectedImg.image = [UIImage imageNamed:@"radio-defauit"];
        }
        
        
    }
    

        
        self.m_stateLabel.text = @"";

    
}
@end
