//
//  main.swift
//  RemoveElement
//
//  Created by ShannonChen on 2019/11/24.
//  Copyright © 2019 ShannonChen. All rights reserved.
//

import Foundation

/// Given an array nums and a value val, remove all instances of that value in-place and return the new length.
///
/// Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.
///
/// The order of elements can be changed. It doesn't matter what you leave beyond the new length.
///
///```
/// Example 1:
///
/// Given nums = [3,2,2,3], val = 3,
///
/// Your function should return length = 2, with the first two elements of nums being 2.
///
/// It doesn't matter what you leave beyond the returned length.
/// ```
///
/// Example 2:
/// ```
/// Given nums = [0,1,2,2,3,0,4,2], val = 2,
///
/// Your function should return length = 5, with the first five elements of nums containing 0, 1, 3, 0, and 4.
///
/// Note that the order of those five elements can be arbitrary.
///
/// It doesn't matter what values are set beyond the returned length.
/// ```
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    return solution_01(&nums, val)
}


/*
 
 nums = [0,1,2,2,3,0,4,2], val = 2
 
 [| 0, 1, 2, 2, 3, 0, 4, 2]
  ↑ ↑
  i
    j
 
 [0 | 1, 2, 2, 3, 0, 4, 2]
  ↑   ↑
  i
      j
 
 [0, 1 | 2, 2, 3, 0, 4, 2]
     ↑   ↑
     i
         j
 
 [0, 1 | 2, 2, 3, 0, 4, 2]
     ↑      ↑
     i
            j
 
 [0, 1 | 2, 2, 3, 0, 4, 2]
     ↑         ↑
     i
               j
 
 [0, 1, 3, 2, 3, 0, 4, 2]
        ↑     ↑
        i
              j
 [0, 1, 3, 2, 3, 0, 4, 2]
        ↑        ↑
        i
                 j
 
 [0, 1, 3, 0, 3, 0, 4, 2]
           ↑     ↑
           i
                 j
 
 [0, 1, 3, 0, 3, 0, 4, 2]
           ↑        ↑
           i
                    j
 
 [0, 1, 3, 0, 4, 0, 4, 2]
              ↑     ↑
              i
                    j
 
 [0, 1, 3, 0, 4, 0, 4, 2]
              ↑        ↑
              i
                       j
 
 */
func solution_01(_ nums: inout [Int], _ val: Int) -> Int {
    var i = -1
    for (_, num) in nums.enumerated() {
        if num != val {
            i = i + 1
            nums[i] = num
        } else {
           // do nothing
        }
    }
    return i + 1
}


/*

nums = [0,1,2,2,3,0,4,2], val = 2

[0, 1, 2, 2, 3, 0, 4, 2]
 ↑                    ↑
 i
                      j

[0, 1, 2, 2, 3, 0, 4, 2]
    ↑                 ↑
    i
                      j

[0, 1, 2, 2, 3, 0, 4, 2]
       ↑              ↑
       i
                      j

[0, 1, 2, 2, 3, 0, 4, 2]
       ↑              ↑
       i
                      j

[0, 1, 2, 2, 3, 0, 4, 2]
       ↑           ↑
       i
                   j

[0, 1, 4, 2, 3, 0, 4, 2]
       ↑           ↑
       i
                   j
[0, 1, 4, 2, 3, 0, 4, 2]
          ↑     ↑
          i
                j

[0, 1, 4, 0, 3, 0, 4, 2]
          ↑     ↑
          i
                j

[0, 1, 4, 0, 3, 0, 4, 2]
             ↑
             i
             j


*/
func solution_02(_ nums: inout [Int], _ val: Int) -> Int {
    var i = 0
    var j = nums.count - 1
    while i <= j {
        if nums[i] == val {
            nums[i] = nums[j]
            j = j - 1
        } else {
            i = i + 1
        }
    }
    
    return i
}


var nums = [0, 1, 2, 2, 3, 0, 4, 2]
let val = 2
let count = removeElement(&nums, val)
print(count, nums)
