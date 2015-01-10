//
//  MyPlanPopVC.m
//  Measurement
//
//  Created by DTSoft on 15/1/3.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "MyPlanPopVC.h"

@implementation MyPlanPopVC

- (IBAction)dismissClick:(id)sender {
    
    if ([self.m_popDelegate respondsToSelector:@selector(dismissPopoverSelected)]) {
        [self.m_popDelegate dismissPopoverSelected];
    }
    
    //asdfasdf
}
@end
