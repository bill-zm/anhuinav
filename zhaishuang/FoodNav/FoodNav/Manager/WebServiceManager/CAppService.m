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
    switch (error.code) {
        case -1001:
            return [[self alloc] initWithType:eAppServiceErrorTimeout andMessage:NSLocalizedString(@"网络错误",@"")];
        case -1004:
            return [[self alloc] initWithType:eAppServiceErrorConnectFailed andMessage:NSLocalizedString(@"网络错误",@"")];
        default:
            return [[self alloc] initWithType:eAppServiceErrorFailed andMessage:NSLocalizedString(@"网络错误",@"")];
    }
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
@end
