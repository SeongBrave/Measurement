//
//  BaseNetWork.h
//  FoodDelivery
//
//  Created by DTSoft on 14-10-14.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>

typedef enum{
    RequestPost =0,  //Post请求方式
    RequestGet,
    RequestDelete,
    RequestPut,
    RequestPatch
    
}RequestType;



@interface BaseNetWork : NSObject

@property(nonatomic, strong)Dialog *m_show;

-(void)hideDialog;
-(void)showDialog;
+(BaseNetWork *)getInstance;

//- (RACSignal *)rac_enqueueHTTPRequestOperation:(AFHTTPRequestOperation *)requestOperation;
//- (RACSignal *)rac_enqueueHTTPRequestOperationWithRequest:(NSURLRequest *)urlRequest;
//
//- (RACSignal *)rac_enqueueBatchOfHTTPRequestOperations:(NSArray *)requestOperations;
//- (RACSignal *)rac_enqueueBatchOfHTTPRequestOperationsWithRequests:(NSArray *)urlRequests;

/**
 *  Get请求
 *
 *  @param path       url地址
 *  @param parameters 请求参数
 *
 *  @return 返回RACSignal信号
 */
- (RACSignal *)rac_getPath:(NSString *)path parameters:(NSDictionary *)parameters;


/**
 *  Podt请求
 *
 *  @param path       url地址
 *  @param parameters 请求参数
 *
 *  @return 返回RACSignal信号
 */
- (RACSignal *)rac_postPath:(NSString *)path parameters:(NSDictionary *)parameters;


/**
 *  Put请求
 *
 *  @param path       url地址
 *  @param parameters 请求参数
 *
 *  @return 返回RACSignal信号
 */
- (RACSignal *)rac_putPath:(NSString *)path parameters:(NSDictionary *)parameters;


/**
 *  Delete请求
 *
 *  @param path       url地址
 *  @param parameters 请求参数
 *
 *  @return 返回RACSignal信号
 */
- (RACSignal *)rac_deletePath:(NSString *)path parameters:(NSDictionary *)parameters;

/**
 *  Pat请求
 *
 *  @param path       url地址
 *  @param parameters 请求参数
 *
 *  @return 返回RACSignal信号
 */
- (RACSignal *)rac_patchPath:(NSString *)path parameters:(NSDictionary *)parameters;

/**
 *  封装原始请求
 *
 *  @param path        请求地址
 *  @param parameters  请求参数
 *  @param requestType 请求类型
 *
 *  @return 返回RACSignal信号
 */
- (RACSignal *)rac_RequestPath:(NSString *)path parameters:(NSDictionary *)parameters andType:(RequestType ) requestType;
@end
