//: Playground - noun: a place where people can play

import UIKit


/**
 
 快速排序
 
 ### 基本思想：跟归并排序类似，快速排序采用的也是分而治之的思想。先选择一个基准元素,通常选择第一个元素或者最后一个元素或者中间元素，通过一趟扫描，将待排序列分成三个子数组，比基准元素小的，比基准元素大的，跟基准元素一样大的，然后再用同样的方法对划分好的子数组递归地进行划分，直到不能再分为止。划分完后，再对两两相邻的数组按照从小到大的顺序进行合并，递归执行，直到完全合并好。
 
 ### 两个讨论点：
 - 枢纽元（pivot）
 - 分割策略（Partitioning）
   - Lomuto 分割策略（详见代码部分的注释）
   - Hoare 分割策略（详见代码部分的注释）
 
 
 ### 示意图：
 https://github.com/raywenderlich/swift-algorithm-club/blob/master/Quicksort/Images/Example.png
 
 [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]
 
 1. 找基准 i = a.count/2 = 6 , n = 8
 
 分成 2 组
 less:    [ 0, 3, 2, 1, 5, -1 ]
 equal:   [ 8, 8 ]
 greater: [ 10, 9, 14, 27, 26 ]
 
 
 1.1 分解第一组，找基准 n = 1
 [ 0, 3, 2, 1, 5, -1 ]
 
 less:    [ 0, -1 ]
 equal:   [ 1 ]
 greater: [ 3, 2, 5 ]
 
 1.1.1 分解第一组的第一部分
 
 [ 0, -1 ]
 
 less:    [ ]
 equal:   [ -1 ]
 greater: [ 0 ]
 
 1.1.2 分解第一组的第二部分
 
 [ 3, 2, 5 ]
 
 less:    [ ]
 equal:   [ 2 ]
 greater: [ 3, 5 ]
 
 1.1.2.1 分解第一组的第二部分的第二部分
 
 [ 3, 5 ]
 
 less:    [ 3 ]
 equal:   [ 5 ]
 greater: [ ]
 
 1.2 分解第二组
 ......
 
 
 ### 参考：
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Quicksort
 
 */


/**
 Swift 知识点：
 
 1. In Swift, the notation (x, y) = (y, x) is a convenient way to perform a swap between the values of x and y. You can also write swap(&x, &y).
 
 */

/// 快速排序
func quicksort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else {
        print(array)
        return array
        
    }
    
    let pivot = array[array.count/2]            // 1. 选取枢纽元
    let less = array.filter { $0 < pivot }      // 2. 找出枢纽元小的元素
    let greater = array.filter { $0 > pivot }   // 3. 找出比枢纽元大的元素
    let equal = array.filter { $0 == pivot }    // 4. 找出跟枢纽元一样大的元素
    
    print(less, greater, equal)
    
    let mergedArray = quicksort(less) + equal + quicksort(greater)  // 5. 合并排好序的三部分
    
    print(mergedArray)
    
    return mergedArray
}

let list = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]
quicksort(list)
print("\n\n\n")

/*
 
 Lomuto 分割策略：
 1. 取最后一个元素作为枢纽元
 2. 从第一个元素开始，依次比较，把比 pivot 小的或者相等的元素依次放到前面
 3. 然后再把 pivot 放到“中间”来，保证后面的都是比它大的元素
 
 图中的 low 代表下面代码中的 first，high 代表 last，i 代表 lessPartIndex

 [| 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1 | 8 ]   pivot = 8
    low                                      high
    i
    j
    
    
[| 10 | 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1 | 8 ]       将 0 和 10 互换
  low                                        high
   i
       j
       
[ 0 | 10 | 3, 9, 2, 14, 26, 27, 1, 5, 8, -1 | 8 ]       将 3 和 10 互换
 low                                         high
      i
           j
           
           
[ 0, 3 | 10 | 9, 2, 14, 26, 27, 1, 5, 8, -1 | 8 ]       9 比 8 大，不需要和 10 互换
 low                                         high
         i
             j
             
             
[ 0, 3 | 10, 9 | 2, 14, 26, 27, 1, 5, 8, -1 | 8 ]       将 2 和 10 互换
 low                                         high
         i
                 j
 
 以此类推，直到把比枢纽元大的都放到最前面来
 
                 
[ 0, 3, 2, 1, 5, 8, -1 | 27, 9, 10, 14, 26 | 8 ]
 low                                        high
                         i                   j
                         

最后再将枢纽元放到中间来
 
[ 0, 3, 2, 1, 5, 8, -1 | 8 | 9, 10, 14, 26, 27 ]    pivotIndex = 7
 low                                       high
                         i                  j
 
 然后再接着下一回合的分割，直到最小单元为 1
 
 */


