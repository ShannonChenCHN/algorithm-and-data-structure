//: Playground - noun: a place where people can play

import UIKit


/*
 
 堆
 
 堆（Heap)是计算机科学中一类特殊的数据结构的统称。
 堆通常是一个可以被看做一棵树的数组对象。
 堆总是满足下列性质：
 - 堆中某个节点的值总是不大于（或不小于）其父节点的值；
 - 堆总是一棵完全二叉树。
 
 堆序性质（Heap property）：决定堆中节点排序的性质。
 
 根据堆中节点排序方式的不同，可以将堆分为两种：
 - 最大堆：根节点最大的堆
 - 最小堆：根节点最小的堆
 
 常见的堆有二叉堆、斐波那契堆等。
 
 堆可以用来创建优先队列，还可以用来执行堆排序，以及找出一个集合中的最大值和最小值。
 
 
 https://en.wikipedia.org/wiki/Heap_(data_structure)
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Heap
 https://baike.baidu.com/item/堆
 
 */

/**
 Swift 相关知识点：
 
 1. @escape
  @escaping 标记可以作为一个警告，来提醒使用这个函数的开发者这是一个逃逸闭包，需要注意引用关系。
 
 如果这个闭包是在这个函数结束前内被调用，就是非逃逸的即noescape。
 如果这个闭包是在函数执行完后才被调用，调用的地方超过了这函数的范围，所以叫逃逸闭包。
 
 http://www.jianshu.com/p/266c2370effd
 http://www.jianshu.com/p/120069d493f5
 
 
 2. 内联函数 @inline(__always)
 
 https://www.cnblogs.com/ysk-china/p/5899495.html
 
 */

public struct Heap<T> {
    
    var elements = [T]()  // 存储堆节点的数组
    
    fileprivate var isOrderedBefore: (T, T) -> Bool //  决定堆性质的属性 max-heap (>) or min-heap (<).
    
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    public var count: Int {
        return elements.count
    }
    
    // 父节点的位置
    @inline(__always) func parentIndex(ofIndex i: Int) -> Int {
        return (i - 1) / 2
    }
    
    // 左子节点的位置
    @inline(__always) func leftChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 1
    }
    
    // 右子节点的位置
    @inline(__always) func rightChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 2
    }
    
    // 初始化
    public init(sort: @escaping(T, T) -> Bool) {
        self.isOrderedBefore = sort
    }
    
    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.isOrderedBefore = sort
        buildHeap(fromArray: array)
    }
    
    // 直接线性插入，复杂度为 O(n log n)
