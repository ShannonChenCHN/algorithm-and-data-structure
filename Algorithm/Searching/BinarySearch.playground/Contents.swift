//: Playground - noun: a place where people can play

import UIKit


/*
 
 二分查找
 
 二分查找采用了分而治之的算法思想：
 1. 将一个数组一分为二，然后再判断搜索关键字在左半部分，还是右半部分
 2. 怎么判断搜索关键字在左半部分，还是右半部分呢？将最中间的元素跟搜索关键字比较大小，如果比它大，就取左边，如果比它小，取右边，如果想等就说明找到了
 3. 然后再对左半部分（或者右半部分）重复上面的步骤1和2，直到不能再分了
 
 前提条件是：数组必须是有序数组
 
 复杂度：O(log n)
 
 应用：
 二分查找适用于那种一经建立就很少改动而又经常需要查找的线性表。

 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Search
 https://en.wikipedia.org/wiki/Binary_search_algorithm
 
 */



/*
 
 查找 3
 
 [3, 6, 17, 23, 29, 82]   midIndex = 0 + (6 - 0) / 2  => 3      23 > 3
             ^

 
 [3, 6, 17]                midIndex = 0 + (3 - 0) / 2 =>  1       6 > 3
     ^
 
 
 [3]    3 == 3
  ^
 
 */

/// 递归方式实现的二分查找
func binarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    
    if range.lowerBound >= range.upperBound {
        // 没找到
        return nil
    } else {
        // 分割的中点
        // 注意：有些二分法计算中点的方式是 midIndex = (lowerBound + upperBound) / 2
        //      这在 32 位机器上可能会出现 bug，因为如果要处理的数据量很大的话，
        //      (lowerBound + upperBound) 的值可能会超出一个 Integer 的最大范围
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        
        if a[midIndex] > key {
            // 如果中间元素比 key 大，就取中间元素的左半部分
            return binarySearch(a, key: key, range: range.lowerBound ..< midIndex)
            
        } else if a[midIndex] < key {
            // 如果中间元素比 key 小，就取中间元素的右半部分
            return binarySearch(a, key: key, range: midIndex+1 ..< range.upperBound)
        } else {
            // 如果想等，就说明找到了
            return midIndex
        }
    }
}

/// 遍历方式实现的二分查找
func binarySearch<T: Comparable>(_ array: [T], key: T) -> Int? {
    var lowerBound = 0
    var upperBound = array.count
    
    while lowerBound < upperBound {
        // 计算中点
        let midIndex = lowerBound + (upperBound - lowerBound) / 2
        
        if array[midIndex] == key {
            // 找到了
            return midIndex
        } else if array[midIndex] < key {
            // 取右边
            lowerBound = midIndex + 1
        } else {
            // 取左边
            upperBound = midIndex
        }
    }
    
    return nil
}

let numbers = [3, 6, 17, 23, 29, 82]  // 一个排好序的数组
binarySearch(numbers, key: 3, range: 0 ..< numbers.count)
binarySearch(numbers, key: 3)

