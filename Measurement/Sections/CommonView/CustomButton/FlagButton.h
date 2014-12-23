//
//  FlagButton.h
//  BedsNursingApp
//
//  Created by dt on 14-6-21.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

/**
 *  相当于复选框，表示是否选中
 */
#import "CustomButton.h"

@interface FlagButton : CustomButton

@property(nonatomic , strong)NSString *m_keyValue; //用于保存代表的key值

@end
