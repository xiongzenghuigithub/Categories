//
//  NSString+PathUtil.m
//  FMDBDemo
//
//  Created by sfpay on 15/5/14.
//  Copyright (c) 2015年 XiongZengHui. All rights reserved.
//

#import "NSString+Additions.h"
#import "ORMapping.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Additions)

#pragma mark - 校验

-(BOOL)isBlank
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""]) ? YES : NO;
}
//Checking if String is empty or nil
-(BOOL)isValid
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"]) ? NO :YES;
}

// remove white spaces from String
- (NSString *)removeWhiteSpacesFromString
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

// Counts number of Words in String
- (NSUInteger)countNumberOfWords
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet: whiteSpace  intoString: nil]) {
        count++;
    }
    
    return count;
}

// If string contains substring
- (BOOL)containsString:(NSString *)subString
{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

// If my string starts with given string
- (BOOL)isBeginsWith:(NSString *)string
{
    return ([self hasPrefix:string]) ? YES : NO;
}

// If my string ends with given string
- (BOOL)isEndssWith:(NSString *)string
{
    return ([self hasSuffix:string]) ? YES : NO;
}

#pragma mark - 替换

// Replace particular characters in my string with new character
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar
{
    return  [self stringByReplacingOccurrencesOfString:olderChar withString:newerChar];
}

// Get Substring from particular location to given lenght
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end
{
    NSRange r;
    r.location = begin;
    r.length = end - begin;
    return [self substringWithRange:r];
}

// Add substring to main String
- (NSString *)addString:(NSString *)string
{
    if(!string || string.length == 0)
        return self;
    
    return [self stringByAppendingString:string];
}

// Remove particular sub string from main string
-(NSString *)removeSubString:(NSString *)subString
{
    if ([self containsString:subString])
    {
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}

//首字母大写
-(NSString *)CapitalizeFirst:(NSString *)source {
    
    if ([source length] == 0) {
        return source;
    }
    return [source stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                           withString:[[source substringWithRange:NSMakeRange(0, 1)] capitalizedString]];
}

#pragma mark - 统计

-(BOOL)contains:(NSString *)string {
    NSRange range = [self rangeOfString:string];
    return (range.location != NSNotFound);
}

// If my string contains ony letters
- (BOOL)containsOnlyLetters
{
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

// If my string contains only numbers
- (BOOL)containsOnlyNumbers
{
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

// If my string contains letters and numbers
- (BOOL)containsOnlyNumbersAndLetters
{
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

// If my string is available in particular array
- (BOOL)isInThisarray:(NSArray*)array
{
    for(NSString *string in array) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 加密解密

- (NSString *)MD5
{
    if(self == nil || [self length] == 0)
        return nil;
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

+ (NSString *)encodeToBase64:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)encodeToBase64
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

+ (NSString *)decodeBase64:(NSString *)string
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)decodeBase64
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - URL Encode/Decode

- (NSString *)URLEncode {
    return [self URLEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)URLEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

- (NSString *)URLDecode {
    return [self URLDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)URLDecodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (__bridge CFStringRef)self,
                                                                                                 CFSTR(""),
                                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

#pragma mark - 日期转换

/* 字符串转换： 2008年12月21日12时39分 */
- (NSString *)dateFromTimestamp
{
    NSString *year = [self substringToIndex:4];
    NSString *month = [[self substringFromIndex:5] substringToIndex:2];
    NSString *day = [[self substringFromIndex:8] substringToIndex:2];
    NSString *hours = [[self substringFromIndex:11] substringToIndex:2];
    NSString *minutes = [[self substringFromIndex:14] substringToIndex:2];
    
    return [NSString stringWithFormat:@"%@/%@/%@ %@:%@", day, month, year, hours, minutes];
}

- (NSString *)stringFromDate:(NSDate *)date Format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    
    if ([format isValid]) {
        [formatter setDateFormat:format];
    } else {
        [formatter setDateFormat:@"M/d/yyyy h:m a"];
    }
    
    return [formatter stringFromDate:date];
}

#pragma mark - 系统目录路径

+ (NSString *)homePath {
    static NSString * path = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        path = NSHomeDirectory();
    });
    return path;
}

+ (NSString *)docPath {
    static NSString * path = nil;
    static dispatch_once_t onceToken;
    __block NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    dispatch_once(&onceToken, ^{
        path = [paths objectAtIndex:0];
    });
    return path;
}

+ (NSString *)libPrefPath {
    static NSString * path = nil;
    static dispatch_once_t onceToken;
    __block NSArray * paths = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES);
    dispatch_once(&onceToken, ^{
        path = [paths objectAtIndex:0];
    });
    return path;
}

+ (NSString *)libCachePath {
    static NSString * path = nil;
    static dispatch_once_t onceToken;
    __block NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    dispatch_once(&onceToken, ^{
        path = [paths objectAtIndex:0];
    });
    return path;
}

+ (NSString *)tmpPath {
    static NSString * path = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        path = NSTemporaryDirectory();
    });
    return path;
}

+ (BOOL)createDirectory:(NSString *)path {
    
    //已经存在目录
    BOOL isDir;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    if (isDir && isExist) {
        return YES;
    }
    
    //存在，但不是目录
    NSError *error = nil;
    if (isExist && !isDir) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        ErrorLog(error);
    }
    
    //新建目录
    error = nil;
    BOOL isCreate = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                              withIntermediateDirectories:YES
                                                               attributes:nil error:&error];
    ErrorLog(error);
    
    return isCreate;
}

