//
//  CellItem.m
//  Measurement
//
//  Created by DTSoft on 14/12/21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "CellItem.h"

@implementation CellItem
+ (id)itemWithTitle:(NSString *)title cellItemType:(CellItemType)cellItemType
{
    CellItem *item = [[CellItem alloc] init];
    item.title = title;
    item.cellItemType = cellItemType;
    return item;
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    
    // 读档
    _on = [[NSUserDefaults standardUserDefaults] boolForKey:title];
}

- (void)setOn:(BOOL)on
{
    _on = on;
    
    // 归档
    [[NSUserDefaults standardUserDefaults] setBool:on forKey:_title];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 调用block
    if (_switchChangeBlock) {
        _switchChangeBlock(self);
    }
}
@end
