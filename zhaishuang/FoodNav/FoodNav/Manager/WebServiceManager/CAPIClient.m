//
//  CAPIClient.m
//  
//
//  Created by LiuCarl on 15/1/8.
//  Copyright (c) 2015年 Carl Liu. All rights reserved.
//

#import "CAPIClient.h"
#import "SVProgressHUD.h"

@implementation CAPIClient

- (instancetype)init {
    if (self = [super init]) {
//发布之前请设置服务器的Url
        self.baseURL = @"http://interface.xinzhigan.com:88";
        self.manager = [[AFHTTPRequestOperationManager alloc] init];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        self.manager.securityPolicy = securityPolicy;
        [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.manager.requestSerializer.timeoutInterval = 10.f;
        [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return self;
}
#pragma mark - 
#pragma mark Http Reques
- (AFHTTPRequestOperation *)getHttpRequestWithURL:(NSString *)url
                                       parameters:(id)parameters
                                          success:(void (^) (id responseObject))success
                                          failure:(ErrorRespondBlock)failure{
    NSLog(@"\r\n%@%@\nparam:%@", self.baseURL, url, parameters);
    NSString *tmpurl = NullString;
    if ([url rangeOfString:@"http"].location == NSNotFound) {
        tmpurl = [NSString stringWithFormat:@"%@%@",self.baseURL,url];
    } else {
        tmpurl = url;
    }
    return [self.manager GET:tmpurl
                  parameters:parameters
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        success(responseObject);
                         NSLog(@"\r\n%@", operation.responseString);
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        failure(operation, error);
                         NSLog(@"\r\n%@", operation.responseString);
                     }];
}

- (AFHTTPRequestOperation *)postHttpRequestWithURL:(NSString *)url
                                        parameters:(id)parameters
                                           success:(void (^)(id responseObject))success
                                           failure:(ErrorRespondBlock)failure{
    NSLog(@"\r\n%@%@\nparam:%@", self.baseURL, url, parameters);
    NSString *tmpurl = NullString;
    if ([url rangeOfString:@"http"].location == NSNotFound) {
        tmpurl = [NSString stringWithFormat:@"%@%@",self.baseURL,url];
    } else {
        tmpurl = url;
    }
    return [self.manager POST:tmpurl
                   parameters:parameters
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          success(responseObject);
                          NSLog(@"\r\n%@", operation.responseString);
                      }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          failure(operation, error);
                          NSLog(@"\r\n%@", operation.responseString);
                      }];
}

- (AFHTTPRequestOperation *)postHttpRequestWithURL:(NSString *)url
                                        parameters:(id)parameters
                                              data:(NSData *)data
                                           success:(void (^) (NSData *responseObject)) success
                                           failure: (ErrorRespondBlock) failure
{
    NSString *tmpurl = NullString;
    if ([url rangeOfString:@"http"].location == NSNotFound) {
        tmpurl = [NSString stringWithFormat:@"%@%@",self.baseURL,url];
    } else {
        tmpurl = url;
    }
    return   [self.manager POST:tmpurl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (data) {
            [formData appendPartWithFileData:data name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation.responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}
- (void)cancelAllRequests {
    [[self.manager operationQueue] cancelAllOperations];
}
@end
