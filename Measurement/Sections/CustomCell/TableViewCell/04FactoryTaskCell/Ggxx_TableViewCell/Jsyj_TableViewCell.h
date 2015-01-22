//
//  Jsyj_TableViewCell.h
//  Measurement
//
//  Created by DTSoft on 15/1/22.
//  Copyright (c) 2015年 成勇. All rights reserved.
//


/**
 *  技术依据cell
 */
#import <UIKit/UIKit.h>
#import "Jsyj_Model.h"

@interface Jsyj_TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_jsbh_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_jsmc_LB;
@property (weak, nonatomic) IBOutlet UIImageView *m_isSelected_ImgV;

- (void)configureCellWithItem:(Jsyj_Model* )item ;
@end
