//
//  Jlbzkhzsh_TableViewCell.h
//  Measurement
//
//  Created by DTSoft on 15/1/22.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  计量标准考核证书号
 */
#import <UIKit/UIKit.h>
#import "Jlbzkhzsh_Model.h"

@interface Jlbzkhzsh_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *m_sbbh_Lb;

@property (weak, nonatomic) IBOutlet UILabel *m_sbmc_LB;
@property (weak, nonatomic) IBOutlet UILabel *m_yxqz_LB;

@property (weak, nonatomic) IBOutlet UIImageView *m_isSelected_Imgv;

- (void)configureCellWithItem:(Jlbzkhzsh_Model* )item ;
@end
