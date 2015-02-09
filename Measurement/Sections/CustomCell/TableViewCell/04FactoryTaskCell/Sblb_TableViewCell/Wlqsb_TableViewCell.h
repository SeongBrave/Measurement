//
//  Wlqsb_TableViewCell.h
//  Measurement
//
//  Created by DTSoft on 15/2/9.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  未领取设备
 */
#import "SWTableViewCell.h"

@interface Wlqsb_TableViewCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_txmLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_jltxLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_jcfwLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_dwmcLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_ggxhLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_sccjLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_lbLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *m_State_ImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_zsStateLabel;

- (void)configureCellWithItem:(id )item andIndex:(NSUInteger)index;


@end
