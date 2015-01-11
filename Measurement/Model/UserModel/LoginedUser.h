//
//  LoginedUser.h
//  Measurement
//
//  Created by DTSoft on 15/1/11.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <Mantle.h>

@interface LoginedUser : MTLModel<MTLJSONSerializing>

/**
 *  科室名
 */
@property (nonatomic, copy) NSString *comcname;

/**
 * 科室编号
 */
@property (nonatomic, copy) NSString *comcode;

/**
 *
 */
@property (nonatomic, copy) NSString *password;

/**
 * 用户编号
 */
@property (nonatomic, copy) NSString *usercode;


/**
 *  用户名
 */
@property (nonatomic, copy) NSString *username;

/**
 * 登陆状态
 */
@property (nonatomic, copy) NSString *validstatus;


//整个项目必定是保持一个LoginedUser，符合单例模式
+(id)sharedInstance;

-(id)initWithDict:(NSDictionary*) _dict;
@end
