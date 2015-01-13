//
//  BaseNetWork.m
//  FoodDelivery
//
//  Created by DTSoft on 14-10-14.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import "BaseNetWork.h"

static BaseNetWork *instance =nil;

@interface BaseNetWork ()

/**
 *  显示到bgvc界面上
 */
@property(nonatomic , strong)UIViewController *bgVC;
@property(nonatomic , assign)BOOL isShow;


@end
@implementation BaseNetWork


+(BaseNetWork *)getInstance
{
    @synchronized(self) {
        if (instance==nil) {
            instance=[[BaseNetWork alloc] init];
            instance.m_show = [[Dialog alloc]init];
            instance.isShow = NO;
            instance.bgVC = nil;
            
        }
    }
    return instance;
}

-(void)hideDialog
{
    self.isShow = NO;
   
}

-(void)showDialogWithVC:(UIViewController *) Vc
{
    self.isShow = YES;
     self.bgVC = Vc;
}
-(void)showDialog
{
    self.isShow = YES;
}
-(AFHTTPRequestOperationManager*)getRequestOperationManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //请求参数序列化类型
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
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
    
    if (![path hasPrefix:@"http://"]) {
       path = [NSString stringWithFormat:@"%@%@",defaultWebServiceUrl,path];
    }
    
    @weakify(self)
    return [RACSignal
            createSignal:^RACDisposable *(id<RACSubscriber> subscriber){
                
                @strongify(self)
                if (self.isShow&&self.bgVC !=nil) {
                    [self.m_show showProgress:_bgVC withLabel:@"正在加载..."];
                    
                }else if (self.isShow)
                {
                    [self.m_show showCenterProgressWithLabel:@"正在加载..."];
                }
                
                AFHTTPRequestOperationManager *manager = [self getRequestOperationManager];
                
                AFHTTPRequestOperation *opation;
                
                switch (requestType) {
                    case RequestPost:
                    {
                        
                        opation = [manager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            
                            @strongify(self)
                            if (self.isShow) {
                               [self.m_show hideProgress];
                                self.bgVC = nil;
                            }
                            [subscriber sendNext:responseObject];
                            [subscriber sendCompleted];
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            @strongify(self)
                            if (self.isShow) {
                                self.bgVC = nil;
                                [self.m_show hideProgress];
                            }
                            [subscriber sendError:error];
                            
                        }];
                        
                    }
                        break;
                    case RequestGet:
                    {
                        
                        opation = [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            
                            @strongify(self)
                            if (self.isShow) {
                                self.bgVC = nil;
                                [self.m_show hideProgress];
                            }
                            [subscriber sendNext:responseObject];
                            [subscriber sendCompleted];
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            
                            @strongify(self)
                            if (self.isShow) {
                                self.bgVC = nil;
                                [self.m_show hideProgress];
                            }
                            [subscriber sendError:error];
                            
                        }];
                        
                    }
                        break;
                    case RequestPut:
                    {
                        
                        opation = [manager PUT:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            @strongify(self)
                            if (self.isShow) {
                                self.bgVC = nil;
                                [self.m_show hideProgress];
                            }
                            [subscriber sendNext:responseObject];
                            [subscriber sendCompleted];
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            @strongify(self)
                            if (self.isShow) {
                                self.bgVC = nil;
                                [self.m_show hideProgress];
                            }
                            [subscriber sendError:error];
                            
                        }];
                        
                    }
                        break;
                    case RequestPatch:
                    {
                        
                        opation = [manager PATCH:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            @strongify(self)
                            if (self.isShow) {
                                self.bgVC = nil;
                                [self.m_show hideProgress];
                            }
                            [subscriber sendNext:responseObject];
                            [subscriber sendCompleted];
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            @strongify(self)
                            if (self.isShow) {
                                self.bgVC = nil;
                                [self.m_show hideProgress];
                            }
                            [subscriber sendError:error];
                            
                        }];
                        
                    }
                        break;
                    case RequestDelete:
                    {
                        
                        opation = [manager DELETE:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            @strongify(self)
                            if (self.isShow) {
                                self.bgVC = nil;
                                [self.m_show hideProgress];
                            }
                            [subscriber sendNext:responseObject];
                            [subscriber sendCompleted];
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            @strongify(self)
                            if (self.isShow) {
                                self.bgVC = nil;
                                [self.m_show hideProgress];
                            }
                            [subscriber sendError:error];
                            
                        }];
                        
                    }
                        break;
                    default:
                        break;
                }
                return [RACDisposable disposableWithBlock:^{
                    @strongify(self)
                    if (self.isShow) {
                        self.bgVC = nil;
                        [self.m_show hideProgress];
                    }
                    [opation cancel];
                    
                }];
                
            }];
    
}

@end

