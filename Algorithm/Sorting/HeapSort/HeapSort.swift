//
//  HeapSort.swift
//  
//
//  Created by ShannonChen on 2017/12/6.
//

import Foundation

/*
 
 堆排序
 
 基本思想：堆排序是一种树形选择排序，是对直接选择排序的有效改进。
 
 
 复杂度：O(n lg n)
 
 示意图：
 
 [ 5, 13, 2, 25, 7, 17, 20, 8, 4 ]
 
 1. 先转成最大堆
 
 [ 25, 13, 20, 8, 7, 17, 2, 5, 4 ]
 
                      25
                     /  \
                    13   20
                   / \   / \
                  8   7 17  2
                 / \
                5   4
 
 2. 将第 1 个和最后一个元素互换
 
 [ 4, 13, 20, 8, 7, 17, 2, 5, 25 ]
   *                          *
 

 3. 重新调整前 n - 1 个元素的二叉堆属性
 
    [20, 13, 17, 8, 7, 4, 2, 5 | 25]
 
                         20
                        /  \
                       13   17
                      / \   / \
                     8   7 4   2
                    /
                   5
 
 4. 继续将第 1 个和最后一个元素（实际上是第 n - 1 个）互换
 
 [5, 13, 17, 8, 7, 4, 2, 20 | 25]
   *                      *
 
 5. 重新调整前 n - 2 个元素的二叉堆属性
 
     [17, 13, 5, 8, 7, 4, 2 | 20, 25]
 
 
 6. 如此循环，直到全部排好序
 
 */


extension Heap {
    
    /// 堆排序
    public mutating func sort() -> [T] {
        
        // 每次将没排序的部分的最后一个元素和第一个元素互换，然后再调整平衡
        let lastIndex = elements.count - 1
        for lastUnsortedIndex in stride(from: lastIndex, through: 1, by: -1) {
            
            elements.swapAt(lastUnsortedIndex, 0)
            shiftDownElement(at: 0, heapSize: lastUnsortedIndex)
            
            print(elements)
        }
        return elements
    }
}

public func heapsort<T>(_ a: [T], _ sort: @escaping (T, T) -> Bool) -> [T] {
    let reverseOrder = { i1, i2 in sort(i2, i1) }
    var h = Heap(array: a, sort: reverseOrder)
    return h.sort()

}
