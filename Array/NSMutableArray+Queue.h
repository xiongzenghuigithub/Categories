//
//  NSArray+Queue.h
//  OSChina
//
//  Created by xiongzenghui on 15/1/1.
//  Copyright (c) 2015年 Zain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Queue)

/**
 *  入队列尾部
 */
- (void) my_enque:(id) obj;

/**
 *  出队列头部
 */
- (id) my_deque;

@end
