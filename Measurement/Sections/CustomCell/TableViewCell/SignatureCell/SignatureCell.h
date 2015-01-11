//
//  SignatureCell.h
//  Measurement
//
//  Created by DTSoft on 15/1/10.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wtdbh_Model.h"
@interface SignatureCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UILabel *m_txmLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_jltxLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_jcfwLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_ggxhLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_sccjLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_lbLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_priceLabel;


- (void)configureCellWithItem:( wtdbh_Model* )product;


@end
