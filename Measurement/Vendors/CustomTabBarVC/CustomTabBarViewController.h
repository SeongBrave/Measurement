//
//  CustomTabBarViewController.h
//  ChildViewTest
//
//  Created by DTSoft on 14/10/20.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomTabBarViewController : UIViewController



- (instancetype)initWithFirstView:(UIView *)firstView andSecondView:(UIView *)secondView;

- (instancetype)initWithViewModel:(UIViewController *)firstTabVC andSecondTabVC:(UIViewController *)secondTabVC;
@end
