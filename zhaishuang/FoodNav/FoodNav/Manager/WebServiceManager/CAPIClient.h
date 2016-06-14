//
//  CAPIClient.h
//  
//
//  Created by LiuCarl on 15/1/8.
//  Copyright (c) 2015年 Carl Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^ErrorRespondBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface CAPIClient : NSObject
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *baseURL;
- (AFHTTPRequestOperation *)getHttpRequestWithURL:(NSString *)url
                                       parameters:(id)parameters
                                          success:(void (^) (id responseObject))success
                                          failure:(ErrorRespondBlock)failure;

- (AFHTTPRequestOperation *)postHttpRequestWithURL:(NSString *)url
                                        parameters:(id)parameters
                                           success:(void (^) (id responseObject))success
                                           failure:(ErrorRespondBlock)failure;

- (void)cancelAllRequests;
@end
