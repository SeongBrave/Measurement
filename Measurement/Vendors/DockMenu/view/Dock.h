//
//  Dock.h
//  Measurement
//
//  Created by DTSoft on 14/12/21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DockItem;

@interface Dock : UIView

@property (nonatomic, copy) void (^dockItemClickBlock)(DockItem *item);


-(id)initWithDockViewByMenuList:(NSArray *) listArr;

@end
