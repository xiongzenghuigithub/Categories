//
//  NSArray+Queue.m
//  OSChina
//
//  Created by xiongzenghui on 15/1/1.
//  Copyright (c) 2015年 Zain. All rights reserved.
//

#import "NSMutableArray+Queue.h"

@implementation NSMutableArray (Queue)

- (void)my_enque:(id)obj {
    [self addObject:obj];
}

- (id)my_deque {
    if ([self count] == 0) return nil;
    id firstObject = [self objectAtIndex:0];
    [self removeObjectAtIndex:0];
    return firstObject;
}

@end
