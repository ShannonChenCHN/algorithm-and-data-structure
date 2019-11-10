//
//  main.swift
//  DuplicationInArray
//
//  Created by ShannonChen on 2019/11/9.
//  Copyright © 2019 ShannonChen. All rights reserved.
//

import Foundation

/// 方案一：遍历数组，用一个字典把每个值都存下了，如果发现字典中已经有了，说明重复了
/// 时间复杂度：O(n), 空间复杂度：O(n)
func solution1(integerArray: Array<Int>) -> Int? {
    var result: Int? = nil
    
    var tmpDictionary: [Int: Int] = [:]
    for integer in integerArray {
        if tmpDictionary.keys.contains(integer) {
            result = integer
            break
        } else {
            tmpDictionary[integer] = integer
        }
    }
    return result
}

/// 方案二：二分法
/// 时间复杂度：O(nlogn)，因为二分的时间复杂度是 O(logn)，闭包 countInRange 的时间复杂度是 O(n)
/// 空间复杂度：O(1)
/// 比如 {2, 3, 5, 4, 3, 2, 6, 7}
/// {1, 2, 3, 4, 5, 6, 7}
/// 先分成两份：1~4 有 5 个，说明 1~4 有重复的
/// 然后再分：1~2 有 2 个，说明 3~4 有重复的
/// 然后再继续分：3 有 2 个，说明 3 是重复的
/// 最后只剩下一个 3 了，不能再分了，发现 3 确实是重复的
func solution2(integerArray: Array<Int>) -> Int? {
    var result: Int? = nil
    
    /// 记录数组中处于给定范围大小的元素的个数
    func countInRange(min: Int, max: Int) -> Int {
        var count = 0
        for integer in integerArray {
            if integer >= min, integer <= max {
                count = count + 1
            }
        }
        return count
    }
    
    var startNum = 1
    var endNum = integerArray.count - 1
    while startNum <= endNum {
        // 二分
        let middleNum = (endNum - startNum) / 2 + startNum
        print(startNum, middleNum, endNum)
        // 判断前半部分范围的数字出现的次数
        let countInFirtHalfRange = countInRange(min: startNum, max: middleNum)
        
        // 只剩 1 个数字范围的时候，不能再分了
        if startNum == middleNum {
            if countInFirtHalfRange > 1 {
                result = startNum
            }
            break
        }
        
        if countInFirtHalfRange > (middleNum - startNum + 1) {
            endNum = middleNum
        } else {
            startNum = middleNum + 1
        }
    }
    
    return result
}


/// 从一个长度为 n+1，且所有元素大小都在 1~n 范围内的数组中，
/// 在不修改数组的前提下，找出任意重复的数字。比如，输入一个
/// 长度为 8 的数组 {2, 3, 5, 4, 3, 2, 6, 7}，那么结果应该是重复数字 2 或者 3。
func findDuplication(in integerArray: Array<Int>) -> Int? {
    if integerArray.isEmpty {
        return nil
    }
//    return solution1(integerArray: integerArray)
    return solution2(integerArray: integerArray)
}


let array = [2, 3, 5, 4, 3, 2, 6, 7]
let result = findDuplication(in: array)
print(result ?? -1)
