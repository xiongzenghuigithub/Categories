//
//  UIDevice+Additions.h
//  FMDBDemo
//
//  Created by sfpay on 15/5/14.
//  Copyright (c) 2015年 XiongZengHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Additions)

+ (NSString *)getSystemVersion;
+ (NSString *)getSystemName;

+ (BOOL)system_version_equal_to:(NSString *)version;                                                //系统版本 = 某个版本
+ (BOOL)system_version_greater_than:(NSString *)version;                                            //系统版本 > 某个版本
+ (BOOL)system_version_greater_than_or_equal_to:(NSString *)version;                                //系统版本 >= 某个版本
+ (BOOL)system_version_less_than:(NSString *)version;                                               //系统版本 < 某个版本
+ (BOOL)system_version_less_than_or_equal_to:(NSString *)version;                                   //系统版本 < 某个版本

@end
