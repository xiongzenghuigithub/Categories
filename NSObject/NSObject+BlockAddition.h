//
//  NSObject+BlockAddition.h
//  CodeCollection
//
//  Created by xiongzenghui on 14/12/25.
//  Copyright (c) 2014年 zainxiong. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^VoidBlock)(void);
static VoidBlock block;


@interface NSObject (BlockAddition)

- (void) performCallbackBlock:(void (^)(void)) complet;
- (void) performCallbackBlock:(void (^)(void)) complet OnQueue:(dispatch_queue_t)queue;
- (void) performCallbackBlock:(void (^)(void)) complet afterDelay:(NSTimeInterval) delay;

@end
