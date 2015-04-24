//
//  Bzqsb_TableViewCellTitle.h
//  Measurement
//
//  Created by DTSoft on 15/4/24.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 * 下厂任务 公共信息 标准器设备  为了全选
 */
#import <UIKit/UIKit.h>


@class Bzqsb_TableViewCellTitle;


@protocol Bzqsb_TableViewCell_FullSelecteDelegate <NSObject>

-(void)Bzqsb_TableViewCellTitleDidFullSelectedByCell:(Bzqsb_TableViewCellTitle *) cell;

-(void)Bzqsb_TableViewCellTitle:(Bzqsb_TableViewCellTitle *) cell ByFullBtn:(UIButton *) selectedBtn;

@end

@interface Bzqsb_TableViewCellTitle : UITableViewCell

@property(nonatomic , assign)id<Bzqsb_TableViewCell_FullSelecteDelegate> m_delegate;

@end
