//
//  MenuView.m
//  Measurement
//
//  Created by DTSoft on 14/12/21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "MenuView.h"

#import "DockItem.h"
#import "UIImage+Fit.h"

@interface MenuView()
{
    NSArray *_dockItems;
    
    
}
@end

@implementation MenuView


-(id)initWithMenuViewByMenuList:(NSArray *) listArr
{
    self = [super init];
    if (self) {
        _dockItems = listArr;
        // 2.添加按钮
        [self addMenuItemViews];
        
        self.backgroundColor = UIColorFromRGB(153,149,138);
    }
    return self;
}

#pragma mark 先添加DockItem
- (void)addDockItems
{

}

#pragma mark 添加按钮
- (void)addMenuItemViews
{
    int count = _dockItems.count;
    for (int i = 0; i<count; i++) {
        MenuItemView *btn = [[MenuItemView alloc] init];

        btn.dockItem = _dockItems[i];
        [btn addTarget:self action:@selector(menuItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [ btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(@(i * kIconMaxHeight));
            make.leading.equalTo(@0);
            make.trailing.equalTo(@0);
            make.height.equalTo(@kIconMaxHeight);
        }];
    }
}

- (void)menuItemClick:(MenuItemView *)itemView
{
    _currentItemView.selected = NO;
    itemView.selected = YES;
    _currentItemView = itemView;
    

    // 将事件传递给block
    if (_menuItemClickBlock)
    {
        _menuItemClickBlock(itemView.dockItem);
    }
}

- (void)unselectAll
{
    _currentItemView.selected = NO;
    _currentItemView = nil;
}

@end
