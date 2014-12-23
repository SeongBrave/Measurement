//
//  CustomVitalSignsView.h
//  BedsNursingApp
//
//  Created by 成勇 on 14-5-29.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomVitalSignsView : UIView

@property(nonatomic , strong)UILabel *m_breathe_label;  //呼吸
@property(nonatomic , strong)UILabel *m_pulse_label;  //脉搏
@property(nonatomic , strong)UILabel *m_heartRate_label;  //心率
@property(nonatomic , strong)UILabel *m_title_label;   //标头


-(id)initWithCustomVitalSignsView;
-(void)UpdateCustomVitalSignsViewDataWithDict:(NSDictionary *)_dict;
@end
