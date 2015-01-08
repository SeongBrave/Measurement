//
//  PlanDetailsMans_DepCell.h
//  Measurement
//
//  Created by DTSoft on 15/1/8.
//  Copyright (c) 2015年 成勇. All rights reserved.
//


/**
 *  下厂人员 科室cell
 */

#import <UIKit/UIKit.h>
#import "ks_Model.h"

@class PlanDetailsMans_DepCell;

@protocol PlanDetailsMans_DepCellDelegate <NSObject>

-(void)planDetailsMans_DepCell:(PlanDetailsMans_DepCell*) depCell didSelectedWithks_Model:(ks_Model *) ksModel;

@end

@interface PlanDetailsMans_DepCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *m_departmentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *m_isSelectedImg;
@property (weak, nonatomic) IBOutlet UILabel *m_headsLabel;
@property (weak, nonatomic) IBOutlet UIButton *m_headsBtn;

@property(nonatomic , assign)id<PlanDetailsMans_DepCellDelegate> m_mans_DepDelegate;

- (void)configureCellWithItem:( ks_Model* )product;
@end
