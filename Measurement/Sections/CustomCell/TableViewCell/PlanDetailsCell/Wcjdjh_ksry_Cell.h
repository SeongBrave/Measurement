//
//  Wcjdjh_ksry_Cell.h
//  Measurement
//
//  Created by DTSoft on 15/3/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wcjdjh_ksry_Model.h"

@interface Wcjdjh_ksry_Cell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *m_userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *m_isSelectedImg;
@property (weak, nonatomic) IBOutlet UILabel *m_stateLabel;


- (void)configureCellWithItem:( Wcjdjh_ksry_Model* )product;


@end
