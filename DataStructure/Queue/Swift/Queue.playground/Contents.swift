//: Playground - noun: a place where people can play

import UIKit


/*
 ### 什么是队列？
 队列是是一个表（list），你只能把最新的元素插到最后，或者移除最前面的元素
 先进先出，先加入队列的元素会最先被移出队列
 
 
 可视化演示：
                              ^
                              |
┏━━━━━━┓ ┏━━━━━━┓ ┏━━━━━━┓ ┏━━━━━━┓ ┏━━━━━━┓
┃      ┃ ┃  10  ┃ ┃  10  ┃ ┃  10  ┃ ┃   3  ┃
┃      ┃ ┃      ┃ ┃  3   ┃ ┃  3   ┃ ┃  57  ┃
┃      ┃ ┃      ┃ ┃      ┃ ┃  57  ┃ ┃      ┃
┗━━━━━━┛ ┗━━━━━━┛ ┗━━━━━━┛ ┗━━━━━━┛ ┗━━━━━━┛
   ^         ^       ^
   |         |       |
   10        3       57
 
 ### 为什么需要队列？
 当你在处理一组数据时，需要考虑添加和移除元素的顺序，而且需要先进先出这种处理机制，此时就可以用到队列
 
 ### 类似的数据结构
 - 栈：后进先出
 
 ### 复杂度
 #### enqueue 的复杂度：O(1)
 因为每次添加一个元素到队列时，都是添加到数组的最后，而不管数组有多大，添加元素到数组最后的耗时都是一个常量
 
 
 #### 为什么添加元素到数组后面的复杂度是 O(1)或者一个耗时为常量的操作？
 因为在 Swift 的实现中，数组的末尾总是会有空余的空间，比如，现在有这样一个数组
 ```
 ["Ada", "Steve", "Tim"]
 ```
 在内存中，它实际上是这样的
 ```
 [ "Ada", "Steve", "Tim", xxx, xxx, xxx ]
 ```
 xxx 就是暂时分配了内存但是没有用到的单元，如果添加了一个新元素，新添加的元素就会占用一个空白的内存单元
 ```
 [ "Ada", "Steve", "Tim", "Grace", xxx, xxx ]
 ```
 
 边界情况：但是数组末尾分配的空余空间是有限的，当最后一个 xxx 也被用了的话，如果你还要添加新的元素到数组中，你就需要重新调整数组的大小。调整数组的大小意味着需要分配新的内存空间给一个新数组，并且将原来的数组元素全部拷贝到新数组中。这个时候的操作就是一个复杂度为 O(n) 的操作，但是这只是一种极端情况，所以可以说一般情况下，添加新元素到数组的最后还是 O(1) 的操作。
 
 
 #### dequeue 的复杂度为 O(n)
 因为每次移除元素时，都是将数组中的第一个元素移除，然后再将后面剩余的元素往前移
 比如在我们的例子中，当将 Ada 从队列中移除时，后面的 Steve 将会被拷贝到 Ada 的位置，Tim 将会被拷贝到 Tim 的位置，... 以此类推
 
 ```
 before   [ "Ada", "Steve", "Tim", "Grace", xxx, xxx ]
                    /       /      /
                   /       /      /
                  /       /      /
                 /       /      /
 after    [ "Steve", "Tim", "Grace", xxx, xxx, xxx ]
 ```
 
 
 ### 队列的实现

 #### 队列的基本实现
 - 基于数组
 
 
 #### 高效的队列
 
 借鉴 Swift 中数组末尾空余内存的思路，我们可以通过在数组前面保留一些空余内存空间来提高队列的 dequeue 操作的效率。
 其核心思想是当我们从队列中移除一个元素后，我们会通过将这个元素在数组中的位置标记为空，来保证后面的元素在内存中的位置不发生改变。
 比如，数组
 ```
 [ "Ada", "Steve", "Tim", "Grace", xxx, xxx ]
    head
 ```
 移除第一个元素 Ada 后，变成这样
 ```
 [ xxx, "Steve", "Tim", "Grace", xxx, xxx ]
          head
 ```
 
 移除第二个元素 Steve 后，就变成这样
 ```
 [ xxx, xxx, "Tim", "Grace", xxx, xxx ]
              head
 ```
 
 因为数组前面的空白单元都没有被重用，所以我们可以在某个时间点，再将数组中所有的元素都往前移，然后就变成这样
 ```
 ["Tim", "Grace", xxx, xxx ]
   head
 ```
 这种操作的复杂度为 O(n)，但是因为只是偶尔才出现一次，所以总的复杂度平均下来还是 O(1)。
 
 #### 问题
 - 数组在内存中是如何布局的？
 - 从数组中移除第一个元素后，数组后面的元素发生了什么变化
 
 */


/// 基于数组封装的队列
public struct Queue<T> {
    var array = [T]()
    
    // 是否为空
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    // 元素个数
    public var count: Int {
        return array.count
    }
    
    // 加入队列
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    // 移除队列
    public mutating func dequeue() -> T? {
        if array.isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    // 首元素
    public var front: T? {
        return array.first
    }
    
}

var queue = Queue<String>()
queue.enqueue("Ada")
queue.enqueue("Steve")
queue.enqueue("Tim")




/// 更高效的队列
public struct EfficientQueue<T> {
    fileprivate var array = [T?]()   // 数组中的数据类型为 optional，因为会有 nil
    fileprivate var headIndex = 0    // 标记第一个真实元素的位置
    
    
    // 是否为空
    public var isEmpty: Bool {
        return (count == 0)
    }
    
    // 元素个数
    public var count: Int {
        return (array.count - headIndex)
    }
    
    // 加入队列
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    
    // 移除队列
    public mutating func dequeue() -> T? {
        // 异常处理，记录要移除的元素
        guard array.count > headIndex, let elementToRemove = array[headIndex] else {
            return nil
        }
        
        // 移除元素
        array[headIndex] = nil // 将要移除的元素的空间设为 nil
        headIndex += 1         // head 索引加 1
        
        // 定期调整元素位置
        let percentage = Double(headIndex) / Double(array.count)
        let triggerCount = 50
        if array.count > triggerCount, percentage > 0.25 {  //    或者其他条件：    if headIndex > 2 {
            array.removeFirst(headIndex)    // 移除前 headIndex 个元素
            headIndex = 0                   // 重置真实 head 索引值
        }
        
        return elementToRemove
    }
    
    // 首元素
    public var front: T? {
        // 先判断是否为空
        if isEmpty {
            return nil
        } else {
            return array[headIndex]
        }
    }
    
}

var q = EfficientQueue<String>()
q.array                   // [] empty array

q.enqueue("Ada")
q.enqueue("Steve")
q.enqueue("Tim")
q.array             // [{Some "Ada"}, {Some "Steve"}, {Some "Tim"}]
q.count             // 3

q.dequeue()         // "Ada"
q.array             // [nil, {Some "Steve"}, {Some "Tim"}]
q.count             // 2

q.dequeue()         // "Steve"
q.array             // [nil, nil, {Some "Tim"}]
q.count             // 1

q.enqueue("Grace")
q.array             // [nil, nil, {Some "Tim"}, {Some "Grace"}]
q.count             // 2