func partitionLomuto<T: Comparable>(_ a: inout [T], first: Int, last: Int) -> Int {
    let pivot = a[last]  // 取最后一个元素作为枢纽元
    
    // 从第一个元素开始，依次比较，把比 pivot 小的或者相等的元素依次放到前面
    var lessPartIndex = first
    for j in first..<last {
        if a[j] <= pivot {
            (a[lessPartIndex], a[j]) = (a[j], a[lessPartIndex])
            print(lessPartIndex, a)
            
            lessPartIndex += 1
        }
    }
    
    // 然后再把 pivot 放到“中间”来，保证后面的都是比它大的元素
    (a[lessPartIndex], a[last]) = (a[last], a[lessPartIndex])
    print(lessPartIndex, a)
    
    return lessPartIndex
}

func quicksortLomuto<T: Comparable>(_ a: inout [T], first: Int, last: Int) {
    if first < last {
        let pivotIndex = partitionLomuto(&a, first: first, last: last)
        quicksortLomuto(&a, first: first, last: pivotIndex - 1)
        quicksortLomuto(&a, first: pivotIndex + 1, last: last)
    }
}

var anotherList = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]
quicksortLomuto(&anotherList, first: 0, last: anotherList.count - 1)

print(anotherList)
print("\n\n\n")



/*
 
 Hoare 分割策略：
 
 1. 取第一个为枢纽元
 2. 依次从最左边向右开始找找到比枢纽元大的，同时依次从最右边向左开始找找到比枢纽元小的
 3. 找到右侧比枢纽元小或者相等的位置（leftIndex）和左侧比枢纽元大或者相等的位置（rightIndex）之后，再进行互换
 4. 以此类推，直到 leftIndex 和 rightIndex 重合
 
 图中的 low 代表下面代码中的 first，high 代表 last，i 代表 leftIndex， j 代表 rightIndex
 
 [| 8, 0, 3, 9, 2, 14, 10, 27, 1, 5, 8, -1, 26 |]
   low                                     high
   i                                        j
 
 [| 8, 0, 3, 9, 2, 14, 10, 27, 1, 5, 8, -1 | 26 ]      将 -1 和 8 互换
  low                                       high
    i                                    j
 
 [-1, 0, 3 | 9, 2, 14, 10, 27, 1, 5, 8 | 8, 26 ]       将 9 和 8 互换
  low                                       high
             i                       j
 
 [-1, 0, 3, 8, 2 | 14, 10, 27, 1, 5 | 9, 8, 26 ]       将 14 和 5 互换
 low                                       high
                    i             j
 
 
 [-1, 0, 3, 8, 2, 5 | 10, 27, 1 | 14, 9, 8, 26 ]       将 10 和 1 互换
 low                                       high
                      i       j
 
 
 [-1, 0, 3, 8, 2, 5, 1 | 27 | 10, 14, 9, 8, 26 ]       i 和 j 重合了，该回合结束，pivotIndex = 7
 low                                       high
                         i
                         j
 
 然后再接着下一回合的分割，直到最小单元为 1
 
 */

func quicksortHoare<T: Comparable>(_ array: inout [T], first: Int, last: Int) {
    if first < last {
        let pivotIndex = partitionHoare(&array, first: first, last: last)
        quicksortHoare(&array, first: first, last: pivotIndex)
        quicksortHoare(&array, first: pivotIndex + 1, last: last)
    }
}

