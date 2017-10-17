//
//  SCLinkedList.m
//  LinkedList
//
//  Created by ShannonChen on 2017/10/15.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCLinkedList.h"

@implementation SCLinkedList

- (BOOL)isEmpty {
    return self.head == nil;
}

- (SCNode *)first {
    return self.head;
}

// 从 head 开始往后一步一步走，直到最后一个节点
// 注：如果我们有一个记录 tail 节点的实例变量，那么这个 last 方法就可以直接返回 tail 节点。但是我们在这里没有这么做，所以这个 last 方法是一个比较耗时的操作，尤其是当链表特别长的时候
- (SCNode *)last {
    
    // 如果表头为空，直接返回 nil
    if (self.head == nil) {
        return nil;
    }
    
    
    // 0(head) -> 1 -> 2 -> 3 -> 4(last)
    
    SCNode *currentNode = self.head;
    while (currentNode.next != nil) { // 下一个节点不是空的就去下一个
        currentNode = currentNode.next;
    }
    
    return currentNode;
}



// 找到最后一个节点，将新节点拼接在后面
- (void)appendNodeWithValue:(id)value {

    // 0(head) -> 1 -> 2 -> 3(last)
    // 0(head) -> 1 -> 2 -> 3 -> 4(last)
    
    SCNode *newNode = [[SCNode alloc] initWithValue:value];
    
    if (self.last) {
        newNode.previous = self.last;
        self.last.next = newNode;
    } else {
        self.head = newNode;
    }
}


// 从 head 开始往后一步一步走，每走一步 count 加 1
// 注：这种方式的复杂度为 O(n)，如果我们给链表添加一个实例变量用来追踪 count 值的话，复杂度就变成了O(1)，但是这样我们就需要在每次添加或者移除一个节点的同时，去更新这个变量
- (NSUInteger)count {

    // 0(head) -> 1 -> 2 -> 3 -> 4(last)
    //
    
    if (self.head == nil) {
        return 0;
    }

    SCNode *currentNode = self.head;
    
    NSInteger count = 1;
    while (currentNode.next != nil) { // 下一个节点不是空的，就往下去一个
        count++;
        currentNode = currentNode.next;
    }
    
    return count;
}


// 从 head 开始往后走，走 index 步就可以得到结果了
// 0(head) -> 1 -> 2 -> 3
- (SCNode *)nodeAtIndex:(NSInteger)index {
    NSAssert(index >= 0, @"Error: Out of bounds");

    // 链表为空就直接返回 nil
    if (self.head == nil) {
        return nil;
    }
    
    
    SCNode *currentNode = self.head; // 从 head 往后走
    
    NSInteger step = index;
    
    // 剩余步数不为 0
    while (step > 0) {
        
        // 往后走一步
        step--;
        currentNode = currentNode.next;
        
        // 出界了就返回 nil
        if (currentNode == nil) {
            return nil;
        }
    }
    
    return currentNode;
}


// http://www.cnblogs.com/zenny-chen/p/3593660.html
// 下标方法，内部直接调用的是 nodeAt 方法，同时做了越界抛异常处理
- (id)objectAtIndexedSubscript:(NSInteger)index {
    
    SCNode *node = [self nodeAtIndex:index];
    NSAssert(node != nil, nil);
    
    return node.value;
}


// 跟 nodeAt 方法类似，也是从 head 开始，一个一个往后找
// 这个方法是用来查找位于 index 位置的节点以及位于 index 前面一位的节点
- (void)findNodesBeforeAndAtIndex:(NSInteger)index completion:(void(^)(SCNode *prev, SCNode *this))completion {
    NSAssert(index >= 0, @"Error: out of bounds");
    
    // 0(head) -> 1 -> 2 -> 3
    
    NSInteger step = index;
    SCNode *currentNode = self.head;
    SCNode *prevOfCurrentNode = nil;
    
    while (step > 0 && currentNode.next) {
        step--;
        prevOfCurrentNode = currentNode;
        currentNode = currentNode.next;
    }
    
    NSAssert(step == 0, @"Error: Out of bounds");
    
    // 返回结果
    if (completion) {
        completion(prevOfCurrentNode, currentNode);
    }


}


/*  示意图：
 *  head --> A --> B --> C --> D --> E --> F --> nil
 *          prev  next
 */
// 这个方法和 nodesBeforeAndAtIndex 方法同样适用于单向链表，因为它们的实现不依赖于 prev 指针
- (void)insertNodeWithValue:(id)value atIndex:(NSInteger)index {

    [self findNodesBeforeAndAtIndex:index completion:^(SCNode *prev, SCNode *next) {
        
        
        // 将新节点插入链表中，将其与前后节点链接起来
        SCNode *newNode = [[SCNode alloc] initWithValue:value];
        newNode.previous = prev;
        newNode.next = next;
        prev.next = newNode;
        next.previous = newNode;
        
        
        // 当插入的位置是 0，那么就需要更新 head 了
        // 注：如果有 tail 并且插入的位置是最后的话，也需要更新 tail
        if (prev == nil) {
            self.head = prev;
        }
        
    }];
    
}

// 参考 https://github.com/BlocksKit/BlocksKit/blob/master/BlocksKit/Core/NSArray%2BBlocksKit.m#L58

- (SCLinkedList *)map:(id  _Nonnull (^)(id _Nonnull))block {
    
    // 1. 新建一个链表
    SCLinkedList *result = [[SCLinkedList alloc] init];
    
    // 2. 从 head 开始往后一个一个转换
    SCNode *currentNode = self.head;
    while (currentNode != nil) {
    
        SCNode *transformedNode = block(currentNode.value); // 转换节点
        [result appendNodeWithValue:transformedNode]; // 拼接在新建的链表的最后面
        
        currentNode = currentNode.next; // 移到下一个节点
    }
    
    return result;
}

@end
