//
//  Common.h
//  iAPHD
//
//  Created by 曹兴星 on 13-6-9.
//  Copyright (c) 2013年 曹兴星. All rights reserved.
//

@interface Common : NSObject
//生成自己绘制的图片
+ (UIImage *)drawImageSize:(CGSize)size
                     Color:(UIColor *)color;
+ (BOOL)isEmptyString:(NSString *)sourceStr;
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
@end
