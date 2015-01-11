//
//  ProgressOverviewCell.h
//  Measurement
//
//  Created by DTSoft on 15/1/10.
//  Copyright (c) 2015年 成勇. All rights reserved.
//


/**
 *  进度检测的黑体字
 */
#import <UIKit/UIKit.h>
#import "jcjd_Model.h"

@interface ProgressOverviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *m_showTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *m_stateImgV;
@property (weak, nonatomic) IBOutlet UIImageView *upDownImgV;


- (void)configureCellWithItem:( jcjd_Model* )product;

- (void)changeArrowWithUp:(BOOL)up;
@end
