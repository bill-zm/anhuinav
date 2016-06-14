//
//  CAppService.m
//
//  Created by LiuCarl on 15/1/8.
//  Copyright (c) 2015年 Carl Liu. All rights reserved.
//
#import "CAppService.h"
#import "CAPIClient.h"
static CAppService *appService = nil;
@implementation CAppServiceError

- (instancetype)initWithType:(ykAppServiceError)type andMessage:(NSString *)message {
    if (self = [super init]) {
        self.errorType = type;
        self.errorMessage = message;
        return self;
    }
    return nil;
}

+ (instancetype)type:(ykAppServiceError)type message:(NSString *)message {
    return [[self alloc] initWithType:type andMessage:message];
}

+ (instancetype)error:(NSError *)error {
            return [[self alloc] initWithType:-1 andMessage:NSLocalizedString(@"网络错误",@"")];
}

@end

@interface CAppService ()
@property (nonatomic, strong) CAPIClient *client;

@end

@implementation CAppService

- (instancetype)init {
    if (self = [super init]) {
        self.client = [[CAPIClient alloc] init];
    }
    
    return self;
}
DEFINE_SINGLETON_FOR_CLASS(CAppService);
#pragma mark - API WebService
- (AFHTTPRequestOperation *)getSearch_request:(NSString *)serText
                                      success:(void (^)(NSDictionary *model))success
                                      failure:(AppServiceErrorRespondBlock)failure
{
    NSString *url = @"/?app=warehouse&act=index&pn=5&p=2&warehouse_name=%@";
    if([Common isEmptyString:serText])
        serText = NullString;
    url = [NSString stringWithFormat:url,serText];
    return [self.client getHttpRequestWithURL:url
                                   parameters:nil
                                      success:^(id responseObject) {
                                          success(responseObject);
                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          failure([CAppServiceError error:error]);
                                      }];
}
- (AFHTTPRequestOperation *)isLogin_request:(void (^)(NSDictionary *model))success
                                      failure:(AppServiceErrorRespondBlock)failure
{
    NSString *url = @"/?app=warehouse&act=isneedLoginCheck";
    return [self.client getHttpRequestWithURL:url
                                    parameters:nil
                                       success:^(id responseObject) {
                                           success(responseObject);
                                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           failure([CAppServiceError error:error]);
                                       }];
}
//
- (AFHTTPRequestOperation *)appLogin_request:(NSString *)username
                                    password:(NSString *)password
                                     success:(void (^)(NSDictionary *model))success
                                     failure:(AppServiceErrorRespondBlock)failure
{
    NSString *url = @"/?app=warehouse&act=login&username=%@&password=%@";
    url = [NSString stringWithFormat:url,username,password];
    return [self.client postHttpRequestWithURL:url
                                   parameters:nil
                                      success:^(id responseObject) {
                                          success(responseObject);
                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          failure([CAppServiceError error:error]);
                                      }];
}
//
- (AFHTTPRequestOperation *)collectLiang_request:(NSString *)user_id
                                    warehouse_id:(NSString *)warehouse_id
                                         isdelte:(NSInteger)isdelete
                                     success:(void (^)(NSDictionary *model))success
                                     failure:(AppServiceErrorRespondBlock)failure
{
    NSString *url = @"/?app=warehouse&act=collectWarehouse&user_id=%@&warehouse_id=%@&delete=%d";
    if([Common isEmptyString:user_id]){
        user_id = NullString;
    }
    if([Common isEmptyString:warehouse_id]){
        warehouse_id = NullString;
    }
    url = [NSString stringWithFormat:url,user_id,warehouse_id,isdelete];
    return [self.client postHttpRequestWithURL:url
                                    parameters:nil
                                       success:^(id responseObject) {
                                           success(responseObject);
                                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           failure([CAppServiceError error:error]);
                                       }];
}

- (AFHTTPRequestOperation *)liangDetail_request:(NSString *)warehouse_id
                                         success:(void (^)(NSDictionary *model))success
                                         failure:(AppServiceErrorRespondBlock)failure
{
    NSString *url = @"/?app=warehouse&act=warehouseDetail&warehouse_id=%@";
    if([Common isEmptyString:warehouse_id]){
        warehouse_id = NullString;
    }
    url = [NSString stringWithFormat:url,warehouse_id];
    return [self.client getHttpRequestWithURL:url
                                    parameters:nil
                                       success:^(id responseObject) {
                                           success(responseObject);
                                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           failure([CAppServiceError error:error]);
                                       }];
}
- (AFHTTPRequestOperation *)collectList_request:(NSString *)user_id
                                        success:(void (^)(NSDictionary *model))success
                                        failure:(AppServiceErrorRespondBlock)failure
{
    NSString *url = @"/?app=warehouse&act=collectWarehouseIndex&user_id=%@";
    if([Common isEmptyString:user_id]){
        user_id = NullString;
    }
    url = [NSString stringWithFormat:url,user_id];
    return [self.client getHttpRequestWithURL:url
                                   parameters:nil
                                      success:^(id responseObject) {
                                          success(responseObject);
                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          failure([CAppServiceError error:error]);
                                      }];
}
- (AFHTTPRequestOperation *)liangcangList_request:(NSInteger)pn
                                                p:(NSInteger)p
                                        success:(void (^)(NSDictionary *model))success
                                        failure:(AppServiceErrorRespondBlock)failure
{
    NSString *url = @"/?app=warehouse&act=index&pn=%d&p=%d";
    url = [NSString stringWithFormat:url,pn,p];
    return [self.client getHttpRequestWithURL:url
                                   parameters:nil
                                      success:^(id responseObject) {
                                          success(responseObject);
                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          failure([CAppServiceError error:error]);
                                      }];
}
- (AFHTTPRequestOperation *)pstDeveiceInfo_request:(void (^)(NSDictionary *model))success
                                          failure:(AppServiceErrorRespondBlock)failure
{
    NSString *url = @"/?app=warehouse&act=loginCallback&user_id=%@&mac=%@&devid=%@&ip=%@";
    url = [NSString stringWithFormat:url,NullString,NullString,NullString,NullString];
    return [self.client postHttpRequestWithURL:url
                                   parameters:nil
                                      success:^(id responseObject) {
                                          success(responseObject);
                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          failure([CAppServiceError error:error]);
                                      }];
}
@end

