//: Playground - noun: a place where people can play

import UIKit


// 创建一个 3 X 6 的二维数组
// 方式一
var cookies1 = [[Int]]()
for _ in 1...9 {
    var row = [Int]()
    for _ in 1...7 {
        row.append(0)
    }
    
    cookies1.append(row)
}

// 方式二
//var cookies = [[Int]](repeating: [Int](repeating: 0, count: 7), count: 9)

let myCookie = cookies1[3][6]



// 方式三
func dim<T>(_ count: Int, _ value: T) -> [T] {
    return [T](repeating: value, count: count)
}

var cookies2 = dim(9, dim(7, 0))

/*
  2   34  52   7
  12  34  1    6
  3   5   74  23
  7   1   4   32
*/

/// 自定义二维数组类型
public struct Array2D<T> {
    public let columnCount: Int
    public let rowCount: Int
    fileprivate var array: [T]
    
    public init(columnCount: Int, rowCount: Int, initialValue: T) {
        self.columnCount = columnCount
        self.rowCount = rowCount
        array = .init(repeating: initialValue, count: columnCount * rowCount)
    }
    
    public subscript(column: Int, row: Int) -> T {
        get {
            precondition(column < columnCount, "Column \(column) Index is out of range. Array<T>(columns: \(columnCount), rows:\(rowCount))")
            precondition(row < rowCount, "Row \(row) Index is out of range. Array<T>(columns: \(columnCount), rows:\(rowCount))")
            return array[row * columnCount + column]
        }
        
        set {
            precondition(column < columnCount, "Column \(column) Index is out of range. Array<T>(columns: \(columnCount), rows:\(rowCount))")
            precondition(row < rowCount, "Row \(row) Index is out of range. Array<T>(columns: \(columnCount), rows:\(rowCount))")
            array[row * columnCount + column] = newValue
            
        }
    }
    
}


extension Array2D: CustomStringConvertible {
    public var description: String {
        var string = ""
        for (i, element) in self.array.enumerated() {
            string.append("\(element)")
            let remainder = (i + 1) % columnCount
            if remainder == 0 {
                string.append("\n")
            }
        }
        
        return string
    }
}

var cookies3 = Array2D.init(columnCount: 9, rowCount: 7, initialValue: 0)
print(cookies3)

print(cookies3[2, 3])

