//
//  Wcjdjh_Xcks_Cell.m
//  Measurement
//
//  Created by DTSoft on 15/3/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "Wcjdjh_Xcks_Cell.h"
#import "Wcjdjh_ksry_Model.h"


@interface Wcjdjh_Xcks_Cell ()

@property(nonatomic , strong)Wcjdjh_Xcks_Model *m_model;

@end

@implementation Wcjdjh_Xcks_Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureCellWithItem:( Wcjdjh_Xcks_Model* )product
{
    
    self.m_model = product;
    
    [[RACObserve(product,m_ksryArr) takeUntil:self.rac_prepareForReuseSignal]subscribeNext:^(NSArray *myarr)
     {
         if (myarr.count>0) {
             [self.m_headsBtn setTitleColor:UIColorFromRGB(9, 187, 143) forState:UIControlStateNormal];
         }else
         {
             [self.m_headsBtn setTitleColor:UIColorFromRGB(108, 108, 108) forState:UIControlStateNormal];
         }
         
         
         
         NSMutableString *str = [[NSMutableString alloc]init];
         for(Wcjdjh_ksry_Model *model in myarr)
         {
             if ([model.state intValue] == 1) {
                 
                 [str appendFormat:@",%@",model.username];
             }
             
             
         }
         
         
         [self.m_headsBtn setTitle:str.length>=1?[str substringFromIndex:1]:@"未指定" forState:UIControlStateNormal];
         
         
         
         
         
     }];
    
    
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
    
    
    
    
    self.m_departmentLabel.text = [NSString stringWithFormat:@"%@",product.comcname];
    
    if ([product.state intValue] == 1) {
        self.m_isSelectedImg.image = [UIImage imageNamed:@"checkbox-selected"];
    }else
    {
        self.m_isSelectedImg.image = [UIImage imageNamed:@"checkbox-defauit"];
    }
    
     NSMutableString *str = [[NSMutableString alloc]init];
    for(Wcjdjh_ksry_Model *model in product.m_ksryArr)
    {
        if ([model.state intValue] == 1) {
            
            [str appendFormat:@",%@",model.username];
        }
        
    }
    self.m_headsLabel.text = [NSString stringWithFormat:@"%@",str.length>0?str:@"未指定"];

}


- (IBAction)selectMansClick:(id)sender {
    
    if ([self.m_Xcks_CellDelegate respondsToSelector:@selector(Wcjdjh_Xcks_Cell:didSelectedWithks_Model:)]) {
        [self.m_Xcks_CellDelegate Wcjdjh_Xcks_Cell:self didSelectedWithks_Model:self.m_model];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
