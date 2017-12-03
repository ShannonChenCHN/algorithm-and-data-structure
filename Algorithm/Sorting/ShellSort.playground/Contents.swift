//: Playground - noun: a place where people can play

import UIKit


/*
 希尔排序：
 
 基本思想：
 - 先将要排序的一组数按某个增量d（n/2,n为要排序数的个数）分成若干组，每组中记录的下标相差 d。
 - 对每组中全部元素进行插入排序。
 - 然后再用一个较小的增量（d/2）对它进行分组，在每组中再进行插入排序。
 - 当增量减到 1 时，进行插入排序后，排序完成。
 
 
 示意图：
 
 1. 第一次分组：
             [ 64, 20, 50, 33, 72, 10, 23, -1, 4]        d = floor(9/2) = 4
 
 sublist 0:  [ 64, xx, xx, xx, 72, xx, xx, xx, 4  ]
 sublist 1:  [ xx, 20, xx, xx, xx, 10, xx, xx, xx ]
 sublist 2:  [ xx, xx, 50, xx, xx, xx, 23, xx, xx ]
 sublist 3:  [ xx, xx, xx, 33, xx, xx, xx, -1, xx ]
 

 2. 对每组中全部元素进行插入排序：
 
 sublist 0:  [ 4, xx, xx, xx, 64, xx, xx, xx, 72 ]
 sublist 1:  [ xx, 10, xx, xx, xx, 20, xx, xx, xx ]
 sublist 2:  [ xx, xx, 23, xx, xx, xx, 50, xx, xx ]
 sublist 3:  [ xx, xx, xx, -1, xx, xx, xx, 33, xx ]
 
 
             [ 4, 10, 23, -1, 64, 20, 50, 33, 72 ]      d = floor(4/2) = 2
 
 3. 再次分组：
 
 sublist 0:  [  4, xx, 23, xx, 64, xx, 50, xx, 72 ]
 sublist 1:  [ xx, 10, xx, -1, xx, 20, xx, 33, xx ]
 
 4. 进行插入排序：
 
 sublist 0:  [  4, xx, 23, xx, 50, xx, 64, xx, 72 ]
 sublist 1:  [ xx, -1, xx, 10, xx, 20, xx, 33, xx ]
 
 
             [ 4, -1, 23, 10, 50, 20, 64, 33, 72 ]    d = floor(2/2) = 1
 
 5. 进行插入排序：
            [ -1, 4, 10, 20, 23, 33, 50, 64, 72 ]
 
 */
