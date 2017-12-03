//: Playground - noun: a place where people can play

import UIKit

/**
 
 冒泡排序
 
 基本思想：在要排序的一组数中，对当前还未排好序的范围内的全部数，自上而下对相邻的两个数依次进行比较和调整，让较大的数往下沉，较小的往上冒。即：每当两相邻的数比较后发现它们的排序与排序要求相反时，就将它们互换。
 
 示意图：
 
 [57, 68, 59, 52]
          *    *
 
 [57, 68, 52, 59]
      *   *
 
 [57, 52, 68, 59]
  *    *
 
 [52, 57, 68, 59]
           *   *
 
 [52, 57, 59, 68]
       *   *
 
 [52, 57, 59, 68]
 
 
 
 
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Bubble%20Sort
 
 */
