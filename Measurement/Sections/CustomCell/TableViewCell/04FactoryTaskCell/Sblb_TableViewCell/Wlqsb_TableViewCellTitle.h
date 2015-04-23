//
//  Wlqsb_TableViewCellTitle.h
//  Measurement
//
//  Created by DTSoft on 15/4/23.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  为了全选实现 该类
 */
#import <UIKit/UIKit.h>
@class Wlqsb_TableViewCellTitle;


@protocol Wlqsb_TableViewCell_FullSelecteDelegate <NSObject>

-(void)Wlqsb_TableViewCellTitleDidFullSelectedByCell:(Wlqsb_TableViewCellTitle *) cell;

-(void)Wlqsb_TableViewCellTitle:(Wlqsb_TableViewCellTitle *) cell ByFullBtn:(UIButton *) selectedBtn;

@end

@interface Wlqsb_TableViewCellTitle : UITableViewCell


@property(nonatomic , assign)id<Wlqsb_TableViewCell_FullSelecteDelegate> m_delegate;


@end
