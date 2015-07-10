//
//  NSString+EmailValidation.m
//  OSChina
//
//  Created by xiongzenghui on 15/1/1.
//  Copyright (c) 2015年 Zain. All rights reserved.
//

#import "NSString+EmailValidation.h"
#import "NSString+BFKit.h"

static const NSString *gmailDomain        = @"gmail.com";
static const NSString *googleMailDomain   = @"googlemail.com";
static const NSString *hotmailDomain      = @"hotmail.com";
static const NSString *yahooDomain        = @"yahoo.com";
static const NSString *yahooMailDomain    = @"ymail.com";

@implementation NSString (EmailValidation)

- (NSString *)stringByCorrectingEmailTypos {
    
    if (![self isValidEmailAddress]) {
        NSLog(@"%@ is not a valid email address.", self);
        return self;
    }
    
    // Start with a lower-cased version of the original string.
    __block NSString *correctedEmailAddress = [self lowercaseString];
    
    // First replace a ".con" suffix with ".com".
    if ([correctedEmailAddress hasSuffix:@".con"]) {
        NSRange range = NSMakeRange(correctedEmailAddress.length - 4, 4);
        correctedEmailAddress = [correctedEmailAddress stringByReplacingOccurrencesOfString:@".con"
                                                                                 withString:@".com"
                                                                                    options:NSBackwardsSearch|NSAnchoredSearch
                                                                                      range:range];
    }
    
    // Now iterate through the bad domain names to find common typos.
    // Feel free to add to the dictionary below.
    // I got the original list from http://getintheinbox.com/2013/02/25/typo-traps/
    NSDictionary *typos = @{@"gogglemail.com":  googleMailDomain,
                            @"googlmail.com":   googleMailDomain,
                            @"goglemail.com":   googleMailDomain,
                            @"hotmial.com":     hotmailDomain,
                            @"hotmal.com":      hotmailDomain,
                            @"hoitmail.com":    hotmailDomain,
                            @"homail.com":      hotmailDomain,
                            @"hotnail.com":     hotmailDomain,
                            @"hotrmail.com":    hotmailDomain,
                            @"hotmil.com":      hotmailDomain,
                            @"hotmaill.com":    hotmailDomain,
                            @"yaho.com":        yahooDomain,
                            @"uahoo.com":       yahooDomain,
                            @"ayhoo.com":       yahooDomain,
                            @"ymial.com":       yahooMailDomain,
                            @"ymaill.com":      yahooMailDomain,
                            @"gmal.com":        gmailDomain,
                            @"gnail.com":       gmailDomain,
                            @"gmaill.com":      gmailDomain,
                            @"gmial.com":       gmailDomain,
                            };
    
    [typos enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        NSString *domainIncludingAtSymbol = [NSString stringWithFormat:@"@%@", key];
        if ([correctedEmailAddress hasSuffix:domainIncludingAtSymbol]) {
            // Found a bad domain.
            correctedEmailAddress = [correctedEmailAddress stringByReplacingOccurrencesOfString:key withString:object];
            *stop = YES;
        }
    }];
    
    return correctedEmailAddress;
}

- (BOOL)isValidEmailAddress {
    return [self isEmail];
}

@end
