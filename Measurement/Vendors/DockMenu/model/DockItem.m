//
//  DockItem.m
//  Measurement
//
//  Created by DTSoft on 14/12/21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "DockItem.h"

@implementation DockItem

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title className:(NSString *)className modal:(BOOL)modal
{
    DockItem *item = [[DockItem alloc] init];
    item.icon = icon;
    item.title = title;
    item.className = className;
    item.modal = modal;
    return item;
}

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title className:(NSString *)className modal:(BOOL)modal andSelectedIcon:(NSString *) selectedIcon isSelected:(BOOL) isselected;
{
    DockItem *item = [[DockItem alloc] init];
    item.icon = icon;
    item.title = title;
    item.className = className;
    item.modal = modal;
    item.selectedIcon = selectedIcon;
    item.isSelected = isselected;
    return item;
}

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title className:(NSString *)className modal:(BOOL)modal isSelected:(BOOL) isselected
{
    return [self itemWithIcon:icon title:title className:className modal:NO andSelectedIcon:@"" isSelected:isselected];
    
}
+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title className:(NSString *)className isSelected:(BOOL) isselected
{
    return [self itemWithIcon:icon title:title className:className modal:NO isSelected:isselected];
}

+ (id)itemWithIcon:(NSString *)icon className:(NSString *)className modal:(BOOL)modal isSelected:(BOOL) isselected
{
    return [self itemWithIcon:icon title:nil className:className modal:modal isSelected:isselected];
}

+ (id)itemWithIcon:(NSString *)icon className:(NSString *)className isSelected:(BOOL) isselected
{
    return [self itemWithIcon:icon title:nil className:className modal:NO isSelected:isselected];
}


@end
