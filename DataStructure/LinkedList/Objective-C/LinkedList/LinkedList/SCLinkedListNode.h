//
//  SCLinkedListNode.h
//  LinkedList
//
//  Created by ShannonChen on 2017/10/15.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 链表节点
 */
@interface SCLinkedListNode<__covariant ObjectType> : NSObject

@property (strong, nonatomic) ObjectType value;
@property (strong, nonatomic, nullable) SCLinkedListNode *next;
@property (weak, nonatomic, nullable) SCLinkedListNode *previous;

- (instancetype)initWithValue:(ObjectType)value;

@end

NS_ASSUME_NONNULL_END
