//
//  UIDevice+Additions.m
//  FMDBDemo
//
//  Created by sfpay on 15/5/14.
//  Copyright (c) 2015年 XiongZengHui. All rights reserved.
//

#import "UIDevice+Additions.h"

@implementation UIDevice (Additions)

+ (NSString *)getSystemVersion {
    return [[self currentDevice] systemVersion];
}

+ (NSString *)getSystemName {
    return [[self currentDevice] systemName];
}

+ (BOOL)system_version_equal_to:(NSString *)version {
    return ([[[self currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedSame);
}

+ (BOOL)system_version_greater_than:(NSString *)version {
    return ([[[self currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedDescending);
}

+ (BOOL)system_version_greater_than_or_equal_to:(NSString *)version {
    return ([[[self currentDevice] systemVersion] compare:version options:NSNumericSearch] != NSOrderedAscending);
}

+ (BOOL)system_version_less_than:(NSString *)version {
    return ([[[self currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending);
}

+ (BOOL)system_version_less_than_or_equal_to:(NSString *)version {
    return ([[[self currentDevice] systemVersion] compare:version options:NSNumericSearch] != NSOrderedDescending);
}

@end
