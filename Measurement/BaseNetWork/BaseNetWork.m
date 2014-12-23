//
//  BaseNetWork.m
//  FoodDelivery
//
//  Created by DTSoft on 14-10-14.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import "BaseNetWork.h"

static BaseNetWork *instance =nil;

@implementation BaseNetWork


+(BaseNetWork *)getInstance
{
    @synchronized(self) {
        if (instance==nil) {
            instance=[[BaseNetWork alloc] init];
        }
    }
    return instance;
}

-(AFHTTPRequestOperationManager*)getRequestOperationManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //请求参数序列化类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //响应结果序列化类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    return manager;
    
}

// deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSArray *eventInfoArray)

/**
 *  Get请求
 *
 *  @param path       url地址
 *  @param parameters 请求参数
 *
 *  @return 返回RACSignal信号
 */
- (RACSignal *)rac_getPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    return [self rac_RequestPath:path parameters:parameters andType:RequestGet];
}


/**
 *  Podt请求
 *
 *  @param path       url地址
 *  @param parameters 请求参数
 *
 *  @return 返回RACSignal信号
 */
- (RACSignal *)rac_postPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    return [self rac_RequestPath:path parameters:parameters andType:RequestPost];
}


/**
 *  Put请求
 *
 *  @param path       url地址
 *  @param parameters 请求参数
 *
 *  @return 返回RACSignal信号
 */
- (RACSignal *)rac_putPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    return [self rac_RequestPath:path parameters:parameters andType:RequestPut];
}


/**
 *  Delete请求
 *
 *  @param path       url地址
 *  @param parameters 请求参数
 *
 *  @return 返回RACSignal信号
 */
- (RACSignal *)rac_deletePath:(NSString *)path parameters:(NSDictionary *)parameters
{
    return [self rac_RequestPath:path parameters:parameters andType:RequestDelete];
}

/**
 *  Pat请求
 *
 *  @param path       url地址
 *  @param parameters 请求参数
 *
 *  @return 返回RACSignal信号
 */
- (RACSignal *)rac_patchPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    return [self rac_RequestPath:path parameters:parameters andType:RequestPatch];
    
}

/**
 *  封装原始请求
 *
 *  @param path        请求地址
 *  @param parameters  请求参数
 *  @param requestType 请求类型
 *
 *  @return 返回RACSignal信号
 */
- (RACSignal *)rac_RequestPath:(NSString *)path parameters:(NSDictionary *)parameters andType:(RequestType ) requestType
{
    return [RACSignal
            createSignal:^RACDisposable *(id<RACSubscriber> subscriber){
                
                AFHTTPRequestOperationManager *manager = [self getRequestOperationManager];
                
                AFHTTPRequestOperation *opation;
                
                switch (requestType) {
                    case RequestPost:
                    {
                        
                        opation = [manager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            
                            [subscriber sendNext:responseObject];
                            [subscriber sendCompleted];
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            
                            [subscriber sendError:error];
                            
                        }];
                        
                    }
                        break;
                    case RequestGet:
                    {
                        
                        opation = [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            
                            
                            NSLog(@"151RequestGet");
                            [subscriber sendNext:responseObject];
                            [subscriber sendCompleted];
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            
                             NSLog(@"156RequestGet%@",error);
                            [subscriber sendError:error];
                            
                        }];
                        
                    }
                        break;
                    case RequestPut:
                    {
                        
                        opation = [manager PUT:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            
                            [subscriber sendNext:responseObject];
                            [subscriber sendCompleted];
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            
                            [subscriber sendError:error];
                            
                        }];
                        
                    }
                        break;
                    case RequestPatch:
                    {
                        
                        opation = [manager PATCH:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            
                            [subscriber sendNext:responseObject];
                            [subscriber sendCompleted];
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            
                            [subscriber sendError:error];
                            
                        }];
                        
                    }
                        break;
                    case RequestDelete:
                    {
                        
                        opation = [manager DELETE:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            
                            [subscriber sendNext:responseObject];
                            [subscriber sendCompleted];
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            
                            [subscriber sendError:error];
                            
                        }];
                        
                    }
                        break;
                    default:
                        break;
                }
                return [RACDisposable disposableWithBlock:^{
                    
                    [opation cancel];
                    
                }];
                
            }];
    
}

@end

