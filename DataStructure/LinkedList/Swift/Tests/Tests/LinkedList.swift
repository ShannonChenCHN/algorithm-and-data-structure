//
//  LinkedList.swift
//  Tests
//
//  Created by ShannonChen on 2017/10/21.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import Foundation


/// 链表节点
public class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    
    public init(value: T) {
        self.value = value
    }
}

/// 一个双向链表
public final class LinkedList<T> {
    

    public typealias Node = LinkedListNode<T>
    
    fileprivate var head: Node?
    
    public var isEmpty: Bool {
        return self.head == nil
    }
    
    public var first: Node? {
        return self.head
    }


    // 从 head 开始往后一步一步走，直到最后一个节点
    // 注：如果我们有一个记录 tail 节点的实例变量，那么这个 last 方法就可以直接返回 tail 节点。但是我们在这里没有这么做，所以这个 last 方法是一个比较耗时的操作，尤其是当链表特别长的时候
    public var last: Node? {
    
        if var node = self.head {
            while let next = node.next {
                node = next
            }
            return node
        } else {
            return nil
        }
    }
    
    // 从 head 开始往后一步一步走，每走一步 count 加 1
    // 注：这种方式的复杂度为 O(n)，如果我们给链表添加一个实例变量用来追踪 count 值的话，复杂度就变成了O(1)，但是这样我们就需要在每次添加或者移除一个节点的同时，去更新这个变量
    public var count: Int {
        
        if var node = self.head {
            var c = 1
            while let next = node.next {
                node = next
                c += 1
            }
            return c
        } else {
            return 0
        }
    }
    
    public init() { }
    
    // 找到最后一个节点，将新节点拼接在后面
    public func append(_ node: Node) {
        
        if let lastNode = self.last {
            node.previous = lastNode
            lastNode.next = node
        } else {
            self.head = node
        }
    }
    
    public func append(_ value: T) {
        
        let newNode = Node(value: value)
        
        self.append(newNode)
    }
    
    
    public func append(_ list: LinkedList) {
        var nodeToCopy = list.head
        while let node = nodeToCopy {
            self.append(node.value)
            nodeToCopy = node.next
        }
    }

    
    // 跟 nodeAt 方法类似，也是从 head 开始，一个一个往后找
    // 这个方法是用来查找位于 index 位置的节点以及位于 index 前面一位的节点
    private func nodesBeforeAndAfter(_ index: Int) -> (Node?, Node?) {
        assert(index >= 0)
        
        var i = index
        var next = self.head
        var prev: Node?
        
        while next != nil && i > 0 {
            i -= 1
            prev = next
            next = next!.next
        }
        
        assert(i == 0)  // 越界的处理
        
        return (prev, next)
    }

    // 从 head 开始往后走，走 index 步就可以得到结果了
    // 0(head) -> 1 -> 2 -> 3
    public func nodeAt(_ index: Int) -> Node? {
    
        if index >= 0 {
            var node = self.head
            var leftStep = index // 需要走多少步
            
            while node != nil {
            
                if leftStep == 0 { return node }  // 直到剩余 0 步时才返回
                leftStep -= 1                     // 剩余步数减 1
                node = node!.next                 // 往前走一步
            }
     
//            // 另一种方案
//            for _ in 0..<index {
//                if let tempNode = node, tempNode.next != nil {
//                    node = tempNode.next
//                } else {
//                    node = nil
//                }
//            }
//            return node

        }
        return nil
    }
    
    // 下标方法，内部直接调用的是 nodeAt 方法，同时做了越界抛异常处理
    public subscript(index: Int) -> T {
        let node = nodeAt(index)
        assert(node != nil)
        return node!.value
    }
    
    /*  示意图：
     *  head --> A --> B --> C --> D --> E --> F --> nil
     *          prev  next
     */
     // 这个方法和 nodesBeforeAndAfter 方法同样适用于单向链表，因为它们的实现不依赖于 prev 指针
    public func insert(_ node: Node, atIndex index: Int) {
        // 找到要插入的位置的前后节点，要注意为 nil 的情况
        let (prev, next) = self.nodesBeforeAndAfter(index)
        
        // 将新节点插入链表中，将其与前后节点链接起来
        node.previous = prev
        node.next = next
        prev?.next = node
        next?.previous = node
        
        // 当插入的位置是 0，那么就需要更新 head 了
        // 注：如果有 tail 并且插入的位置是最后的话，也需要更新 tail
        if prev == nil {
            self.head = node
        }
    }
    
