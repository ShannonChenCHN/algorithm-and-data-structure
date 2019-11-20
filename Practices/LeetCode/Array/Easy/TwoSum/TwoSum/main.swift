//
//  main.swift
//  TwoSum
//
//  Created by ShannonChen on 2019/11/20.
//  Copyright © 2019 ShannonChen. All rights reserved.
//

import Foundation


/// Given an array of integers, return indices of the two numbers such that they add up to a specific target.
///
/// You may assume that each input would have exactly one solution, and you may not use the same element twice.
///
/// Example:
/// ```
/// Given nums = [2, 7, 11, 15], target = 9,
///
/// Because nums[0] + nums[1] = 2 + 7 = 9,
/// return [0, 1].
/// ```
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
//    return solution_01(nums, target)
    return solution_02(nums, target)
}

/// 暴力解法
/// 时间复杂度：O(n^2)
/// 空间复杂度：O(1)
func solution_01(_ nums: [Int], _ target: Int) -> [Int] {
    for idx in 0..<(nums.count-1) {
        for nextIdx in (idx+1)..<nums.count {
            if nums[idx] + nums[nextIdx] == target {
                return [idx, nextIdx]
            }
        }
    }
    return []
}

/// 哈希表解法
/// 时间复杂度：O(n)
/// 空间复杂度：O(n)
func solution_02(_ nums: [Int], _ target: Int) -> [Int] {
    var dic: [Int: Int] = [:]
    for (index, num) in nums.enumerated() {
        let anotherNum = target - num
        if let idxOfAnotherNum = dic[anotherNum] {
            return [idxOfAnotherNum, index]
        } else {
            dic[num] = index
        }
    }
    return []
}


let nums = [2, 7, 11, 15]
let target = 9
print(twoSum(nums, target))


/// 标签：数组
/// 难度：Easy
/// 成绩：只想到了暴力解法
/// 总结：问题的本质是查找；哈希表
