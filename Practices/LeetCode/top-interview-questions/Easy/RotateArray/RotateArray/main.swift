//
//  main.swift
//  RotateArray
//
//  Created by ShannonChen on 2019/12/14.
//  Copyright © 2019 ShannonChen. All rights reserved.
//

import Foundation

/// Given an array, rotate the array to the right by k steps, where k is non-negative.
///
/// Example 1:
///
/// ```
/// Input: [1,2,3,4,5,6,7] and k = 3
/// Output: [5,6,7,1,2,3,4]
/// Explanation:
/// rotate 1 steps to the right: [7,1,2,3,4,5,6]
/// rotate 2 steps to the right: [6,7,1,2,3,4,5]
/// rotate 3 steps to the right: [5,6,7,1,2,3,4]
/// ```
///
/// Example 2:
/// ```
/// Input: [-1,-100,3,99] and k = 2
/// Output: [3,99,-1,-100]
/// Explanation:
/// rotate 1 steps to the right: [99,-1,-100,3]
/// rotate 2 steps to the right: [3,99,-1,-100]
/// ```
/// - Note:
///   - Try to come up as many solutions as you can, there are at least 3 different ways to solve this problem.
///   - Could you do it in-place with O(1) extra space?
func rotate(_ nums: inout [Int], _ k: Int) {
    solution_03(&nums, k)
}


/// 方法一：暴力法，具体思路就是把“将最后一个元素移到最前面”这个“动作”执行 k 次
/// 时间复杂度：O(n*k)，空间复杂度：O(1)
///
/// 复盘：
/// 1. `for step in 1...k` 中的 step 可以省略
/// 2. guard 语句中的条件判断写反了
/// 3. `while i >= 0` 写成了 `while i > 0`
/// 4. 最后发现 k steps 还是理解错了，比如输入 `[2, 1], k = 3` 的 case，最终结果是 `[1, 2]`，也就是说 k 可以比数组大
func solution_01(_ nums: inout [Int], _ k: Int) {
    guard nums.count > 1 && k > 0 else {
        return
    }
    
    for _ in 1...k {
        let lastEle = nums.last!
        var i = nums.count - 2
        while i >= 0 {
            nums[i + 1] = nums[i]
            i = i - 1
        }
        nums[0] = lastEle
    }
}

/// 方法二：反转法
/// 具体思路如下：
/// 输入 `[1, 2, 3, 4, 5, 6]`，k = 3
///
/// 第一步，先反转整个数组             `[6, 5, 4, 3, 2, 1]`
/// 第二步，然后再反转前 k 个数字 `[4, 5, 6, 3, 2, 1]`
/// 第三步，反转后面剩余的数字     `[4, 5, 6, 1, 2, 3]`
///
/// 这里的关键在于理解：**当我们旋转数组 k 次， k%n 个尾部元素会被移动到头部，剩下的元素会被向后移动。**
///
/// 时间复杂度：O(n)，空间复杂度：O(1)
///

/// 优化前
func solution_02_1(_ nums: inout [Int], _ k: Int) {
    guard nums.count > 1 && k > 0 else { // 又忘记写 else
        return
    }
    
    // 需要特殊考虑实际上不需要旋转的情况
    if k % nums.count == 0 {
        return
    }
    
    func reverse(startIndex: Int, endIndex: Int) {
        let midIndex = startIndex + (endIndex - startIndex) / 2
        for i in startIndex...midIndex {
            let exchangeIndex = startIndex + (endIndex - startIndex) - (i - startIndex)
            let temp = nums[i]
            nums[i] = nums[exchangeIndex]
            nums[exchangeIndex] = temp
        }
    }
    
    reverse(startIndex: 0, endIndex: nums.count - 1)
    reverse(startIndex: 0, endIndex:k % nums.count - 1)
    reverse(startIndex: k % nums.count, endIndex:nums.count - 1)
}

