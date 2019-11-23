//
//  main.swift
//  RemoveDuplicates
//
//  Created by ShannonChen on 2019/11/21.
//  Copyright © 2019 ShannonChen. All rights reserved.
//

import Foundation


/// Given a sorted array nums, remove the duplicates in-place such that each element appear only once and return the new length.
///
/// Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.
///
/// Example 1:
///
/// ```
/// Given nums = [1,1,2],
///
/// Your function should return length = 2, with the first two elements of nums being 1 and 2 respectively.
///
/// It doesn't matter what you leave beyond the returned length.
/// ```
///
/// Example 2:
///
/// ```
/// Given nums = [0,0,1,1,1,2,2,3,3,4],
///
/// Your function should return length = 5, with the first five elements of nums being modified to 0, 1, 2, 3, and 4 respectively.
///
/// It doesn't matter what values are set beyond the returned length.
/// ```
func removeDuplicates(_ nums: inout [Int]) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    
    var validIdx = 0
    for i in 1..<nums.count {
        let num = nums[i]
        
        if num > nums[validIdx] {
            validIdx = validIdx + 1
            nums[validIdx] = num // 这里不是调换而是直接覆盖
        } else {
            // do nothing
        }
    }
    
    return validIdx + 1
}


var array = [2, 3, 4, 5]
let count = removeDuplicates(&array)
print(count, array)

/*
 原题链接：https://leetcode.com/problems/remove-duplicates-from-sorted-array
 标签：数组
 难度：Easy
 战绩：没做出来😂
 关键信息：排序数组、原地删除（in-place）、得到最终结果后不需要管超出目标长度的元素
 思路：这个问题的本质就是每个数字后面的一定比它大，因为题目要求不能分配新的空间，只能 in-place 删除，所以我们可以把这个数组分成两部分，第一部分是没有重复数字的，第二部分是待处理的或者叫被废弃的，这样一来，这个问题的解决实际上就是移位，从后面待处理的部分把符合条件的数字copy到前面的部分来。
 具体实现：用两个“指针”来标记位置，一个是作为第一部分的尾巴的标记，另一个是往后遍历用的
 总结：
   - 要审题
   - 画图
   - 举一反三（in-place 的场景， 插入排序也用到了分割数组的套路，https://github.com/ShannonChenCHN/algorithm-and-data-structure/blob/master/Algorithm/Sorting/InsertionSort.playground/Contents.swift）
   - 刷题经验和专业词汇（这类题型如果没做过的话，面试时肯定无从下手，而且可能都不知道 in-place 是什么意思）
 

 0 | 0, 1, 1, 1, 2, 2, 3, 3, 4
 ↑   ↑
 j
     i

 0 | 0, 1, 1, 1, 2, 2, 3, 3, 4
 ↑      ↑
 j
        i

 0, 1 | 1, 1, 1, 2, 2, 3, 3, 4
    ↑   ↑
    j
        i

 0, 1 | 1, 1, 1, 2, 2, 3, 3, 4
    ↑      ↑
    j
           i
  

 0, 1 | 1, 1, 1, 2, 2, 3, 3, 4
    ↑         ↑
    j
              i

 0, 1 | 1, 1, 1, 2, 2, 3, 3, 4
    ↑            ↑
    j
                 i

 0, 1, 2 | 1, 1, 2, 2, 3, 3, 4
       ↑         ↑
       j
                 i

 0, 1, 2 | 1, 1, 2, 2, 3, 3, 4
       ↑            ↑
       j
                    i
  
 0, 1, 2 | 1, 1, 2, 2, 3, 3, 4
       ↑               ↑
       j
                       i

 0, 1, 2, 3 | 1, 2, 2, 3, 3, 4
          ↑            ↑
          j
                       i

 0, 1, 2, 3 | 1, 2, 2, 3, 3, 4
          ↑               ↑
          j
                          i

 0, 1, 2, 3 | 1, 2, 2, 3, 3, 4
          ↑                  ↑
          j
                             i

 0, 1, 2, 3, 4 | 2, 2, 3, 3, 4
             ↑               ↑
             j
                             i
 
 */
 
