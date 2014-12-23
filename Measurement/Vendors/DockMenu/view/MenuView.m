//
//  MenuView.m
//  Measurement
//
//  Created by DTSoft on 14/12/21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "MenuView.h"
#import "MenuItemView.h"
#import "DockItem.h"
#import "UIImage+Fit.h"

@interface MenuView()
{
    NSArray *_dockItems;
    
    MenuItemView *_currentItemView;
}
@end

@implementation MenuView


-(id)initWithMenuView
{
    self = [super init];
    if (self) {
        [self addDockItems];
        
        // 2.添加按钮
        [self addMenuItemViews];
        
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

#pragma mark 先添加DockItem
- (void)addDockItems
{
    _dockItems = @[

                   [DockItem itemWithIcon:@"tab-nav-bjgl-selected" title:@"计划总览" className:@"ProgramOverviewViewController" modal:NO andSelectedIcon:@"ab-nav-jhzl-selected"],
                   [DockItem itemWithIcon:@"tab-nav-ksjh-defauit" title:@"科室计划" className:@"PlanningDepartmentViewController" modal:NO andSelectedIcon:@"ab-nav-ksjh-selected"],
                   [DockItem itemWithIcon:@"tab-nav-wcjdjh-defauit" title:@"我创建的计划" className:@"MyPlanViewController" modal:NO andSelectedIcon:@"ab-nav-wcjdjh-selected"],
                   [DockItem itemWithIcon:@"tab-nav-xcrw-defauit" title:@"下厂任务" className:@"FactoryTaskViewController" modal:NO andSelectedIcon:@"ab-nav-xcrw-selected"],
                   [DockItem itemWithIcon:@"tab-nav-jcrwcx-defauit" title:@"监测任务查询" className:@"ViewController" modal:NO andSelectedIcon:@"ab-nav-jcrwcx-selected"],
                   [DockItem itemWithIcon:@"tab-nav-hyrw-defauit" title:@"核验任务" className:@"ViewController" modal:NO andSelectedIcon:@"ab-nav-hyrw-selected"],
                   [DockItem itemWithIcon:@"tab-nav-pzrw-defauit" title:@"批准任务" className:@"ViewController" modal:NO andSelectedIcon:@"ab-nav-pzrw-selected"],
                   [DockItem itemWithIcon:@"tab-nav-zsdb-defauit" title:@"证书担保" className:@"ViewController" modal:NO andSelectedIcon:@"ab-nav-zsdb-selected"],
                   [DockItem itemWithIcon:@"tab-nav-bjgl-defauit" title:@"报价管理" className:@"ViewController" modal:NO andSelectedIcon:@"ab-nav-bjgl-selected"],
                   [DockItem itemWithIcon:@"tab-nav-sfgl-defauit" title:@"收费管理" className:@"ViewController" modal:NO andSelectedIcon:@"ab-nav-sfgl-selected"],
                   [DockItem itemWithIcon:@"tab-nav-jhzl-defauit" title:@"计划总览" className:@"ViewController" modal:YES andSelectedIcon:@"ab-nav-jhzl-selected"],
                   [DockItem itemWithIcon:@"tab-nav-ksjh-defauit" title:@"科室计划" className:@"ViewController" modal:YES andSelectedIcon:@"ab-nav-ksjh-selected"],
                   [DockItem itemWithIcon:@"tab-nav-wcjdjh-defauit" title:@"我创建的计划" className:@"ViewController" modal:YES andSelectedIcon:@"ab-nav-wcjdjh-selected"],
                   [DockItem itemWithIcon:@"tab-nav-xcrw-defauit" title:@"下厂任务" className:@"ViewController" modal:YES andSelectedIcon:@"ab-nav-xcrw-selected"],
                   [DockItem itemWithIcon:@"tab-nav-jcrwcx-defauit" title:@"监测任务查询" className:@"ViewController" modal:YES andSelectedIcon:@"ab-nav-jcrwcx-selected"],
                   [DockItem itemWithIcon:@"tab-nav-hyrw-defauit" title:@"核验任务" className:@"ViewController" modal:YES andSelectedIcon:@"ab-nav-hyrw-selected"],
                   [DockItem itemWithIcon:@"tab-nav-pzrw-defauit" title:@"批准任务" className:@"ViewController" modal:YES andSelectedIcon:@"ab-nav-pzrw-selected"],
                   [DockItem itemWithIcon:@"tab-nav-zsdb-defauit" title:@"证书担保" className:@"ViewController" modal:YES andSelectedIcon:@"ab-nav-zsdb-selected"],
                   [DockItem itemWithIcon:@"tab-nav-bjgl-defauit" title:@"报价管理" className:@"ViewController" modal:YES andSelectedIcon:@"ab-nav-bjgl-selected"],
                   [DockItem itemWithIcon:@"tab-nav-sfgl-defauit" title:@"收费管理" className:@"ViewController" modal:YES andSelectedIcon:@"ab-nav-sfgl-selected"],
                   ];
    
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
    if(![itemView.dockItem.title isEqualToString:@"设置"]) {
        _currentItemView.selected = NO;
        itemView.selected = YES;
        _currentItemView = itemView;
    }
    
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
