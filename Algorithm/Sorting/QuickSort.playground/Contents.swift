//: Playground - noun: a place where people can play

import UIKit


/**
 
 快速排序
 
基本思想：选择一个基准元素,通常选择第一个元素或者最后一个元素,通过一趟扫描，将待排序列分成两部分,一部分比基准元素小,一部分大于等于基准元素,此时基准元素在其排好序后的正确位置,然后再用同样的方法递归地排序划分的两部分。
 
 示意图：
 https://github.com/raywenderlich/swift-algorithm-club/blob/master/Quicksort/Images/Example.png
 
 [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]
 
 1. 找基准 i = a.count/2 = 6 , n = 8
 
 分成 2 组
 less:    [ 0, 3, 2, 1, 5, -1 ]
 equal:   [ 8, 8 ]
 greater: [ 10, 9, 14, 27, 26 ]
 
 
 1.1 分解第一组，找基准 n = 1
 [ 0, 3, 2, 1, 5, -1 ]
 
 less:    [ 0, -1 ]
 equal:   [ 1 ]
 greater: [ 3, 2, 5 ]
 
 1.1.1 分解第一组的第一部分
 
 [ 0, -1 ]
 
 less:    [ ]
 equal:   [ -1 ]
 greater: [ 0 ]
 
 1.1.2 分解第一组的第二部分
 
 [ 3, 2, 5 ]
 
 less:    [ ]
 equal:   [ 2 ]
 greater: [ 3, 5 ]
 
 1.1.2.1 分解第一组的第二部分的第二部分
 
 [ 3, 5 ]
 
 less:    [ 3 ]
 equal:   [ 5 ]
 greater: [ ]
 
 1.2 分解第二组
 ......
 
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Quicksort
 
 */
