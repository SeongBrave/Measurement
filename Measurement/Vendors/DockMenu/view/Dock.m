//
//  Dock.m
//  Measurement
//
//  Created by DTSoft on 14/12/21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "Dock.h"
#import "DockItem.h"
#import "MenuView.h"
#import "UIImage+Fit.h"
#import "HeaderView.h"


@interface Dock()
{
    HeaderView *_headerView;
    MenuView *_menuView;
    UIImageView *_divider;
}
@end
@implementation Dock


-(id)initWithDockView
{
    self = [super init];
    if (self) {
        
        // 1.头像IconView
        _headerView = [[HeaderView alloc] initWithHeaderView];
        _headerView.backgroundColor = [UIColor colorWithRed:0.468 green:0.000 blue:0.005 alpha:1.000];
        [self addSubview:_headerView];
        
        // 2.菜单MenuView
        _menuView = [[MenuView alloc]initWithMenuView];

        __unsafe_unretained Dock *dock = self;
        _menuView.menuItemClickBlock = ^(DockItem *item)
        {
            
            if (dock.dockItemClickBlock)
            {
                dock.dockItemClickBlock(item);
            }
        };
        [self addSubview:_menuView];
        

        [ _headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.leading.equalTo(@0);
            make.top.equalTo(@0);
            make.trailing.equalTo(@0);
            make.height.equalTo(@140);
            
            
        }];
        
        [ _menuView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.leading.equalTo(@0);
            make.top.equalTo(_headerView.mas_bottom).offset(0);
            make.trailing.equalTo(@0);
            make.bottom.equalTo(@0);
            
            
        }];
        
    }
    return self;
}

#pragma mark 点击了头像
- (void)iconClick
{
    // 1.清除MenuView内部选中的Item
    [_menuView unselectAll];
    
    // 2.通知block
    if (_dockItemClickBlock) {
        DockItem *item = [DockItem itemWithIcon:nil className:@"ProfileViewController"];
        _dockItemClickBlock(item);
    }
}




@end
