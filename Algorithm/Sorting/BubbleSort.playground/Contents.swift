//: Playground - noun: a place where people can play

import UIKit

/**
 
 冒泡排序
 
 基本思想：在要排序的一组数中，对当前还未排好序的范围内的全部数，自上而下对相邻的两个数依次进行比较和调整，让较大的数往下沉，较小的往上冒。即：每当两相邻的数比较后发现它们的排序与排序要求相反时，就将它们互换。
 一句话概括就是，大的往后走
 
 示意图：
 
 [57, 68, 59, 52]
  *    *
 
 [57, 59, 68, 52]
      *   *
 
 [57, 59, 52, 68]
          *    *
 
 [57, 59, 52, 68]
   *   *
 
 [57, 52, 59, 68]
       *   *
 
 [52, 57, 59, 68]
  *   *
 
 
 
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Bubble%20Sort
 https://baike.baidu.com/item/冒泡排序
 
 */


func bubbleSort<T: Comparable>(_ list: inout [T]) {
    
    // 每拍完一轮，sortedCount 加 1
    let countNeedToSort = list.count - 1
    for sortedCount in 0..<countNeedToSort {
        
        let firstSortedIndex = countNeedToSort-sortedCount
        for i in 0..<firstSortedIndex {
            if list[i] > list[i+1] {
                list.swapAt(i, i+1)
            }
        }
    }
}

var array =  [57, 68, 59, 52]
bubbleSort(&array)


