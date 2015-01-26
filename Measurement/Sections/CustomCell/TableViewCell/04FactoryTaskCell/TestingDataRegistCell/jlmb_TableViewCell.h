//
//  jlmb_TableViewCell.h
//  Measurement
//
//  Created by DTSoft on 15/1/23.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  原始 记录模板
 */
#import <UIKit/UIKit.h>

@interface jlmb_TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_index_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_jlmbbh_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_jlmbmc_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_syfw_LB;

@property (weak, nonatomic) IBOutlet UILabel *m_lx_LB;


@property (weak, nonatomic) IBOutlet UILabel *m_cjr_LB;

@property (weak, nonatomic) IBOutlet UIImageView *m_state_ImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_cjsj_LB;

- (void)configureCellWithItem:(id )item andIndex:(NSUInteger)index;


@end
