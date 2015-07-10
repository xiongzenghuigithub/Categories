//
//  NSMutableArray+Stack.m
//  OSChina
//
//  Created by xiongzenghui on 15/1/1.
//  Copyright (c) 2015年 Zain. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)

- (void)my_pushObject:(id)obj {
    [self addObject:obj];
}

- (id)my_popObject {
    if ([self count] == 0) return nil;
    id obj = [self lastObject];
    [self removeLastObject];
    return obj;
}

@end
