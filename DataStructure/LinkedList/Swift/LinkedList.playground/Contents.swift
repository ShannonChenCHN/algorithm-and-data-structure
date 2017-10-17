//: Playground - noun: a place where people can play

import UIKit

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
public class LinkedList<T> {
    public typealias Node = LinkedListNode<T>
    
    private var head: Node?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }


    // 从 head 开始往后一步一步走，直到最后一个节点
    // 注：如果我们有一个记录 tail 节点的实例变量，那么这个 last 方法就可以直接返回 tail 节点。但是我们在这里没有这么做，所以这个 last 方法是一个比较耗时的操作，尤其是当链表特别长的时候
    public var last: Node? {
    
        if var node = head {
            while let next = node.next {
                node = next
            }
            return node
        } else {
            return nil
        }
    }
    
    // 找到最后一个节点，将新节点拼接在后面
    public func append(_ value: T) {
    
        let newNode = Node(value: value)
        
        if let lastNode = self.last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }

    // 从 head 开始往后一步一步走，每走一步 count 加 1
    // 注：这种方式的复杂度为 O(n)，如果我们给链表添加一个实例变量用来追踪 count 值的话，复杂度就变成了O(1)，但是这样我们就需要在每次添加或者移除一个节点的同时，去更新这个变量
    public var count: Int {
    
        if var node = head {
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
    
    

    // 从 head 开始往后走，走 index 步就可以得到结果了
    // 0(head) -> 1 -> 2 -> 3
    public func nodeAt(_ index: Int) -> Node? {
    
        if index >= 0 {
            var node = head
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
    public func insert(_ value: T, atIndex index: Int) {
        // 找到要插入的位置的前后节点，要注意为 nil 的情况
        let (prev, next) = nodesBeforeAndAfter(index)
        
        // 将新节点插入链表中，将其与前后节点链接起来
        let newNode = Node(value: value)
        newNode.previous = prev
        newNode.next = next
        prev?.next = newNode
        next?.previous = newNode
        
        // 当插入的位置是 0，那么就需要更新 head 了
        // 注：如果有 tail 并且插入的位置是最后的话，也需要更新 tail
        if prev == nil {
            head = newNode
        }
    }
    
    // 跟 nodeAt 方法类似，也是从 head 开始，一个一个往后找
    // 这个方法是用来查找位于 index 位置的节点以及位于 index 前面一位的节点
    private func nodesBeforeAndAfter(_ index: Int) -> (Node?, Node?) {
        assert(index >= 0)
        
        var i = index
        var next = head
        var prev: Node?
        
        while next != nil && i > 0 {
            i -= 1
            prev = next
            next = next!.next
        }
        
        assert(i == 0)  // 越界的处理
        
        return (prev, next)
    }
    
    
    // 移除某个节点
    // 这个方法的操作最简单，因为它不需要从头开始一个一个去找这个节点
    public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    public func removeLast() -> T {
        assert(!isEmpty)
        return remove(node: last!)
    }
    
    public func removeAt(_ index: Int) -> T {
        let node = nodeAt(index)
        assert(node != nil)
        return remove(node: node!)
    }

    
    // 移除所有的节点
    // 注：如果有 tail 的话，也要把 tail 置为 nil
    public func removeAll() {
        head = nil
    }
    
    // 反转链表
    // 一步一步往后走，依次将每个节点的 prev 指针和 next 指针反转过来，同时还要把 head 和 tail（如果有的话）调换一下
    public func reverse() {
        var node = head
//        tail = node // If you had a tail pointer
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            head = currentNode
        }
    }
    
    
    // 跟 Array 一样的 map 方法和 filter 方法
    // 下面两个方法其实还可以优化一下，不必要每次都调用耗时的 append 方法
    public func map<U>(transform: (T) -> U) -> LinkedList<U> {
        let result = LinkedList<U>()
        var node = head
        while node != nil {
            result.append(transform(node!.value))
            node = node!.next
        }
        return result
    }
    
    public func filter(predicate: (T) -> Bool) -> LinkedList<T> {
        let result = LinkedList<T>()
        var node = head
        while node != nil {
            if predicate(node!.value) {
                result.append(node!.value)
            }
            node = node!.next
        }
        return result
    }
}


extension LinkedList: CustomStringConvertible {

    public var description: String {
        var s = "["
        var node = first
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil { s += ", " }
        }
        return s + "]"
    }
}


let list = LinkedList<String>()
list.isEmpty   // true
list.first     // nil
list.last


list.append("Hello")
list.isEmpty         // false
list.first!.value    // "Hello"
list.last!.value     // "Hello"

list.append("World")
list.first!.value    // "Hello"
list.last!.value     // "World"

list.first!.previous          // nil
list.first!.next!.value       // "World"
list.last!.previous!.value    // "Hello"
list.last!.next               // nil

list.nodeAt(0)!.value    // "Hello"
list.nodeAt(1)!.value    // "World"
list.nodeAt(2)           // nil

list[0]   // "Hello"
list[1]   // "World"
//list[2]   // crash!

list.insert("Swift", atIndex: 1)
list[0]     // "Hello"
list[1]     // "Swift"
list[2]     // "World"


list.remove(node: list.first!)   // "Hello"
list.count                     // 2
list[0]                        // "Swift"
list[1]                        // "World"


list.removeLast()              // "World"
list.count                     // 1
list[0]                        // "Swift"

list.removeAt(0)          // "Swift"
list.count                     // 0


list.append("Hello")
list.append("Swifty")
list.append("Universe")

let m = list.map { s in s.characters.count } // [5, 6, 8]
print(m)

let f = list.filter { s in s.characters.count > 5 } // [Swifty, Universe]
print(f)

list.append("World")
list.reverse()
