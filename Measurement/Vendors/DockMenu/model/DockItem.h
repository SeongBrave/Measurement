//
//  DockItem.h
//  Measurement
//
//  Created by DTSoft on 14/12/21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DockItem : NSObject
@property (nonatomic, copy) NSString *icon; // 图标
@property(nonatomic , copy) NSString *selectedIcon; //选中时的图标
@property (nonatomic, copy) NSString *title; // 文字
@property (nonatomic, copy) NSString *className; // 点击Item要打开的控制器
@property (nonatomic, assign) BOOL modal; // 是否以模态窗口的形式展示

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title className:(NSString *)className modal:(BOOL)modal;

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title className:(NSString *)className modal:(BOOL)modal andSelectedIcon:(NSString *) selectedIcon;

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title className:(NSString *)className;

+ (id)itemWithIcon:(NSString *)icon className:(NSString *)className modal:(BOOL)modal;
+ (id)itemWithIcon:(NSString *)icon className:(NSString *)className;

@end
