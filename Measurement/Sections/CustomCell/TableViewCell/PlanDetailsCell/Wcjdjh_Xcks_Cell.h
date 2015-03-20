//
//  Wcjdjh_Xcks_Cell.h
//  Measurement
//
//  Created by DTSoft on 15/3/20.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wcjdjh_Xcks_Model.h"


@class Wcjdjh_Xcks_Cell;

@protocol Wcjdjh_Xcks_CellDelegate <NSObject>

-(void)Wcjdjh_Xcks_Cell:(Wcjdjh_Xcks_Cell*) depCell didSelectedWithks_Model:(Wcjdjh_Xcks_Model *) ksModel;

@end


@interface Wcjdjh_Xcks_Cell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *m_departmentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *m_isSelectedImg;
@property (weak, nonatomic) IBOutlet UILabel *m_headsLabel;
@property (weak, nonatomic) IBOutlet UIButton *m_headsBtn;


@property(nonatomic , assign)id<Wcjdjh_Xcks_CellDelegate> m_Xcks_CellDelegate;


- (void)configureCellWithItem:( Wcjdjh_Xcks_Model* )product;


@end
