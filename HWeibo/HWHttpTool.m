//
//  HWHttpTool.m
//  HWeibo
//
//  Created by devzkn on 05/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "HWHttpTool.h"
/** 网络请求工具*/
@implementation HWHttpTool

+(void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //请求管理器
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    [mgr setResponseSerializer:[AFJSONResponseSerializer serializer]];//afn 默认的解析器
    /** 可以修改源代码，来支持更多的ContentTypes
     self.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript", nil];
     */
    [mgr POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<HWMultipartFormData>))block success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        id<HWMultipartFormData> data = (id<HWMultipartFormData>)formData;
        if (block) {
            block(data);
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


@end
