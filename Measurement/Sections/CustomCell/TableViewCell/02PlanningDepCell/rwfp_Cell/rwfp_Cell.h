//
//  rwfp_Cell.h
//  Measurement
//
//  Created by DTSoft on 15/3/31.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rwfp_model.h"

@interface rwfp_Cell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *m_userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *m_isSelectedImg;
@property (weak, nonatomic) IBOutlet UILabel *m_stateLabel;


- (void)configureCellWithItem:( rwfp_model* )product;

@end
