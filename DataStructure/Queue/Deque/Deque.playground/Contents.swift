//: Playground - noun: a place where people can play

import UIKit


/*
 双端队列（Queue / Double-ended queue）
 
 普通的队列只允许从后面添加新元素，从前面移除元素，而双端队列还能从前面添加新元素，从后面移除元素。
 
 https://baike.baidu.com/item/双端队列/2968804?fr=aladdin
 https://en.wikipedia.org/wiki/Double-ended_queue
 
 */

/*
 
 Swift 相关知识点：
 1. mutating
 对于值类型（比如 struct 和 enum），如果想要在实例方法中修改属性值，就需要要在该方法前添加 mutating 关键字
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html
 http://www.jianshu.com/p/14cc9d30770a
 
 2. 值类型和引用类型的对比
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82
 
 3. access control
  http://www.jianshu.com/p/a5c2b91b23e7
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AccessControl.html#//apple_ref/doc/uid/TP40014097-CH41-ID3
 https://medium.com/@abhimuralidharan/swift-3-0-1-access-control-9e71d641a56c
 https://www.jessesquires.com/blog/thoughts-on-swift-access-control/
 */


/// 基本的双端队列
public struct Deque<T> {
    private var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func enqueueFront(_ element: T) {
        array.insert(element, at: 0)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public mutating func dequeueBack() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeLast()
        }
    }
    
    public func peekFront() -> T? {
        return array.first
    }
    
    public func peekBack() -> T? {
        return array.last
    }
}

var deque = Deque<Int>()
deque.enqueue(1)
deque.enqueue(2)
deque.enqueue(3)
deque.enqueue(4)

deque.dequeue()       // 1
deque.dequeueBack()   // 4

deque.enqueueFront(5)
deque.dequeue()       // 5






// [nil,   nil,    nil,    56,    23,    45,    82,    91,    x,     x]
//                        head
/// 更高效的双端队列
struct EfficientDeque<T> {
    private var array: [T?]  // 这里使用 T? 而不是 T，因为我们需要存储一些占位值
    private var head: Int
    private var capacity: Int
    private var originalCapacity: Int
    
    // 初始化时创建一个有指定大小的数组，每个元素的初始值为 nil
    // [nil,   nil,    nil,    nil,    nil]  capacity = 5
    //                                       head = 5
    public init(_ capacity: Int = 10) {
        self.capacity = max(capacity, 1)
        originalCapacity = self.capacity
        array = [T?](repeatElement(nil, count: capacity))
        head = capacity
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var count: Int {
        return array.count - head
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    // [nil,   nil,    nil,    nil,    nil]
    //                                       head = 5
    // [nil,   nil,    nil,    nil,    5]
    //                                head = 4
    // ...
    // [41,   76,    12,    45,    5]
    //  head = 0
    // [nil,   nil,   nil,  nil,  ...  nil, 41,   76,    12,    45,    5]
    //                                     head = 10
    public mutating func enqueueFront(_ element: T) {
       
        // 如果前面已经没有更多可用空间了，就再在数组的最前面插入新的占位数组
        if head == 0 {
            capacity *= 2  // 每次空间不够时，插入的占位数组大小都为上一次的 2 倍，这样的话，当数组越来越大， resize 的概率就越来越小了。其实 swift 标准库中的数组也是这么处理的。
            let emptySpace = [T?](repeatElement(nil, count: capacity))
            array.insert(contentsOf: emptySpace, at: 0)
            head = capacity
        }
        
        
        // head 往前移一位
        head -= 1
        
        // 保存新数值
        array[head] = element
    }
    
    // [nil,   nil,    nil,    23,    5]
    //                        head = 3
    // ...
    // [nil, nil,  nil, nil,   ...   nil, nil,  nil,   17,  45, 32]  capacity = 10, originalCapacity = 5
    //                                                head = 20
    // [nil, nil, nil, nil, nil,  17,  45, 32]  capacity = 5
    //                           head = 5
    public mutating func dequeue() -> T? {
        guard !isEmpty else {
            return nil
        }
        
        let elementToRemove = array[head]
        
        // 清空第一位元素的值
        array[head] = nil
        
        // head 往后移一位
        head += 1
        
        // 当 head 往后移到两倍于 capacity 的位置时，清除前 1.5 * capacity 的内容
        let triggerCapacity = capacity * 2
        if capacity >= originalCapacity && head >= triggerCapacity {
            let amountToRemove = capacity + capacity / 2
            array.removeFirst(amountToRemove)
            head -= amountToRemove
            capacity = triggerCapacity - amountToRemove
        }
    
        return elementToRemove
    }
    
    
    public mutating func dequeueBack() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeLast()
        }
    }
    
    
    public func peekFront() -> T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
    
    
    public func peekBack() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.last!
        }
    }
    
}


