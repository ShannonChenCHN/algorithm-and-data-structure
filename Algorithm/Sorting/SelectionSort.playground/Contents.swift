//: Playground - noun: a place where people can play

import UIKit

/**
 
 选择排序
 
 
 基本思想：
 - 在要排序的一组数中，选出最小的一个数与第一个位置的数交换。
 - 然后在剩下的数当中再找最小的与第二个位置的数交换，如此循环到倒数第二个数和最后一个数比较为止。
 
 复杂度： O(n^2)
 
 示意图：
 [| 5, 8, 3, 4, 6 ]
 
 最小的是 3
 [ 3 | 8, 5, 4, 6 ]
   *      *
 
 最小的是 4
 [ 3, 4 | 5, 8, 6 ]
      *      *
 
 在最小的是 5
 [ 3, 4, 5 | 8, 6 ]
         *
 
 最小的是 6
 [ 3, 4, 5, 6 | 8 ]
            *
 
 最小的是 8
 [ 3, 4, 5, 6, 8 ]
 
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Selection%20Sort
 
 */



func selectionSort<T: Comparable>(_ array: inout [T]) {
    guard array.count >= 1 else {
        return
    }
    
    let lastIndex = array.count - 1
    let secondLastIndex = lastIndex - 1
    
    // 将数组分成排好序的和没有排好序的，从原数组的第一个开始
    for unsortedStartIndex in 0...secondLastIndex {
        
        var lowest = unsortedStartIndex
        for temp in (unsortedStartIndex + 1)...lastIndex {
            if array[temp] < array[lowest] {
                lowest = temp
            }
        }
        
        if unsortedStartIndex != lowest {
            array.swapAt(unsortedStartIndex, lowest)
        }
        
        print(list)
    }

}

var list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
selectionSort(&list)


