//
//  CAppService.h
//  
//
//  Created by LiuCarl on 15/1/8.
//  Copyright (c) 2015年 Carl Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAPIClient.h"
#import "AFNetworking.h"
typedef NS_ENUM(NSUInteger, ykAppServiceError) {
    eAppServiceErrorSuccess = 0, //成功
    eAppServiceErrorFailed = -1, //未知原因错误
    eAppServiceErrorTimeout = -1001, //响应超时
    eAppServiceErrorConnectFailed = -1004,
    eAppServiceErrorAuthentication_Failure = 1, //Token鉴权失败
    eAppServiceErrorInvalid_Category = 2, //未知的品类
    eAppServiceErrorInvalid_Brand = 3, //未知的品牌
    eAppServiceErrorInvalid_Parameter = 4, //参数错误
    eAppServiceErrorDevice_Already_Registered = 50, //该设备已注册
    eAppServiceErrorDevice_Validating_Failed = 51, //请求注册的设备是非法设备
    eAppServiceErrorDevice_Not_Found = 52, //设备不存在
    eAppServiceErrorCategory_Not_Found = 100, //品类不存在
    eAppServiceErrorBrand_Not_Found = 101, //品牌不存在
    eAppServiceErrorMobile_Not_Found = 150, //移动终端不存在
    eAppServiceErrorRemote_Index_Not_Found = 200, //遥控器索引（二进制码表）不存在
    eAppServiceErrorRemote_Not_Found = 201, //遥控器实例不存在
    eAppServiceErrorMultiple_Remote_Matched = 202, //匹配到多个遥控器
    eAppServiceErrorRemote_Bin_Download_Failure = 203, //二进制码表下载失败
};

@interface CAppServiceError : NSError
@property (nonatomic, assign) ykAppServiceError errorType;
@property (nonatomic, strong) NSString *errorMessage;

+ (instancetype)type:(ykAppServiceError)type message:(NSString *)message;
+ (instancetype)error:(NSError *)error;

@end

typedef void(^AppServiceErrorRespondBlock)(CAppServiceError *error);

@interface CAppService : NSObject

DEFINE_SINGLETON_FOR_HEADER(CAppService);
//- (AFHTTPRequestOperation *)get_device_instance_by_mobile_id:(NSString *)mobile_id
//                                                        pdsn:(NSString *)pdsn
//                                       success:(void (^)(NSDictionary *model))success
//                                       failure:(AppServiceErrorRespondBlock)failure
//                                      animated:(BOOL)animated;
@end
