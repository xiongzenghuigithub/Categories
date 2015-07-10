//
//  NSString+PathUtil.h
//  FMDBDemo
//
//  Created by sfpay on 15/5/14.
//  Copyright (c) 2015年 XiongZengHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (BOOL)isBlank;
- (BOOL)isValid;
- (NSString *)removeWhiteSpacesFromString;

- (NSUInteger)countNumberOfWords;
- (BOOL)containsString:(NSString *)subString;
- (BOOL)isBeginsWith:(NSString *)string;
- (BOOL)isEndssWith:(NSString *)string;

- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;
- (NSString *)addString:(NSString *)string;
- (NSString *)removeSubString:(NSString *)subString;
- (NSString *)CapitalizeFirst:(NSString *)source;

- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (BOOL)contains:(NSString *)string;
- (BOOL)isInThisarray:(NSArray*)array;

+ (NSString *)getAppVersion;
+ (NSString *)getAppName;
+ (NSString *)getBundleId;

+ (NSString *)getStringFromArray:(NSArray *)array Seperator:(NSString *)seperator;
- (NSArray *)getArrayWithSeperator:(NSString *)seperator;
- (NSData *)convertToData;
+ (NSString *)getStringFromData:(NSData *)data;
+ (NSString *)JSONStringWithDictionary : (NSDictionary *)dict;

- (NSString *)MD5;
+ (NSString *)convertToUTF8Entities:(NSString *)string;
+ (NSString *)encodeToBase64:(NSString *)string;
- (NSString *)encodeToBase64;
+ (NSString *)decodeBase64:(NSString *)string;
- (NSString *)decodeBase64;

- (NSString *)dateFromTimestamp;
- (NSString *)stringFromDate:(NSDate *)date Format:(NSString *)format;

- (NSString *)URLEncode;
- (NSString *)URLEncodeUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)URLDecode;
- (NSString *)URLDecodeUsingEncoding:(NSStringEncoding)encoding;

+ (NSString *)homePath;                     // 程序主目录，可见子目录(3个):Documents、Library、tmp【只读】
+ (NSString *)docPath;                      // 文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
+ (NSString *)libPrefPath;                  // 配置目录，配置文件存这里
+ (NSString *)libCachePath;                 // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;                      // 临时目录
+ (BOOL)createDirectory:(NSString *)path;   // 判断目录是否存在，不存在则创建

+ (NSString *)appendPathAtDocument:(NSString *)path;            // 在Document目录添加路径
+ (NSString *)appendPathAtCache:(NSString *)path;               // 在Cache目录添加路径
+ (NSString *)appendPathAtPreference:(NSString *)path;          // 在Preference目录添加路径
+ (NSString *)appendPathAtTemporary:(NSString *)path;           // 在Temporary目录添加路径
+ (NSString *)appendWithOriginPath:(NSString *)origin
                         ChildPath:(NSString *)child;           // /..../path1/path2

- (BOOL)isValidUrl;

@end