#pragma mark - 拼接路径

+ (NSString *)appendPathAtDocument:(NSString *)path {
    NSString *desPath = [[self docPath] stringByAppendingPathComponent:path];
    return desPath;
}

+ (NSString *)appendPathAtCache:(NSString *)path {
    NSString *desPath = [[self libCachePath] stringByAppendingPathComponent:path];
    return desPath;
}

+ (NSString *)appendPathAtPreference:(NSString *)path {
    NSString *desPath = [[self libPrefPath] stringByAppendingPathComponent:path];
    return desPath;
}

+ (NSString *)appendPathAtTemporary:(NSString *)path {
    NSString *desPath = [[self tmpPath] stringByAppendingPathComponent:path];
    return desPath;
}

+ (NSString *)appendWithOriginPath:(NSString *)origin
                         ChildPath:(NSString *)child
{
    NSString *desPath = [origin stringByAppendingPathComponent:child];
    return desPath;
}

#pragma mark - 获取App内容

+ (NSString *)getAppVersion
{
    __block NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    static NSString *version = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [info objectForKey:@"CFBundleVersion"];
    });
    return version;
}

+ (NSString *)getAppName
{
    __block NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    static NSString *name = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        name = [info objectForKey:@"CFBundleDisplayName"];
    });
    return name;
}

+ (NSString *)getBundleId
{
    __block NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    static NSString *boundleId = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        boundleId = [info objectForKey:@"CFBundleVersion"];
    });
    return boundleId;
}

#pragma mark - 数据类型转换

