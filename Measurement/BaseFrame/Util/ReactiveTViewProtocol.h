//
//  ReactiveTViewProtocol.h
//  FoodDelivery
//
//  Created by DTSoft on 14-10-14.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//


/**
 *  TableView代理实现mvvm的协议
 */

#import <Foundation/Foundation.h>

@protocol ReactiveTViewProtocol <NSObject>


/**
 *  用于把cell与modelview的数据绑定到一块
 *
 *  @param viewModel  用于绘制cell的viewmodel
 */
- (void)bindViewModel:(id)viewModel;

-(RACSignal *)getSignal;


@end
