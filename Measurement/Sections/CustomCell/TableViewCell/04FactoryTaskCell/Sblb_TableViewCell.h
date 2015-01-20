//
//  Sblb_TableViewCell.h
//  Measurement
//
//  Created by DTSoft on 15/1/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "SWTableViewCell.h"

@interface Sblb_TableViewCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_txmLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_jltxLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_jcfwLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_ggxhLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_sccjLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_lbLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

- (void)configureCellWithItem:(id )item andIndex:(NSUInteger)index;


@end
