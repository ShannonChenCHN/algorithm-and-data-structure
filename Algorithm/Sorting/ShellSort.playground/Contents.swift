//: Playground - noun: a place where people can play

import UIKit


/*
 希尔排序：
 
 基本思想：
 - 先将要排序的一组数按某个增量d（一般为 n/2, n为要排序数的个数）分成若干组，每组中记录的下标相差 d。
 - 对每组中全部元素进行插入排序。
 - 然后再用一个较小的增量（d/2）对它进行分组，在每组中再进行插入排序。
 - 当增量减到 1 时，进行插入排序后，排序完成。
 
 复杂度：O(n^2)
 
 示意图：
 
 1. 第一次分组：
             [ 64, 20, 50, 33, 72, 10, 23, -1, 4]        d = floor(9/2) = 4
 
 sublist 0:  [ 64, xx, xx, xx, 72, xx, xx, xx,  4 ]
 sublist 1:  [ xx, 20, xx, xx, xx, 10, xx, xx, xx ]
 sublist 2:  [ xx, xx, 50, xx, xx, xx, 23, xx, xx ]
 sublist 3:  [ xx, xx, xx, 33, xx, xx, xx, -1, xx ]
 

 2. 对每组中全部元素进行插入排序：
 
 sublist 0:  [  4, xx, xx, xx, 64, xx, xx, xx, 72 ]
 sublist 1:  [ xx, 10, xx, xx, xx, 20, xx, xx, xx ]
 sublist 2:  [ xx, xx, 23, xx, xx, xx, 50, xx, xx ]
 sublist 3:  [ xx, xx, xx, -1, xx, xx, xx, 33, xx ]
 
             [  4, 10, 23, -1, 64, 20, 50, 33, 72 ]      d = floor(4/2) = 2
 
 3. 再次分组：
 
 sublist 0:  [  4, xx, 23, xx, 64, xx, 50, xx, 72 ]
 sublist 1:  [ xx, 10, xx, -1, xx, 20, xx, 33, xx ]
 
 4. 进行排序：
 
 sublist 0:  [  4, xx, 23, xx, 50, xx, 64, xx, 72 ]
 sublist 1:  [ xx, -1, xx, 10, xx, 20, xx, 33, xx ]
 
 
             [ 4, -1,  23, 10, 50, 20, 64, 33, 72 ]    d = floor(2/2) = 1
 
 5. 进行排序：
            [ -1, 4, 10, 20, 23, 33, 50, 64, 72 ]
 
 
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Shell%20Sort
 http://blog.csdn.net/robomaster/article/details/50953265
 https://baike.baidu.com/item/希尔排序
 */

/// 插入排序方式一：一个一个一次往后走，比较时才按 gap 算
private func insertionSort1<T: Comparable>(list: inout [T], gap: Int) {

    // 插入排序：从第 gap 个开始
    for index in gap..<list.count {
        
        // 依次和前面已经排好序的进行比较
        var preIndex = index - gap
        while preIndex >= 0 {
            
            if list[preIndex] > list[preIndex+gap] {
                
                list.swapAt(preIndex, preIndex + gap)
            }
            
            preIndex -= gap
            
        }
    }
    // 以第一轮为例，从 startInex = 4 一直到最后一个
    // [ 64, 20, 50, 33, 72, 10, 23, -1, 4]   ->  [ 64, 20, 50, 33, 72, 10, 23, -1, 4]
    //    *              *                           *               *
    // [ 64, 20, 50, 33, 72, 10, 23, -1, 4]   ->  [ 64, 10, 50, 33, 72, 20, 23, -1, 4]
    //        *              *                           *               *
    // [ 64, 10, 50, 33, 72, 20, 23, -1, 4]   ->  [ 64, 10, 23, 33, 72, 20, 50, -1, 4]
    //            *               *                         *                *
    // [ 64, 10, 23, 33, 72, 20, 50, -1, 4]   ->  [ 64, 10, 23, -1, 72, 20, 50, 33, 4]
    //                *               *                         *                *
    // [ 64, 10, 23, -1, 72, 20, 50, 33, 4]   ->  [ 64, 10, 23, -1, 4, 20, 50, 33, 72]
    //                    *               *                         *               *
    // [ 64, 10, 23, -1,  4, 20, 50, 33, 72]  ->  [  4, 10, 23, -1, 64, 20, 50, 33, 72]
    //    *               *                          *               *
        
}

// 插入排序方式二：一开始就按 gap 来依次处理，也就是 sublist 的形式
private func insertionSort2<T: Comparable>(list: inout [T], gap: Int) {
    
    let sublistCount = gap
    
    // 一个一个 sublist 来处理
    for startIndex in 0..<sublistCount {
        
        // 从“第二个”开始，依次和前面排好序的进行比较
        for i in stride(from: (startIndex + gap), to: list.count, by: gap) {
            let currentValue = list[i]
            var pos = i
            
            // 依次往前找，直到没有比它大的，而且还不能越界
            while pos >= sublistCount && list[pos - gap] > currentValue {
                
                list[pos] = list[pos - gap]
                pos -= gap
            }
            
            list[pos] = currentValue
        }
    }
    
}


/// 希尔排序
public func shellSort<T: Comparable>(_ list: inout [T]) {
    
    var gap = list.count / 2  // 首次取中间值
    
    // gap 为 1 时，结束循环
    while gap > 0 {
        
        insertionSort2(list: &list, gap: gap)
        
        // 每次循环后 gap 折半
        gap = gap / 2
        
        print(list)
        print("\n")
    }

}


var array = [ 64, 20, 50, 33, 72, 10, 23, -1, 4]
shellSort(&array)