    public func insert(_ value: T, atIndex index: Int) {
        let newNode = Node.init(value: value)
        self.insert(newNode, atIndex: index)
    }

    
    // 在链表中插入一个链表
    public func insert(_ list: LinkedList, atIndex index: Int) {
    
        if list.isEmpty { return }
        
        var (prev, next) = self.nodesBeforeAndAfter(index)
        
        // 从插入部分的 head 开始，一步一步往后连起来
        var nodeToCopy = list.head
        var newNode: Node?
        while let node = nodeToCopy {
            newNode = Node(value: node.value)
            newNode?.previous = prev
            if let previous = prev {
                previous.next = newNode
            } else {
                self.head = newNode
            }
            nodeToCopy = nodeToCopy?.next
            prev = newNode
        }
        
        // 将插入部分尾端连起来
        prev?.next = next
        next?.previous = prev
    }

    
    
    // 移除某个节点
    // 这个方法的操作最简单，因为它不需要从头开始一个一个去找这个节点
    @discardableResult public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            self.head = next
        }
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    @discardableResult public func removeLast() -> T {
        assert(!self.isEmpty)
        return self.remove(node: self.last!)
    }
    
    @discardableResult public func removeAt(_ index: Int) -> T {
        let node = self.nodeAt(index)
        assert(node != nil)
        return self.remove(node: node!)
    }

    
    // 移除所有的节点
    // 注：如果有 tail 的话，也要把 tail 置为 nil
    public func removeAll() {
        self.head = nil
    }
    
}



extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        var s = "["
        var node = self.head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil { s += ", " }
        }
        return s + "]"
    }
}

extension LinkedList {
    // 跟 Array 一样的 map 方法和 filter 方法
    // 下面两个方法其实还可以优化一下，不必要每次都调用耗时的 append 方法
    public func map<U>(transform: (T) -> U) -> LinkedList<U> {
        let result = LinkedList<U>()
        var node = self.head
        while node != nil {
            result.append(transform(node!.value))
            node = node!.next
        }
        return result
    }
    
    public func filter(predicate: (T) -> Bool) -> LinkedList<T> {
        let result = LinkedList<T>()
        var node = self.head
        while node != nil {
            if predicate(node!.value) {
                result.append(node!.value)
            }
            node = node!.next
        }
        return result
    }
}


    
    
        /*
        
      pre +--------+  pre +--------+  pre +--------+  pre +--------+
 nil <----|        |<-----|        |<-----|        |<-----|        |
          | node 0 |      | node 1 |      | node 2 |      | node 3 |
head ---->|        |----->|        |----->|        |----->|        |-----> nil
          +--------+ next +--------+ next +--------+ next +--------+ next 
          
         
     
     next +--------+  pre +--------+  pre +--------+  pre +--------+
nil <-----|        |<-----|        |<-----|        |<-----|        |
          | node 0 |      | node 1 |      | node 2 |      | node 3 |
          |        |----->|        |----->|        |----->|        |-----> nil
          +--------+  pre +--------+ next +--------+ next +--------+ next
                              ∧
                              |
                             head

     next +--------+ next +--------+  pre +--------+  pre +--------+
nil <-----|        |<-----|        |<-----|        |<-----|        |
          | node 0 |      | node 1 |      | node 2 |      | node 3 |
          |        |----->|        |----->|        |----->|        |
          +--------+  pre +--------+ pre  +--------+ next +--------+
                                               ∧
                                               |
                                              head

     next +--------+ next +--------+ next +--------+ next +--------+
nil <-----|        |<-----|        |<-----|        |<-----|        |<---- head
          | node 0 |      | node 1 |      | node 2 |      | node 3 |
          |        |----->|        |----->|        |----->|        |-----> nil
          +--------+  pre +--------+ pre  +--------+  pre +--------+ pre
     

        */
    
    // 反转链表
    // 如上图所示：一步一步往后走，依次将每个节点的 prev 指针和 next 指针反转过来，同时还要把 head 和 tail（如果有的话）调换一下
extension LinkedList {
    public func reverse() {
        
        var node = self.head
//        self.tail = node // If you had a tail pointer
        while let currentNode = node {
            
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            
            self.head = currentNode
        }
    }
    
    
}


extension LinkedList {
    convenience init(array: Array<T>) {
        self.init()
        
        for element in array {
            self.append(element)
        }
    }
}

extension LinkedList: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: T...) {
        self.init()
        
        for element in elements {
            self.append(element)
        }
    }
}