+ (NSString *)convertToUTF8Entities:(NSString *)string
{
    NSString *isoEncodedString = [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[
                                                                  [string stringByReplacingOccurrencesOfString:@"%27" withString:@"'"]
                                                                  stringByReplacingOccurrencesOfString:[@"%e2%80%99" capitalizedString] withString:@"’"]
                                                                 stringByReplacingOccurrencesOfString:[@"%2d" capitalizedString] withString:@"-"]
                                                                stringByReplacingOccurrencesOfString:[@"%c2%ab" capitalizedString] withString:@"«"]
                                                               stringByReplacingOccurrencesOfString:[@"%c2%bb" capitalizedString] withString:@"»"]
                                                              stringByReplacingOccurrencesOfString:[@"%c3%80" capitalizedString] withString:@"À"]
                                                             stringByReplacingOccurrencesOfString:[@"%c3%82" capitalizedString] withString:@"Â"]
                                                            stringByReplacingOccurrencesOfString:[@"%c3%84" capitalizedString] withString:@"Ä"]
                                                           stringByReplacingOccurrencesOfString:[@"%c3%86" capitalizedString] withString:@"Æ"]
                                                          stringByReplacingOccurrencesOfString:[@"%c3%87" capitalizedString] withString:@"Ç"]
                                                         stringByReplacingOccurrencesOfString:[@"%c3%88" capitalizedString] withString:@"È"]
                                                        stringByReplacingOccurrencesOfString:[@"%c3%89" capitalizedString] withString:@"É"]
                                                       stringByReplacingOccurrencesOfString:[@"%c3%8a" capitalizedString] withString:@"Ê"]
                                                      stringByReplacingOccurrencesOfString:[@"%c3%8b" capitalizedString] withString:@"Ë"]
                                                     stringByReplacingOccurrencesOfString:[@"%c3%8f" capitalizedString] withString:@"Ï"]
                                                    stringByReplacingOccurrencesOfString:[@"%c3%91" capitalizedString] withString:@"Ñ"]
                                                   stringByReplacingOccurrencesOfString:[@"%c3%94" capitalizedString] withString:@"Ô"]
                                                  stringByReplacingOccurrencesOfString:[@"%c3%96" capitalizedString] withString:@"Ö"]
                                                 stringByReplacingOccurrencesOfString:[@"%c3%9b" capitalizedString] withString:@"Û"]
                                                stringByReplacingOccurrencesOfString:[@"%c3%9c" capitalizedString] withString:@"Ü"]
                                               stringByReplacingOccurrencesOfString:[@"%c3%a0" capitalizedString] withString:@"à"]
                                              stringByReplacingOccurrencesOfString:[@"%c3%a2" capitalizedString] withString:@"â"]
                                             stringByReplacingOccurrencesOfString:[@"%c3%a4" capitalizedString] withString:@"ä"]
                                            stringByReplacingOccurrencesOfString:[@"%c3%a6" capitalizedString] withString:@"æ"]
                                           stringByReplacingOccurrencesOfString:[@"%c3%a7" capitalizedString] withString:@"ç"]
                                          stringByReplacingOccurrencesOfString:[@"%c3%a8" capitalizedString] withString:@"è"]
                                         stringByReplacingOccurrencesOfString:[@"%c3%a9" capitalizedString] withString:@"é"]
                                        stringByReplacingOccurrencesOfString:[@"%c3%af" capitalizedString] withString:@"ï"]
                                       stringByReplacingOccurrencesOfString:[@"%c3%b4" capitalizedString] withString:@"ô"]
                                      stringByReplacingOccurrencesOfString:[@"%c3%b6" capitalizedString] withString:@"ö"]
                                     stringByReplacingOccurrencesOfString:[@"%c3%bb" capitalizedString] withString:@"û"]
                                    stringByReplacingOccurrencesOfString:[@"%c3%bc" capitalizedString] withString:@"ü"]
                                   stringByReplacingOccurrencesOfString:[@"%c3%bf" capitalizedString] withString:@"ÿ"]
                                  stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
    
    return isoEncodedString;
}


+ (NSString *)JSONStringWithDictionary : (NSDictionary *)dict
{
    /** 转换参数格式 */
    NSData * tempData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString * tempString = [[NSString alloc] initWithData:tempData encoding:NSUTF8StringEncoding];
    return tempString ? tempString : @"";
}

// Get String from array
+ (NSString *)getStringFromArray:(NSArray *)array Seperator:(NSString *)seperator
{
    if (![seperator isValid]) {
        return [array componentsJoinedByString:@" "];
    } else {
        return [array componentsJoinedByString:seperator];
    }
}

// Convert Array from my String
- (NSArray *)getArrayWithSeperator:(NSString *)seperator
{
    if (seperator == nil || [seperator isEqualToString:@" "]) {
        return [self componentsSeparatedByString:@" "];
    }else {
        return [self componentsSeparatedByString:seperator];
    }
}

- (NSData *)convertToData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)getStringFromData:(NSData *)data
{
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
    
}

#pragma mark - 正则

- (BOOL)isValidUrl
{
    NSString *regex =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}

@end
