//
//  NSNotification+Commom.h
//  OSChina
//
//  Created by xiongzenghui on 15/1/1.
//  Copyright (c) 2015年 Zain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (Commom)

- (void) postNotificationOnMainThread:(NSNotification *) notification;
- (void) postNotificationOnMainThread:(NSNotification *) notification waitUntilDone:(BOOL) wait;

- (void) postNotificationOnMainThreadWithName:(NSString *) name object:(id) object;
- (void) postNotificationOnMainThreadWithName:(NSString *) name object:(id) object userInfo:(NSDictionary *) userInfo;
- (void) postNotificationOnMainThreadWithName:(NSString *) name object:(id) object userInfo:(NSDictionary *) userInfo waitUntilDone:(BOOL) wait;

@end
