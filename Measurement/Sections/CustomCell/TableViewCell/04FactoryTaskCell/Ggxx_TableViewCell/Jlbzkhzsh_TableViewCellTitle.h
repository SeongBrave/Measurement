//
//  Jlbzkhzsh_TableViewCellTitle.h
//  Measurement
//
//  Created by DTSoft on 15/4/24.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 * 下厂任务 公共信息  计量标准考核证书  为了全选
 */
#import <UIKit/UIKit.h>

@class Jlbzkhzsh_TableViewCellTitle;


@protocol Jlbzkhzsh_TableViewCell_FullSelecteDelegate <NSObject>

-(void)Jlbzkhzsh_TableViewCellTitleDidFullSelectedByCell:(Jlbzkhzsh_TableViewCellTitle *) cell;

-(void)Jlbzkhzsh_TableViewCellTitle:(Jlbzkhzsh_TableViewCellTitle *) cell ByFullBtn:(UIButton *) selectedBtn;

@end

@interface Jlbzkhzsh_TableViewCellTitle : UITableViewCell

@property(nonatomic , assign)id<Jlbzkhzsh_TableViewCell_FullSelecteDelegate> m_delegate;

@end
