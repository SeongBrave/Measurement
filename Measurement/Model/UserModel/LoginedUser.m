//
//  LoginedUser.m
//  Measurement
//
//  Created by DTSoft on 15/1/11.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "LoginedUser.h"

static LoginedUser *sharedObj = nil;

@implementation LoginedUser


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"comcname" : @"comcname",
             @"comcode" : @"comcode",
             @"comename" : @"comename",
             @"password" : @"password",
             @"usercode" : @"usercode",
             @"username" : @"username",
             @"validstatus" : @"validstatus",
             };
}

+(id)sharedInstance
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj = [[self alloc] init];
        }
    }
    return sharedObj;
}
- (id) copyWithZone:(NSZone *)zone //第四步
{
    return self;
}
-(void)updateWithDict:(NSDictionary *) dict
{
    NSString *comcnameStr = [dict objectForKey:@"comcname"];
    
 
    self.comcname = [NSString stringWithFormat:@"%@",comcnameStr];
    
    
    NSString *comcodeStr = [dict objectForKey:@"comcode"];
    
    if ([comcodeStr isNotNull] && comcodeStr) {
        
        self.comcode = comcodeStr;
    }else
    {
        self.comcode = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
    }
    
    NSString *passwordStr = [dict objectForKey:@"password"];
    
    if ([passwordStr isNotNull]&& passwordStr) {
        
        self.password = passwordStr;
    }else
    {
        self.password = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
    }
    
    NSString *usercodeStr = [dict objectForKey:@"usercode"];
    
    if ([usercodeStr isNotNull] && usercodeStr) {
        self.usercode = usercodeStr;
    }else
    {
        self.usercode = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
    }
    
    NSString *usernameStr = [dict objectForKey:@"username"];
    
    if ([usernameStr isNotNull] && usernameStr) {
        self.username = usernameStr;
    }else
    {
        self.username = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
    }
    
    NSString *validstatusStr = [dict objectForKey:@"validstatus"];
    
    if ([validstatusStr isNotNull] && validstatusStr) {
        self.validstatus = validstatusStr;
    }else
    {
        self.validstatus = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
    }
    
    
    
    //第一次初始化的时候给单例赋值
    sharedObj = self;
    
}
-(id)initWithDict:(NSDictionary*) dict
{
    if (self) {
        
        NSString *comcnameStr = [dict objectForKey:@"comcname"];
        
        
        self.comcname = [NSString stringWithFormat:@"%@",comcnameStr];
        
        
        NSString *comcodeStr = [dict objectForKey:@"comcode"];
        
        if ([comcodeStr isNotNull] && comcodeStr) {
            
            self.comcode = comcodeStr;
        }else
        {
            self.comcode = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
        }
        
        NSString *passwordStr = [dict objectForKey:@"password"];
        
        if ([passwordStr isNotNull]&& passwordStr) {
            
            self.password = passwordStr;
        }else
        {
            self.password = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
        }
        
        NSString *usercodeStr = [dict objectForKey:@"usercode"];
        
        if ([usercodeStr isNotNull] && usercodeStr) {
            self.usercode = usercodeStr;
        }else
        {
            self.usercode = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
        }
        
        NSString *usernameStr = [dict objectForKey:@"username"];
        
        if ([usernameStr isNotNull] && usernameStr) {
            self.username = usernameStr;
        }else
        {
            self.username = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
        }
        
        NSString *validstatusStr = [dict objectForKey:@"validstatus"];
        
        if ([validstatusStr isNotNull] && validstatusStr) {
            self.validstatus = validstatusStr;
        }else
        {
            self.validstatus = @"";  //将来就以@“”判断，就可以防止后台数据为空时可能引起的crash
        }
        
    }
    
    
    //第一次初始化的时候给单例赋值
    sharedObj = self;
    return self;

}

@end
