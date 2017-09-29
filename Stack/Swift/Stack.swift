//
//  Stack.swift
//  Stack-Swift
//
//  Created by ShannonChen on 2017/9/29.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import Foundation


/*
 Stack
 
 A stack is like an array but with limited functionality. You can only push
 to add a new element to the top of the stack, pop to remove the element from
 the top, and peek at the top element without popping it off.
 
 A stack gives you a LIFO or last-in first-out order. The element you pushed
 last is the first one to come off with the next pop.
 
 Push and pop are O(1) operations.
 */

struct Stack <T> {
    
    // MARK: Properties
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var top: T? {
        return array.last
    }
    
    public var count: Int {
        return array.count
    }
    
    // MARK: Methods
    public mutating func push(_ newElement: T) {
        array.append(newElement)
    }
    
    // pop 最后一个元素，有可能为空
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
}

// 实现 Sequence 协议，以支持 for - in 循环遍历
extension Stack: Sequence {
    
    public func makeIterator() -> AnyIterator<T> {
        var curr = self
        
        return AnyIterator {
            return curr.pop()
        }
    }
}
