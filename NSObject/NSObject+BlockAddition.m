//
//  NSObject+BlockAddition.m
//  CodeCollection
//
//  Created by xiongzenghui on 14/12/25.
//  Copyright (c) 2014年 zainxiong. All rights reserved.
//

#import "NSObject+BlockAddition.h"
#import <objc/runtime.h>

@implementation NSObject (BlockAddition)

- (void)performCallbackBlock:(void (^)(void))complet {
    block = complet;
    [self performSelector:@selector(callBlock)];
}

- (void) performCallbackBlock:(void (^)(void)) complet OnQueue:(dispatch_queue_t)queue {
    block = complet;
    __weak __typeof(self) weakSelf = self;
    dispatch_async(queue?queue:dispatch_get_main_queue(), ^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf performSelector:@selector(callBlock)];
    });
}

- (void) performCallbackBlock:(void (^)(void)) complet afterDelay:(NSTimeInterval) delay {
    block = complet;
    [self performSelector:@selector(callBlock) withObject:nil afterDelay:delay];
}

- (void)callBlock {
    block();
    block = nil;
}

@end