//    fileprivate func buildHeap(fromArray array: [T]) {
//        for value in array {
//            insert(value)
//        }
//    }
    
    // 采用Floyd 算法，复杂度为 O(n)
    fileprivate mutating func buildHeap(fromArray array: [T]) {
        elements = array
        // 因为从第 n/2 个到第 n - 1 个的位置都是叶节点，所以
        for i in stride(from: (elements.count/2 - 1), through: 0, by: -1) {
            shiftDownElement(at: i, heapSize: elements.count)
        }
    }
    
    /// 插入新元素
    public mutating func insert(_ value: T) {
        // 先添加到数组的最后
        elements.append(value)
        
        // 与父节点比较，然后递归上移
        shiftUpElement(at: elements.count - 1)
    }

    // 移除根节点：
    public mutating func remove() -> T? {
        if isEmpty {
            return nil
        } else if elements.count == 1 {
            return elements.removeLast()
        } else {
            // 用最后第一个元素替换第一个元素，同时移除最后一个元素
            let value = elements.first
            elements[0] = elements.removeLast()
            
            // 下移第一个新元素
            shiftDownElement(at: 0, heapSize: elements.count)
            
            return value
        }
    }
    
    // 移除指定位置的节点：将最后一个元素与要移除的元素的位置进行互换，然后再根据实际情况进行 shift，最后移除最后一个元素
    @discardableResult public mutating func removeAt(_ index: Int) -> T? {
        guard index < count else {
            return nil
        }
        
        let lastIndex = elements.count - 1
        
        // 如果不是最后一个元素
        if index != lastIndex {
            // 将最后一个元素与要移除的元素进行互换
            elements.swapAt(index, lastIndex)
            
            // 先看看是否需要下移
            shiftDownElement(at: index, heapSize: elements.count - 1)
            
            // 再看看是否需要上移
            shiftUpElement(at: index)
        }
        
        // 移除最后一个元素
        return elements.removeLast()
    }
    
    
    // MARK: Shifting
    
    /*
            10
           /  \
          7    2
         / \  /
        5  1 (16)
     以上图中新插入的 16 为例
     */
    /// 上移指定位置的节点：将该节点依次与父节点以上的节点进行比较，如果需要调换，就将父节点下移，然后再与父节点的父节点比较，直到最终找到合适的位置
    mutating func shiftUpElement(at index: Int) {
        
        var indexToShift = index                         // 要偏移的节点的索引
        let elementToShift = elements[indexToShift]      // 要偏移的节点
        var parentIndex = self.parentIndex(ofIndex: indexToShift)
        
        
        // 不是根节点，而且子节点与父节点的大小顺序是反的
        while indexToShift > 0 && isOrderedBefore(elementToShift, elements[parentIndex]) {
            // 父节点下移
            elements[indexToShift] = elements[parentIndex]
            
            // 更新偏移索引值
            indexToShift = parentIndex
            
            // 重新计算子节点和父节点的索引
            parentIndex = self.parentIndex(ofIndex: indexToShift)
        }
        
        // 最终确定偏移结果
        elements[indexToShift] = elementToShift
    }
    
    
    
    /*
            (1)
           /  \
          10   2
         / \
        5   7
     以上图中的节点 1 为例
     */
    /// 下移指定节点：循环执行这样的操作————跟左右子节点比，哪个最大（或最小）就跟哪个调换位置，如果自己最大（或最小），就不调换了
    mutating func shiftDownElement(at index: Int, heapSize: Int) {

        var indexToShift = index //  indexToShift = 0, 1, 4
        
        while true {
            let leftChildIndex = self.leftChildIndex(ofIndex: indexToShift)  // leftChildIndex = 1, 3, 9
            let rightChildIndex = leftChildIndex + 1                         // leftChildIndex = 2, 4, 10
            
            // 跟左右子节点比，哪个最大（或最小）就跟哪个调换位置，如果自己最大（或最小），就不调换了
            var first = indexToShift        // first = 0, 1, 4
            if leftChildIndex < heapSize && isOrderedBefore(elements[leftChildIndex], elements[first]) { // 10 > 1, 5 > 1
                first = leftChildIndex      // first = 1, 3
            }
            
            if rightChildIndex < heapSize && isOrderedBefore(elements[rightChildIndex], elements[first]) { // 2 < 10, 7 > 1
                first = rightChildIndex    //  first = 不变, 4
            }
            
            // 1 != 0, 4!= 1, 4 == 4
            // 不需要再偏移时，就退出
            if first == indexToShift {
                break
            }

/*
                      10         10
                     /  \       /  \
                    1   2      7    2
                   / \        / \
                  5   7      5   1
 */
            // 调换位置
            elements.swapAt(indexToShift, first)
            
            // 更新偏移索引
            indexToShift = first // indexToShift = 1, 4
        }
    }
    
    
    /// 修改指定位置元素的值：找到该元素，修改钙元素的值，然后再重新 shift
    /// 限制条件：对于一个 max-heap，新值应该比旧值要大，同理，对于一个 min-heap，新值应该比旧值要小
    public mutating func replaceElement(at index: Int,with newValue: T) {
        guard index < elements.count else {
            return
        }
        
        // 限制条件：对于一个 max-heap，新值应该比旧值要大，同理，对于一个 min-heap，新值应该比旧值要小
        assert(isOrderedBefore(newValue, elements[index]))
        
        elements[index] = newValue
        shiftUpElement(at: index)
    }
    
}

// MARK: Searching

extension Heap where T: Equatable {
    
    /// 找出制定元素的位置
    public func index(of element: T) -> Int? {
        return search(element: element, startAt: 0)
    }
    
    
    /// 从第 index 个元素开始找
    private func search(element: T, startAt index: Int) -> Int? {
        
        // 检测起点是否越界
        guard index < count else {
            return nil
        }
        
        // 根据堆的特点，要查找的元素一定要比起点元素要靠后，也就是说，要查找的元素一定要在起点的子树中
        if isOrderedBefore(element, elements[index]) {
            return nil
        }
        
        // 如果刚好就是起点的元素
        if element == elements[index] {
            return index
        }
        
        // 从左子树中查找
        let leftChildIndex = self.leftChildIndex(ofIndex: index)
        if let indexInLeftChild = search(element: element, startAt: leftChildIndex) {
            return indexInLeftChild
        }
        
        // 从右子树中查找
        let rightChildIndex = self.rightChildIndex(ofIndex: index)
        if let indexInRightChild = search(element: element, startAt: rightChildIndex) {
            return indexInRightChild
        }
        
        // 没找到，返回 nil
        return nil
    }
}

// MARK: Debugging
extension Heap: CustomStringConvertible {
    public var description: String {
        
        return descriptionOfElement(at: 0)
    }
    
    func descriptionOfElement(at index: Int) -> String {
        
        var s = ""
        
        let parentIndex = index
        
        if parentIndex < 0 || parentIndex > count - 1 {
            return s
        }
        
        let leftIndex = leftChildIndex(ofIndex: parentIndex)
        if leftIndex < count {
            let leftChildDescription = descriptionOfElement(at: leftIndex)
            if leftChildDescription.count > 0 {
                s += "(\(leftChildDescription)) <- "
            }
        }
        
        s += "\(elements[parentIndex])"
        
        let rightIndex = rightChildIndex(ofIndex: parentIndex)
        if rightIndex < count {
            let rightChildDescription = descriptionOfElement(at: rightIndex)
            if rightChildDescription.count > 0 {
                s += " -> (\(rightChildDescription))"
            }
        }
        
        return s
    }
}

var heap = Heap<Int>.init(array: [51, 42, 65, 23, 15, 92, 33], sort: { (parent, child) -> Bool in
    return parent > child
})
print(heap)
print(heap.elements)

heap.insert(27)
print(heap)
print(heap.elements)

heap.index(of: 33)

heap.remove()
print(heap)
print(heap.elements)

