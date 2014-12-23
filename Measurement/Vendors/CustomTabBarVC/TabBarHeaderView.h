//
//  TabBarHeaderView.h
//  ChildViewTest
//
//  Created by DTSoft on 14/10/20.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum
{
    TabBarFirst = 0,
    TabBarSecond
}TabBarItem;


@protocol TabBarHeaderViewDelegate <NSObject>

-(void)didSelectedWithIndex:(TabBarItem )tabBarItem;

@end

@interface TabBarHeaderView : UIView

- (instancetype)initWithViewModel:(id<TabBarHeaderViewDelegate> )tabBarViewdelete;


@end
