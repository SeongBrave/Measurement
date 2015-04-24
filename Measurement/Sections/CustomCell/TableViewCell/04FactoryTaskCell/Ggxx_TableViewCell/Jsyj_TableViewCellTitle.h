//
//  Jsyj_TableViewCellTitle.h
//  Measurement
//
//  Created by DTSoft on 15/4/24.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 * 下厂任务 公共信息 技术依据  为了全选
 */
#import <UIKit/UIKit.h>


@class Jsyj_TableViewCellTitle;


@protocol Jsyj_TableViewCell_FullSelecteDelegate <NSObject>

-(void)Jsyj_TableViewCellTitleDidFullSelectedByCell:(Jsyj_TableViewCellTitle *) cell;

-(void)Jsyj_TableViewCellTitle:(Jsyj_TableViewCellTitle *) cell ByFullBtn:(UIButton *) selectedBtn;

@end

@interface Jsyj_TableViewCellTitle : UITableViewCell

@property(nonatomic , assign)id<Jsyj_TableViewCell_FullSelecteDelegate> m_delegate;

@end
