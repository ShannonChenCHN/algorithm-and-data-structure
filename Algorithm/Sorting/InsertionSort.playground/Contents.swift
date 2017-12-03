//: Playground - noun: a place where people can play

import UIKit


/*
 
 插入排序
 
 ![](https://en.wikipedia.org/wiki/File:Insertion-sort-example-300px.gif)
 
 基本思想：在要排序的一组数中，从第一个到最后一个，依次将前 n 个元素进行排序。
 算法步骤：
 1. 把要排序的数字都放到一个 pile 中，这个 pile 中是没排过序的。
 2. 从 pile 中取出一个数字（通常是第一个）。
 3. 将这个数字插入到一个新数组中。
 4. 从 pile 中取出下一个数字，也是插入到上面步骤 3 中的那个数组中，然后再对这个数组进行排序。
 5. 接着从 pile 中再取出下一个数字，然后再插入到上面步骤 3 中的那个数组中的合适位置，保证数组是有序的。
 6. 如此反复循环，直到 pile 中没有数字了。
 
 复杂度：O(n^2)
 
 示意图：
 （假设 “|”左侧的是排好序的数组，右侧是 pile ）
 
 [| 8, 3, 5, 4, 6 ]
 [ 8 | 3, 5, 4, 6 ]
 [ 3, 8 | 5, 4, 6 ]
 [ 3, 5, 8 | 4, 6 ]
 [ 3, 4, 5, 8 | 6 ]
 [ 3, 4, 5, 6, 8 |]
 
 
 ### 插入的过程：
 方式一：
 [ 3, 5, 8 | 4, 6 ]
 [ 3, 5, 8, 4 | 6 ]
         ^
 [ 3, 5, 4, 8 | 6 ]
         <-->
       swapped
 [ 3, 4, 5, 8 | 6 ]
      <-->
     swapped
 
 方式二：
 [ 3, 5, 8, 4 | 6 ]   remember 4
            *
 
 [ 3, 5, 8, 8 | 6 ]   shift 8 to the right
         --->
 
 [ 3, 5, 5, 8 | 6 ]   shift 5 to the right
      --->
 
 [ 3, 4, 5, 8 | 6 ]   copy 4 into place
      *
 
 
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Insertion%20Sort
 https://en.wikipedia.org/wiki/Insertion_sort
 
 
 */


/// 方式一
func insertionSort1<T: Comparable>(_ array: [T]) -> [T] {
    var a = array
   
    // 从第 1 个开始
    for x in 1..<a.count {
        var y = x
        
        // 依次与前面的 x 个元素进行比较，再根据结果互换位置
        while y > 0 && a[y] < a[y - 1] {
            a.swapAt(y - 1, y)
            y -= 1
        }
    }
    return a
}



/// 方式二
func insertionSort2<T: Comparable>(_ array: [T]) -> [T] {
    var a = array
    
    // 从第 1 个开始
    for x in 1..<a.count {
        var y = x
        let temp = a[y]
        while y > 0 && temp < a[y - 1] {
            a[y] = a[y - 1]
            y -= 1
        }
        a[y] = temp
    }
    return a
}

let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
insertionSort1(list)

let strings = [ "b", "a", "d", "c", "e" ]
insertionSort2(strings)
