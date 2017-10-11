//: Playground - noun: a place where people can play

import UIKit


public class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    
    public init(value: T) {
        self.value = value
    }
}


public class LinkedList<T> {
    public typealias Node = LinkedListNode<T>
    
    private var head: Node?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    // Note: If we kept a tail pointer, last would simply do return tail. But we don't, so it has to step through the entire list from beginning to the end. It's an expensive operation, especially if the list is long.
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
    
    public func append(_ value: T) {
    
        let newNode = Node(value: value)
        
        if let lastNode = self.last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    // Note: One way to speed up count from O(n) to O(1) is to keep track of a variable that counts how many nodes are in the list. Whenever you add or remove a node, you also update this variable.
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
    
    
    //  it starts at head and then keeps following the node.next pointers to step through the list. We're done when we've seen index nodes, i.e. when the counter has reached 0.
    public func nodeAt(_ index: Int) -> Node? {
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }
        return nil
    }
    
    public subscript(index: Int) -> T {
        let node = nodeAt(index)
        assert(node != nil)
        return node!.value
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

