//
//  PriorityQueue.swift
//  Tests
//
//  Created by ShannonChen on 2017/12/3.
//

import Foundation



/// 优先队列
/// 所有操作的复杂度都是 O(lg n)
/// 优先队列通常都是由 Heap 来实现的，跟 Heap 类似，优先队列也分为 max-priority queue 和 min-priority queue
public struct PriorityQueue<T> {
    fileprivate var heap: Heap<T>
    
    public init(sort: @escaping (T, T) -> Bool) {
        heap = Heap(sort: sort)
    }
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    
    public var count: Int {
        return heap.count
    }
    
    public func peek() -> T? {
        return heap.peek()
    }
    
    public mutating func enqueue(_ element: T) {
        heap.insert(element)
    }
    
    public mutating func dequeue() -> T? {
        return heap.remove()
    }
    
    public mutating func changePriority(index i: Int, value: T) {
        return heap.replaceElement(at: i, with: value)
    }
}


extension PriorityQueue where T: Equatable {
    
    public func index(of element: T) -> Int? {
        return heap.index(of: element)
    }
}
