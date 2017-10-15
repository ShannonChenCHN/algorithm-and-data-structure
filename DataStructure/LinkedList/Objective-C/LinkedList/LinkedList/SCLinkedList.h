//
//  SCLinkedList.h
//  LinkedList
//
//  Created by ShannonChen on 2017/10/15.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCLinkedListNode.h"

NS_ASSUME_NONNULL_BEGIN

typedef SCLinkedListNode SCNode;

/**
 一个双向链表
 */
@interface SCLinkedList<__covariant ObjectType> : NSObject

@property (strong, nonatomic) SCNode *head;
@property (assign, nonatomic) BOOL isEmpty;
@property (strong, nonatomic) SCNode *first;
@property (strong, nonatomic) SCNode *last;

@property (assign, nonatomic) NSUInteger count;

- (void)appendNodeWithValue:(ObjectType)value;
- (void)insertValueAtIndex:(ObjectType)value;

- (SCNode *)nodeAtIndex:(NSInteger)index;
- (ObjectType)objectAtIndexedSubscript:(NSInteger)index;

// 移除操作
- (SCNode *)removeNode:(SCNode *)node;
- (SCNode *)removeNodeAtIndex:(NSUInteger)index;
- (SCNode *)removeLastNode;
- (SCNode *)removeAllNodes;

/// 翻转链表
- (void)reverse;

// 参考 https://github.com/BlocksKit/BlocksKit/blob/master/BlocksKit/Core/NSArray%2BBlocksKit.m#L58
- (SCLinkedList *)map:(ObjectType (^)(ObjectType value))block;
- (SCLinkedList *)filter:(BOOL (^)(ObjectType value))block;

@end

NS_ASSUME_NONNULL_END
