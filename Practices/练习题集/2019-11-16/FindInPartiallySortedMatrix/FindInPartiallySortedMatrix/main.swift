//
//  main.swift
//  FindInPartiallySortedMatrix
//
//  Created by ShannonChen on 2019/11/16.
//  Copyright © 2019 ShannonChen. All rights reserved.
//

import Foundation



/// 在一个二维数组中，每一行都按照从左到右递增的顺序排列，
/// 每一列都按照从上到下递增的顺序排列。请完成一个函数，
/// 输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。
///
/// 例如，从下面的数组中查找 7 返回 true，查找 5 返回 false。
///
/// 1    2    8    9
///
/// 2   4    9    12
///
/// 4   7    10   13
///
/// 6   8    11   15
func find(_ number: Int, in matrix: [[Int]]) -> Bool {
//    return solution_1(number: number, matrix: matrix)
    return solution_2(number: number, matrix: matrix)
}

/// 暴力穷举法
/// 时间复杂度：O(n*m)
/// 空间复杂度：O(1)
func solution_1(number: Int, matrix: [[Int]]) -> Bool {
    for subarray in matrix {
        for ele in subarray {
            if ele == number {
                return true
            }
        }
    }
    
    return false
}
 

/// 每次将输入的数字和右上角的数字比较，比它小则删掉这一列，比它大则删掉这一行
/// 时间复杂度：O(n+m)，因为 (n-1)+(m-1) 中的常量可以省略
/// 空间复杂度：O(1)
///
///举例：下面的矩阵中是否包含 7
/// ```
/// 1    2    8   [9]                1     2    [8]
///
/// 2   4    9    12                 2     4     9
///
/// 4   7    10   13                 4     7     10
///
/// 6   8    11   15                 6     8     11
///
/// -----------------------------------------------------
/// 1    [2]
///
/// 2     4            2   [4]
///
/// 4     7            4     7           4   [7]
///
/// 6     8            6     8           6   8
///
/// -------------------------------------------------------
///```
func solution_2(number: Int, matrix: [[Int]]) -> Bool {
    
    guard let firstSubarray = matrix.first else {
        return false
    }
    
    var row = 0
    var column = firstSubarray.count - 1
    while row < matrix.count, column >= 0 {
        if matrix[row][column] > number {
            column = column - 1
        } else if matrix[row][column] < number{
            row = row + 1
        } else {
            return true
        }
    }
    
    return false
}


let matrix = [[1, 2, 8, 9],
              [2, 4, 9, 12],
              [4, 7, 10, 13],
              [6, 8, 11, 15]]

print(find(7, in: matrix))  // true
print(find(5, in: matrix))  // false
print(find(10, in: matrix)) // true
print(find(20, in: matrix)) // false