func partitionHoare<T: Comparable>(_ array: inout [T], first: Int, last: Int) -> Int {
    let pivot = array[first]    // 取第一个为枢纽元
    var leftIndex = first - 1   // 从最左边开始找找到比枢纽元大的
    var rightIndex = last + 1   // 从最右边开始找找到比枢纽元小的
    
    while true {
        repeat { rightIndex -= 1 } while array[rightIndex] > pivot   // 找到右侧比枢纽元小或者相等的位置
        repeat { leftIndex += 1 } while array[leftIndex] < pivot     // 找到左侧比枢纽元大或者相等的位置
        print(leftIndex, array[leftIndex], rightIndex, array[rightIndex])
        
        if leftIndex < rightIndex {
            // 如果左右索引位置合法，也就是 leftIndex 一定比 rightIndex 小
            // 替换左右两侧需要移动的两个元素
            array.swapAt(leftIndex, rightIndex)
            print(array)
        } else {
            return rightIndex
        }
    }
}




var list2 = [ 8, 0, 3, 9, 2, 14, 10, 27, 1, 5, 8, -1, 26 ]
quicksortHoare(&list2, first: 0, last: list2.count - 1)


// MARK: - Randomized sort

/* Returns a random integer in the range min...max, inclusive. */
public func random(min: Int, max: Int) -> Int {
    assert(min < max)
    return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}

/*
 Uses a random pivot index. On average, this results in a well-balanced split
 of the input array.
 */
func quicksortRandom<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        // Create a random pivot index in the range [low...high].
        let pivotIndex = random(min: low, max: high)
        
        // Because the Lomuto scheme expects a[high] to be the pivot entry, swap
        // a[pivotIndex] with a[high] to put the pivot element at the end.
        (a[pivotIndex], a[high]) = (a[high], a[pivotIndex])
        
        let p = partitionLomuto(&a, first: low, last: high)
        quicksortRandom(&a, low: low, high: p - 1)
        quicksortRandom(&a, low: p + 1, high: high)
    }
}


// MARK: - Dutch national flag partitioning

/*
 Dutch national flag partitioning
 
 Partitions the array into three sections: all element smaller than the pivot,
 all elements equal to the pivot, and all larger elements.
 
 This makes for a more efficient Quicksort if the array contains many duplicate
 elements.
 
 Returns a tuple with the start and end index of the middle area. For example,
 on [0,1,2,3,3,3,4,5] it returns (3, 5). Note: These indices are relative to 0,
 not to "low"!
 
 The number of occurrences of the pivot is: result.1 - result.0 + 1
 
 Time complexity is O(n), space complexity is O(1).
 */


func quicksortDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let pivotIndex = random(min: low, max: high)
        let (p, q) = partitionDutchFlag(&a, low: low, high: high, pivotIndex: pivotIndex)
        quicksortDutchFlag(&a, low: low, high: p - 1)
        quicksortDutchFlag(&a, low: q + 1, high: high)
    }
}


func partitionDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int, pivotIndex: Int) -> (Int, Int) {
    let pivot = a[pivotIndex]
    
    var smaller = low
    var equal = low
    var larger = high
    
    // This loop partitions the array into four (possibly empty) regions:
    //   [low    ...smaller-1] contains all values < pivot,
    //   [smaller...  equal-1] contains all values == pivot,
    //   [equal  ...   larger] contains all values > pivot,
    //   [larger ...     high] are values we haven't looked at yet.
    while equal <= larger {
        if a[equal] < pivot {
            swap(&a, smaller, equal)
            smaller += 1
            equal += 1
        } else if a[equal] == pivot {
            equal += 1
        } else {
            swap(&a, equal, larger)
            larger -= 1
        }
    }
    return (smaller, larger)
}

/*
 Swift's swap() doesn't like it if the items you're trying to swap refer to
 the same memory location. This little wrapper simply ignores such swaps.
 */
public func swap<T>(_ a: inout [T], _ i: Int, _ j: Int) {
    if i != j {
        a.swapAt(i, j)
    }
}
