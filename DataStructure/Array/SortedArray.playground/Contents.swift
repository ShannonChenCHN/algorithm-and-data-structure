//: Playground - noun: a place where people can play

import UIKit


/**
 
 有序表（Ordered Array）
 
 有序表：按元素值大小顺序排列的数组
 
 当你需要一个有序的数据结构来存储数据时，此时可以使用有序表。
 如果会经常插入新的元素到数组中，有序表的效率会减低，所以，这样的情况下更建议使用普通的数组来存储，然后再手动排序。
 
 */


public struct OrderedArray<T: Comparable> {
    fileprivate var array = [T]()
    
    public init(array: [T]) {
        // 使用 Swift 标准库内置的方法来实现排序
        // 存储的元素必须遵守 Comparable 协议
        self.array = array.sorted()
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public subscript(index: Int) -> T {
        return array[index]
    }
    
    public mutating func removeAtIndex(index: Int) -> T {
        return array.remove(at: index)
    }
    
    public mutating func removeAll() {
        array.removeAll()
    }
    
    public mutating func insert(_ newElement: T) -> Int {
        
        let i = findInsertionPoint(newElement) // 找到合适位置
        
        array.insert(newElement, at: i) // 插入新元素
        
        return i
    }
    
    // 从第 0 个开始一个一个对比，找到合适的位置，如果没找到，就插到最后
    private func findInsertionPoint(_ newElement: T) -> Int {
        for i in 0..<array.count {
            if newElement <= array[i] {
                return i
            }
        }
        return array.count
    }
    
    /*
    // 使用效率更高的二分法进行排序
    private func findInsertionPoint(_ newElement: T) -> Int {
        var startIndex = 0
        var endIndex = array.count
        
        while startIndex < endIndex {
            let midIndex = startIndex + (endIndex - startIndex) / 2
            if array[midIndex] == newElement {
                return midIndex
            } else if array[midIndex] < newElement {
                startIndex = midIndex + 1
            } else {
                endIndex = midIndex
            }
        }
        return startIndex
    }
 
 */
}

extension OrderedArray: CustomStringConvertible {
    public var description: String {
        return array.description
    }
}



var a = OrderedArray<Int>(array: [5, 1, 3, 9, 7, -1])
a              // [-1, 1, 3, 5, 7, 9]

a.insert(4)    // inserted at index 3
a              // [-1, 1, 3, 4, 5, 7, 9]

a.insert(-2)   // inserted at index 0
a.insert(10)   // inserted at index 8
a              // [-2, -1, 1, 3, 4, 5, 7, 9, 10]
