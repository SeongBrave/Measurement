//
//  Jlbzkhzsh_TableViewCellTitle.m
//  Measurement
//
//  Created by DTSoft on 15/4/24.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "Jlbzkhzsh_TableViewCellTitle.h"

@implementation Jlbzkhzsh_TableViewCellTitle

- (void)awakeFromNib {
    // Initialization code
}

-(IBAction)fullSelected:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(Jlbzkhzsh_TableViewCellTitle:ByFullBtn:)]) {
        [self.m_delegate Jlbzkhzsh_TableViewCellTitle:self ByFullBtn:sender];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
