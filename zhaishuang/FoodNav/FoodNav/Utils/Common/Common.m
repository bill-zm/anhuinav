//
//  Common.m
//  iAPHD
//
//  Created by 曹兴星 on 13-6-9.
//  Copyright (c) 2013年 曹兴星. All rights reserved.
//

#import "Common.h"
@implementation Common
//生成自己绘制的图片
+ (UIImage *)drawImageSize:(CGSize)size
                     Color:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(Frame(0, 0, size.width, size.height));
    UIImage *resImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImg;
}
//根据16进制显示颜色
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString {
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    if (![Common isEmptyString:inColorString]) {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha: 1.0];
    return result;
}
//字符串为空检查
+ (BOOL)isEmptyString:(NSString *)sourceStr {
    if ((NSNull *)sourceStr == [NSNull null]) {
        return YES;
    }
    if (sourceStr == NULL) {
        return YES;
    }
    if (sourceStr == nil) {
        return YES;
    }
    if ([sourceStr isEqualToString:@""]) {
        return YES;
    }
    if (sourceStr.length == 0) {
        return YES;
    }
    if ([sourceStr isEqualToString:@"null"]) {
        return YES;
    }
    if ([sourceStr isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}
//去除UITableView多余分割线
+ (void)removeExtraCellLines:(UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = ClearColor;
    [tableView setTableFooterView:view];
}
@end