/// 参考官方解答优化后
func solution_02_2(_ nums: inout [Int], _ k: Int) {
    // 定义反转函数
    func reverse(startIndex: Int, endIndex: Int) {
        var start = startIndex
        var end = endIndex
        while start < end { // 这个 while 循环用的很经典，值得学习
            let temp = nums[start]
            nums[start] = nums[end]
            nums[end] = temp
            
            start = start + 1
            end = end - 1
        }
    }
    
    // 第一步，简化 k 值，这样就不用再考虑 k 超过数组长度的情况了
    let step = k % nums.count
    
    // 第二步，旋转数组
    reverse(startIndex: 0, endIndex: nums.count - 1)
    reverse(startIndex: 0, endIndex: step - 1)
    reverse(startIndex: step, endIndex: nums.count - 1)
}

/// 方法三：使用额外的数组
/// 具体思路：跟方法二类似，我们是基于这个事实——**当我们旋转数组 k 次， k%n 个尾部元素会被移动到头部，剩下的元素会被向后移动。**所以我们可以借助一个新数组，来保存最终形态，最后再复制到原数组中
///
/// 输入数组 a  = `[1, 2, 3, 4, 5, 6, 7]`，k = 3
/// 创建一个大小相同的空数组 b
/// b[0] = a[4]  4  =  7 - 3
/// b[1] = a[5]  5  =  7 - 3 + 1
/// b[2] = a[6]  6  =  7 - 3 + 2
/// b[3] = a[0]  0 = 7 % 7
/// b[4] = a[1]  1 =  8%7
/// b[5] = a[2]  2 = 9%7
/// b[6] = a[3]  3 = 10%7
/// 规律：b[i] = a[(n-k+i )% 6]
func solution_03(_ nums: inout [Int], _ k: Int) {
    let step = k % nums.count  // 一定要考虑 k 大于数组大小的情况
    var temArray: [Int] = Array.init(repeating: 0, count: nums.count) // 初始时创建大小为 n 的数组
    for i in 0..<nums.count {
        temArray[i] = nums[(nums.count - step + i) % nums.count]
    }
    
    for i in 0..<nums.count {
        nums[i] = temArray[i]
    }
}

/// 方法四：环状替换
/// 具体思路：旋转 k 次的结果是k%n 个尾部元素会被移动到头部，剩下的元素会被向后移动。所以我们可以想象成同学换座位，把元素看做同学，
/// 把下标看做座位，大家换座位。第一个同学离开座位去第k+1个座位，第k+1个座位的同学被挤出去了，他就去坐他后k个座位，
/// 如此反复。但是会出现一种情况，就是其中一个同学被挤开之后，坐到了第一个同学的位置（空位置，没人被挤出来），
/// 但是此时还有人没有调换位置，这样就顺着让第二个同学换位置。
/// 那么什么时候就可以保证每个同学都换完了呢？n个同学，换n次，所以用一个count来计数即可。
///
///
func solution_04(_ nums: inout [Int], _ k: Int) {
    
//    var step = k % nums.count
//    var count = 0
//    var start = 0
//    while count < nums.count { // n 个同学加起来肯定要换 n 次座位
//
//        var end = -1
//        while start != end {
//            let temp = nums[start]
//            nums[start] = nums[nums.count - step]
//            nums[]
//            count = count + 1
//        }
//        start = start + 1
//    }
}

//var nums = [1, 2, 3, 4, 5, 6, 7]
var nums = [1, 2]
rotate(&nums, 3)
print(nums)

/**
 总结：
 一开始没理解旋转 k 步是啥意思，被题目中的例子给误解了，还以为是必须要先经过中间的 k 步
 所以这个题目的关键是理解旋转数组的概念，最后可以总结出来一个定律：
      **当我们旋转数组 k 次， `k%n` 个尾部元素会被移动到头部，剩下的元素会被向后移动。**
 为什么是 k%n？
 因为如果数组大小大于 k，那就是 k 次；如果数组大小小于 k，比如 [1 ,2] 旋转1、3、5、7、9... 次，都是 1 次的效果
 */

