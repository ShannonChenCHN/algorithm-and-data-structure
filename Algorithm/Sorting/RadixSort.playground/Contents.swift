//: Playground - noun: a place where people can play

import UIKit

/**
 
 基数排序
 
 
 基本思想：将所有待比较数值（正整数）统一为同样的数位长度，数位较短的数前面补零。然后，从最低位开始，依次进行一次排序。这样从最低位排序一直到最高位排序完成以后,数列就变成一个有序序列。
 
 
 
 示意图：
 
 个位排序:
 
 170, 90, 802, 2, 24, 45, 75, 66
 
 十位排序:
 
 802, 2, 24, 45, 66, 170, 75, 90
 
 百位排序:
 
 2, 24, 45, 66, 75, 90, 170, 802
 
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Radix%20Sort
 https://www.cnblogs.com/Braveliu/archive/2013/01/21/2870201.html
 https://baike.baidu.com/item/基数排序/7875498?fr=aladdin
 
 */

/**
 Swift 相关知识
 
 
 1. 次方
 pow() 函数
 
 2. 将 Decimal 转成 Int
 https://webcache.googleusercontent.com/search?q=cache:oN7cMgvEeM4J:https://stackoverflow.com/questions/39731265/swift-3-decimal-to-int+&cd=3&hl=zh-CN&ct=clnk&gl=us
 3. inout
 
 */


/// 找最大值
func findMaxNum(_ list: [Int]) -> Int? {
    guard list.count > 0 else {
        return nil
    }
    
    var max = list[0]
    for i in 1..<list.count {
        if list[i] > max {
            max = list[i]
        }
    }
    
    return max
}

/// 获取位数
func getDigitsCount(of num: Int) -> Int {
    
    var count = 0
    var tempDigits = num // 剩余位数
    while tempDigits > 0 {
        
        tempDigits = tempDigits / 10
        
        count += 1
    }
    
    return count
}


/// 根据指定位进行排序
func sort(_ list: inout [Int], digit: Int) {
    //求桶的index的除数
    //如798个位桶index=(798/1)%10=8
    //十位桶index=(798/10)%10=9
    //百位桶index=(798/100)%10=7
    //tempNum为上式中的1、10、100
    
    // 10 的 n 次方
    let tempNum = NSDecimalNumber.init(decimal: pow(10, digit)).intValue
    
    // 放到10个桶中
    let bucketsCount = 10
    let bucketCapacity = list.count
    var buckets = [[Int?]]()
    for _ in 0..<bucketsCount {
        let row = [Int?].init(repeating: nil, count: bucketCapacity)
        buckets.append(row)
    }
    
    // 取每个数字指定位的对应的桶
    // 0  [...]
    // 1  [...]
    // 2  [...]
    // 3  [...]
    // ...
    // 9  [...]
    for (_, element) in list.enumerated() {

        let rowIndex = Int(element / tempNum % 10) // 取这一位的数值

        // 找到这一位的桶里面的空位置
        for j in 0..<bucketCapacity {
            if buckets[rowIndex][j] == nil {
                buckets[rowIndex][j] = element
                break
            }
        }
    }

    // 将桶中的数，倒回到原有数组中
    var array = [Int]()
    for i in 0..<bucketsCount {
        for j in 0..<bucketCapacity {
            if let element = buckets[i][j] {
                array.append(element)
            }
        }
    }


    list = array
}

func radixSort(_ list: inout [Int]) {
    
    
    // 1. 找最大值
    let maxNumber = findMaxNum(list)
    
    guard let maxNum = maxNumber else {
        return
    }
    
    // 2. 获取最大数的位数
    let maxDigit = getDigitsCount(of: maxNum)
    
    // 3. 根据每一位进行排序
    for i in 0..<maxDigit {
        sort(&list, digit: i)
        print(list)
    }

}

var array = [170, 45, 75, 90, 802, 24, 2, 66]
radixSort(&array)


