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
    
    
    UILabel *menuViewTitle = [[UILabel alloc]init];
    menuViewTitle.textColor = UIColorFromRGB(202, 201, 196);
    menuViewTitle.font = [UIFont systemFontOfSize:15];
    menuViewTitle.textAlignment = NSTextAlignmentCenter;
    menuViewTitle.text = LEFTMENUBARTITLE;
    
    [self addSubview:menuViewTitle];
    
    
    UILabel *menuViewTitle2 = [[UILabel alloc]init];
    
    menuViewTitle2.textColor = UIColorFromRGB(202, 201, 196);
    menuViewTitle2.font = [UIFont systemFontOfSize:11];
    [self addSubview:menuViewTitle2];
    
    [ menuViewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.bottom.equalTo(menuViewTitle2.mas_top).offset(-7);
        make.centerX.equalTo(@0);
    }];
    
    [ menuViewTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.bottom.equalTo(@-20);
        make.leading.equalTo(menuViewTitle.mas_leading).offset(0);
    }];
    

    
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
