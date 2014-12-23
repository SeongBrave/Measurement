//
//  MenuItemView.m
//  Measurement
//
//  Created by DTSoft on 14/12/21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "MenuItemView.h"
#import "DockItem.h"
#import "UIImage+Fit.h"

@interface MenuItemView()
{
    UIImageView *_divider;
}
@end
@implementation MenuItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

#pragma mark 覆盖高亮时所做的行为
- (void)setHighlighted:(BOOL)highlighted {}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
}

- (void)setDockItem:(DockItem *)dockItem
{
    _dockItem = dockItem;
    
    // 1.设置图片
    [self setImage:[UIImage imageNamed:dockItem.icon] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:dockItem.selectedIcon] forState:UIControlStateSelected];
    
}

@end
