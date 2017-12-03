//: Playground - noun: a place where people can play

import UIKit

/*
 归并排序
 
 基本思想：归并（Merge）排序法是将两个（或两个以上）有序表合并成一个新的有序表，即把待排序序列分为若干个子序列，每个子序列是有序的。然后再把有序子序列合并为整体有序序列。
 
 示意图：
 
 [2, 1, 5, 4, 9]
 
 1. 分解
 [2, 1]  [5, 4, 9]
 
 [2] [1] [5] [4, 9]
 
 [2] [1] [5] [4] [9]
 
 2. 合并
 [1, 2] [4, 5] [9]
 
 [1, 2, 4, 5] [9]
 
 [1, 2, 4, 5, 9]
 
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Merge%20Sort
 
 */
