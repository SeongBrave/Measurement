//
//  PlanDetailsHead_DepCell.h
//  Measurement
//
//  Created by DTSoft on 15/1/8.
//  Copyright (c) 2015年 成勇. All rights reserved.
//


/**
 *  下厂负责人 科室cell
 */
#import <UIKit/UIKit.h>
#import "ks_Model.h"

@class PlanDetailsHead_DepCell;

@protocol PlanDetailsHead_DepCellDelegate <NSObject>

-(void)planDetailsHead_DepCell:(PlanDetailsHead_DepCell*) depCell didSelectedWithks_Model:(ks_Model *) ksModel;

@end

@interface PlanDetailsHead_DepCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *m_departmentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *m_isSelectedImg;
@property (weak, nonatomic) IBOutlet UILabel *m_headsLabel;
@property (weak, nonatomic) IBOutlet UIButton *m_headsBtn;

@property(nonatomic , assign)id<PlanDetailsHead_DepCellDelegate> m_head_DepDelegate;



- (void)configureCellWithItem:( ks_Model* )product;

@end
