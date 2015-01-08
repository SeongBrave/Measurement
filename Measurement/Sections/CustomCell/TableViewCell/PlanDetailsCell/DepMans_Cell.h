//
//  DepMans_Cell.h
//  Measurement
//
//  Created by DTSoft on 15/1/8.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ry_Model.h"

@interface DepMans_Cell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *m_userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *m_isSelectedImg;
@property (weak, nonatomic) IBOutlet UILabel *m_stateLabel;


- (void)configureCellWithItem:( ry_Model* )product;

@end
