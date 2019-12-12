//
//  main.swift
//  searchInsert
//
//  Created by ShannonChen on 2019/11/25.
//  Copyright © 2019 ShannonChen. All rights reserved.
//

import Foundation

/// https://leetcode.com/problems/search-insert-position/
/// Given a sorted array and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.
///
/// You may assume no duplicates in the array.
///
/// Example 1:
///
/// ```
/// Input: [1,3,5,6], 5
/// Output: 2
/// ```
/// Example 2:
///
/// ```
/// Input: [1,3,5,6], 2
/// Output: 1
/// ```
/// Example 3:
///
/// ```
/// Input: [1,3,5,6], 7
/// Output: 4
/// ```
/// Example 4:
///
/// ```
/// Input: [1,3,5,6], 0
/// Output: 0
/// ```
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
//    return solution_01(nums, target)
    return solution_02(nums, target)
}

/// 顺序查找
/// 时间复杂度：O(n)
/// 空间复杂度：O(1)
func solution_01(_ nums: [Int], _ target: Int) -> Int {
    for (idx, num) in nums.enumerated() {
        if num >= target {
            return idx
        }
    }
    
    return nums.count
}



/*
 
 思路：因为数组是排好序的，要查找指定的数字，可以用二分法
 
 [1,3,5,6,8,10]     查找 5
 
 [1,3,5]  [6,8,10]  5 在左半部分
 
 [1]      [3,5]     5 在右半部分
 
 [3]      [5]       5 在右半部分
 
 总结：二分查找的模板要记下来，遇到排序数组查找的题目马上就能想到用二分法，画图很重要，要写 case 自测
 */
/// 二分查找
/// 时间复杂度：O(logN)，空间复杂度：O(1)
func solution_02(_ nums: [Int], _ target: Int) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    
    
    var startIndex = 0
    var endIndex = nums.count - 1
    while startIndex < endIndex { // 每次写 while 语句时都要考虑下会不会死循环
        let midIndex = startIndex + (endIndex - startIndex) / 2 // 取左侧的中位数
        
        if nums[midIndex + 1] > target { // 在左半部分
            endIndex = midIndex
        } else { // 在右半部分
            startIndex = midIndex + 1
        }
    }
    
    if target == nums[endIndex] {
        return endIndex
    } else {
        if target < nums.first! {
            return 0
        } else {
            return endIndex + 1
        }
        
    }
}


let nums = [1,3,5,6,8,10]

print(searchInsert(nums, 0)) // 0
print(searchInsert(nums, 1)) // 0
print(searchInsert(nums, 2)) // 1
print(searchInsert(nums, 3)) // 1
print(searchInsert(nums, 10)) // 5
print(searchInsert(nums, 11)) // 6
