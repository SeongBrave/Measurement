//
//  CustomBodyTempView.h
//  BedsNursingApp
//
//  Created by 成勇 on 14-5-29.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBodyTempView : UIView

@property(nonatomic , strong)UILabel *m_bodyTemp_label;  //体温
@property(nonatomic , strong)UILabel *m_oldbodyTemp_label;  //原体温
@property(nonatomic , strong)UILabel *m_tempType_label;  //体温类型
@property(nonatomic , strong)UILabel *m_title_label;   //标头


-(id)initWithCustomBodyTempView;
-(void)UpdateCustomBodyTempViewDataWithDict:(NSDictionary *)_dict;


@end
