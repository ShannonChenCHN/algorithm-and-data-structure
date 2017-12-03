//: Playground - noun: a place where people can play

import UIKit

/**
 线性查找
 
 线性查找：从第一个开始往后找，一个一个地和目标值比较，如果值相等就找到了，不相等就继续往后找，直到最后一个元素
 
 复杂度：O(n)
 
 应用：
 
 
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Linear%20Search
 https://en.wikipedia.org/wiki/Linear_search
 
 **/


/*
 
 查找 23
 
 [3, 6, 77, 23, 19, 82]
  ^
 
 [3, 6, 77, 23, 19, 82]
     ^
 
 [3, 6, 77, 23, 19, 82]
        ^
 
 [3, 6, 77, 23, 19, 82]
             ^
 
 */

// 方式一
func linearSearch<T: Comparable>(_ objectToSearch: T, in array: [T]) -> Int? {
    for (index, obj) in array.enumerated() where obj == objectToSearch {
        return index
    }
    
    return nil
}


// 方式二（语法不同而已）
func linearSearch<T: Equatable>(_ array: [T], _ key: T) -> Int? {
    for i in 0 ..< array.count {
        if array[i] == key {
            return i
        }
    }
    return nil
}


let array = [3, 6, 77, 23, 19, 82]
linearSearch(77, in: array)
linearSearch(array, 77)

