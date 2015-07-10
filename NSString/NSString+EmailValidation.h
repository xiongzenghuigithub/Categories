//
//  NSString+EmailValidation.h
//  OSChina
//
//  Created by xiongzenghui on 15/1/1.
//  Copyright (c) 2015年 Zain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EmailValidation)

/**
 *  根据配置的邮箱，来纠正写错的邮箱服务器域名
 */
- (NSString *)stringByCorrectingEmailTypos;
//用法:
//NSString *badAddress = @"robert@gmial.com";
//NSString *goodAddress = [badAddress stringByCorrectingEmailTypos];

- (BOOL)isValidEmailAddress;

@end
