//
//  MenuView.h
//  Measurement
//
//  Created by DTSoft on 14/12/21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemView.h"

@class DockItem;

@interface MenuView : UIView
{
    MenuItemView *_currentItemView;
}

@property (nonatomic, copy) void (^menuItemClickBlock)(DockItem *item);



-(id)initWithMenuViewByMenuList:(NSArray *) listArr;

// 取消选中全部
- (void)unselectAll;


@end
