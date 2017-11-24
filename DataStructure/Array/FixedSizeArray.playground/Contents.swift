//: Playground - noun: a place where people can play

import UIKit


/*
静态数组和动态数组
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Fixed%20Size%20Array
 https://baike.baidu.com/item/C语言动态数组/4157073#2
 
 静态数组：容量大小在一创建时就确定的
 C 语言中的数组就是静态数组，Objective-C 中的 NSArray 也是静态数组。
 
 动态数组：是相对于静态数组而言的，动态数组在声明时没有确定数组大小的数组，即忽略方括号中的下标；当要用它时，可随时用ReDim语句（C语言中用malloc语句）重新指出数组的大小。使用动态数组的优点是可以根据用户需要，有效利用存储空间。
 C 语言中需要使用 malloc 相关函数来实现动态数组，C++ 中的动态数组有 `std::vector`，Objective-C 中有 `NSMutableArray`
 
 静态数组和动态数组的区别：
 静态数组的长度是预先定义好的，在整个程序中，一旦给定大小后就无法改变。而动态数组则不然，它可以随程序需要而重新指定大小。动态数组的内存空间是从堆（heap）上分配（即动态分配）的。是通过执行代码而为其分配存储空间。当程序执行到这些语句时，才为其分配。
 动态数组需要程序员自己负责释放内存，静态数组则不需要。
 

 当你提前知道所需数组的最大容量以及不需要排序时，静态数组是一个不错的解决方案。
 
 */



/// 不需要考虑顺序的静态数组
struct FixedSizeArray<T> {
    private var maxSize: Int
    private var defaultValue: T
    private var array: [T]
    private (set) var count = 0
    
    init(maxSize: Int, defaultValue: T) {
        self.maxSize = maxSize
        self.defaultValue = defaultValue
        self.array = [T](repeating: defaultValue, count: maxSize)
    }
    
    subscript(index: Int) -> T {
        assert(index >= 0)
        assert(index < count)
        return array[index]
    }
    
    mutating func append(_ newElement: T) {
        assert(count < maxSize)
        array[count] = newElement
        count += 1
    }
    
    // 移除元素时，将最后一个元素移到这个指定 index 的位置，然后在将最后一个位置的内容重置
    mutating func removeAt(index: Int) -> T {
        assert(index >= 0)
        assert(index < count)
        count -= 1
        let result = array[index]
        array[index] = array[count]
        array[count] = defaultValue
        return result
    }
    
    
    mutating func removeAll() {
        for i in 0..<count {
            array[i] = defaultValue
        }
        count = 0
    }
}


var a = FixedSizeArray(maxSize: 10, defaultValue: 0)
