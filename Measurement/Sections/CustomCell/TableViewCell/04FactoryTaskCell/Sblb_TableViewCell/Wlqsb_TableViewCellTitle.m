//
//  Wlqsb_TableViewCellTitle.m
//  Measurement
//
//  Created by DTSoft on 15/4/23.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "Wlqsb_TableViewCellTitle.h"

@implementation Wlqsb_TableViewCellTitle

- (void)awakeFromNib {
    // Initialization code
}


-(IBAction)fullSelected:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(Wlqsb_TableViewCellTitle:ByFullBtn:)]) {
        [self.m_delegate Wlqsb_TableViewCellTitle:self ByFullBtn:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
