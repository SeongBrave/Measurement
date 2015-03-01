//
//  BaseViewController.h
//  FoodDelivery
//
//  Created by DTSoft on 14-10-14.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dialog.h"

@interface BaseViewController : UIViewController




@property(nonatomic , strong)Dialog *m_showDialog;

/**
 *  添加视图
 */
-(void)layoutMainCustomView;

/**
 *  初始化界面
 */
-(void)SetUpData;

@end
