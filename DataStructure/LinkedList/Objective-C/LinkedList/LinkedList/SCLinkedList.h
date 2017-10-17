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
 有 head，但是没有 tail
 
 0(head/first) -> 1 -> 2 -> 3 -> 4(last)
 
 */
@interface SCLinkedList<__covariant ObjectType> : NSObject

@property (strong, nonatomic) SCNode *head;     ///< 链表头
@property (assign, nonatomic, readonly) BOOL isEmpty;     ///< 是否为空
@property (strong, nonatomic, readonly) SCNode *first;    ///< 第一个节点
@property (strong, nonatomic, readonly) SCNode *last;     ///< 最后一个节点

@property (assign, nonatomic) NSUInteger count; ///< 节点个数


// 插入节点
- (void)appendNodeWithValue:(ObjectType)value;
- (void)insertNodeWithValue:(ObjectType)value atIndex:(NSInteger)index;

// 读取节点
- (SCNode *)nodeAtIndex:(NSInteger)index;
- (ObjectType)objectAtIndexedSubscript:(NSInteger)index;

// 移除操作
- (SCNode *)removeNode:(SCNode *)node;
- (SCNode *)removeNodeAtIndex:(NSUInteger)index;
- (SCNode *)removeLastNode;
- (SCNode *)removeAllNodes;

// 翻转链表
- (void)reverse;

// 高阶函数
- (SCLinkedList *)map:(ObjectType (^)(ObjectType value))block;
- (SCLinkedList *)filter:(BOOL (^)(ObjectType value))block;

@end

NS_ASSUME_NONNULL_END
