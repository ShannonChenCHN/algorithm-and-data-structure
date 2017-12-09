//: Playground - noun: a place where people can play

import UIKit

/*
 归并排序
 
 ### 基本思想：归并（Merge）排序法应用了分而治之的思想，把待排序列表分为若干个子列表，然后对每个子序列进行排序，再把排好序的子列表合并为整体有序列表。
 
 复杂度：O(n log n)
 
 ### 实现方式一 ：Top-down implementation
 
 基本思路：使用递归的方式，先一步步分解，然后再合并
 
 示意图：
 
 [14, 8, 32, 17, 5, 41, 9]
 
           分解                          排序                    合并
[14, 8, 32, 17, 5, 41, 9]                ->          [5, 8, 9, 14, 17, 32, 41]
 
            ↓                                                   ↑
 
 [14, 8, 32], [17, 5, 41, 9]             ->          [8, 14, 32], [5, 9, 17, 41]
 
            ↓                                                   ↑
 
 [14], [8, 32], [17, 5], [41, 9]         ->        [14], [8, 32], [5, 17], [9, 41]
 
            ↓                                                   ↑
 
 [14], [8], [32], [17], [5], [41], [9]   ->      [14], [8], [32], [17], [5], [41], [9]
 
 
 实现方式二：Bottom-up implementation
 
 基本思路： 不需要分解，直接从最小的粒度 1 开始，对相邻两组进行合并排序，一轮执行完后再进行更大粒度（乘以2）的合并排序，照此循环，直到全部都排序完毕。
 
 示意图：
 
 [14, 8, 32, 17, 5, 41, 9]
 
 复制元素到两个 pile 中:
           [14, 8, 32, 17, 5, 41, 9]              [14, 8, 32, 17, 5, 41, 9]
 
 开始排序：
 第一轮：   [14] [8] [32] [17] [5] [41] [9]   ->   [8, 14] [17, 32] [5, 41] [9]

 第二轮：   [8, 14, 17, 32] [5, 9, 41]        <-   [8, 14] [17, 32] [5, 41] [9]
 
 第三轮：   [8, 14, 17, 32] [5, 9, 41]        ->   [5, 8, 9, 14, 17, 32, 41]
 
 结果：                                            [5, 8, 9, 14, 17, 32, 41]
 
 ### 参考
 
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Merge%20Sort
 
 
 
 */

/**
 
 Swift 知识点
 
 1. C-style for statement is deprecated in Swift 3.0
 https://www.natashatherobot.com/swift-alternatives-to-c-style-for-loops/
 https://stackoverflow.com/questions/36173379/warning-c-style-for-statement-is-deprecated-and-will-be-removed-in-a-future-ve
 
 for var i = 0; i < 5; i+=1 {
 }
 
 变成了：
 
 for i in stride(from: 0, to: 5, by: 1){
 
 }
 
 
 for var i = 0; i <= 5; i+=1 {
 }
 
 变成了：
 
 for i in stride(from: 0, through: 5, by: 1){
 
 }
 
 */

func merge(leftPile: [Int], rightPile: [Int]) -> [Int] {
  
    var leftIndex = 0
    var rightIndex = 0
    
   
    var orderedPile = [Int]()
    
    // 左右比较，直到一边的数组都空，哪个小就取出哪个
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        
        if leftPile[leftIndex] < rightPile[rightIndex] {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
            
        } else if leftPile[leftIndex] > rightPile[rightIndex] {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
            
        } else {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }
   
    // 取出剩余的数字
    while leftIndex < leftPile.count {
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < rightPile.count {
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
    }
    
    return orderedPile
}

// Top-down implementation
func mergeSortTopDown(_ array: [Int]) -> [Int] {
    guard array.count > 1 else {
        print("->" + "\(array)")
        return array
        
    }
    
    let middleIndex = array.count / 2
    
    let leftArray = mergeSortTopDown(Array(array[0..<middleIndex]))
    
    let rightArray = mergeSortTopDown(Array(array[middleIndex..<array.count]))
    
    let mergedArray = merge(leftPile: leftArray, rightPile: rightArray)
    
    print(leftArray, rightArray)
    
    print("->" + "\(mergedArray)")
    
    return mergedArray
}

let array = [14, 8, 32, 17, 5, 41, 9]
mergeSortTopDown(array)



// Bottom-up implementation
func mergeSortBottomUp<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    
    // 1，分成两个数组，一个用来读（z[d]），另一个用来写（z[1 - d]），也就是 double-buffering
    // 相比 up-down 方式每次合并时都要一个新数组，这里我们总共只需要两个数组，更节省空间
    var piles = [array, array]
    
    var d = 0
    
    var width = 1
    while width < array.count {   // 2，pile 的宽度，从 1 开始，每循环一次大小乘以2
        
        let readingPileIndex = d
        let writingPileIndex = 1 - d
        

        // 3，依次将相邻的两个小集合合并成更大的集合
        for i in stride(from: 0, to: array.count, by: width * 2) {
            
            var currentIndex = i
            var leftIndex = i
            var rightIndex = i + width
            
            let leftArrayBound = min(leftIndex + width, array.count)  // 左侧数组的最大索引
            let rightArrayBound = min(rightIndex + width, array.count)  // 右侧数组的最大索引
            
            // 4. 比较大小，按照从小到大的顺序将两个数组中的数字转移到 buffer 中去
            while leftIndex < leftArrayBound && rightIndex < rightArrayBound {   
                
                if isOrderedBefore(piles[readingPileIndex][leftIndex], piles[readingPileIndex][rightIndex]) {
                    
                    piles[writingPileIndex][currentIndex] = piles[readingPileIndex][leftIndex]
                    leftIndex += 1
                    
                } else {
                    piles[writingPileIndex][currentIndex] = piles[readingPileIndex][rightIndex]
                    rightIndex += 1
                }
                currentIndex += 1
            }
            while leftIndex < leftArrayBound {
                piles[writingPileIndex][currentIndex] = piles[readingPileIndex][leftIndex]
                currentIndex += 1
                leftIndex += 1
            }
            while rightIndex < rightArrayBound {
                piles[writingPileIndex][currentIndex] = piles[readingPileIndex][rightIndex]
                currentIndex += 1
                rightIndex += 1
            }
        }
        
        print(piles[writingPileIndex])
        
        width *= 2
        d = 1 - d      // 5，切换两个 pile 数组（读<->写），上一回合用来读的这次用来写
    }
    
    return piles[d]
}

mergeSortBottomUp(array, <)
