//
//  PlanDetailsHead_DepCell.m
//  Measurement
//
//  Created by DTSoft on 15/1/8.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "PlanDetailsHead_DepCell.h"

@interface PlanDetailsHead_DepCell ()

@property(nonatomic , strong)ks_Model *m_model;

@end

@implementation PlanDetailsHead_DepCell

- (void)awakeFromNib {
    
    
}

- (void)configureCellWithItem:( ks_Model* )product
{
    
    
    self.m_model = product;
    
    [[RACObserve(product,selected_RYArr) takeUntil:self.rac_prepareForReuseSignal]subscribeNext:^(NSArray *myarr)
     {
         if (myarr.count>0) {
             [self.m_headsBtn setTitleColor:UIColorFromRGB(9, 187, 143) forState:UIControlStateNormal];
         }else
         {
             [self.m_headsBtn setTitleColor:UIColorFromRGB(108, 108, 108) forState:UIControlStateNormal];
         }
         
         
         NSMutableString *str = [[NSMutableString alloc]init];
         for(ry_Model *model in myarr)
         {
             [str appendFormat:@",%@",model.username];
             
         }
         
           [self.m_headsBtn setTitle:str.length>=1?[str substringFromIndex:1]:@"未指定" forState:UIControlStateNormal];
         
         
     }];
    
    /**
     *  rac_prepareForReuseSignal 很关键 否则重用的时候会崩溃
     *
     */
    RAC(self.m_isSelectedImg,image) =
    [[RACObserve(product,isSelected)
      
      takeUntil:self.rac_prepareForReuseSignal]
     
     map:^id(NSNumber *number)
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
    
    
    
    
    self.m_departmentLabel.text = [NSString stringWithFormat:@"%@",product.comcname];
    
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
    
    if (product.selected_ryModel) {
        
        self.m_headsLabel.text = [NSString stringWithFormat:@"%@",product.selected_ryModel.username];
    }
    
}

- (IBAction)selectHeadClick:(id)sender {
    
    if ([self.m_head_DepDelegate respondsToSelector:@selector(planDetailsHead_DepCell:didSelectedWithks_Model:)] &&_m_model.isSelected) {
        [self.m_head_DepDelegate planDetailsHead_DepCell:self didSelectedWithks_Model:_m_model];
    }
    
}


@end
