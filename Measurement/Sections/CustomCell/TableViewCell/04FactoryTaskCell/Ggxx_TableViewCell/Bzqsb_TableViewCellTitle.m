//
//  Bzqsb_TableViewCellTitle.m
//  Measurement
//
//  Created by DTSoft on 15/4/24.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "Bzqsb_TableViewCellTitle.h"

@implementation Bzqsb_TableViewCellTitle

- (void)awakeFromNib {
    // Initialization code
}

-(IBAction)fullSelected:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(Bzqsb_TableViewCellTitle:ByFullBtn:)]) {
        [self.m_delegate Bzqsb_TableViewCellTitle:self ByFullBtn:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
