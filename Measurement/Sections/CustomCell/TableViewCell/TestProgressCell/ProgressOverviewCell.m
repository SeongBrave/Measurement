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
    
    
    
//    self.m_stateImgV.image = 
    
}
@end
