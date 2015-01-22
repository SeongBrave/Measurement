//
//  Bzqsb_TableViewCell.h
//  Measurement
//
//  Created by DTSoft on 15/1/22.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  标准器设备 cell
 */
#import <UIKit/UIKit.h>
#import "Bzqsb_Model.h"

@interface Bzqsb_TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_sbbh_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_sbmc_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_zsbh_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_clfw_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_jddj_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_cldw_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_yxqz_LB;

@property (weak, nonatomic) IBOutlet UIImageView *m_isSelected_ImgV;


- (void)configureCellWithItem:(Bzqsb_Model* )item ;
@end
