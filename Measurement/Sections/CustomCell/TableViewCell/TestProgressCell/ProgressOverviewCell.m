//
//  ProgressOverviewCell.m
//  Measurement
//
//  Created by DTSoft on 15/1/10.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "ProgressOverviewCell.h"

@implementation ProgressOverviewCell


- (void)configureCellWithItem:( jcjd_Model* )product
{
    
    self.m_showTitleLabel.text = [NSString stringWithFormat:@"%@",product.showStr];
    
    if ([product.wczt isNotNull] ) {
        
        if ([product.wczt intValue]==0) {
            
            self.m_stateImgV.image = [UIImage imageNamed:@"right-card-title-wwc"];
        }else
        {
            self.m_stateImgV.image = [UIImage imageNamed:@"right-card-title-ywc"];
            
        }
        
    }else
    {
        self.m_stateImgV.image = [UIImage imageNamed:@"right-card-title-wwc"];
    }
    
}

- (void)changeArrowWithUp:(BOOL)up
{
    if (up) {
        self.upDownImgV.image = [UIImage imageNamed:@"general-arrow-up"];
    }else
    {
        self.upDownImgV.image = [UIImage imageNamed:@"general-arrow-down"];
    }
}
@end
