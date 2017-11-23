//
//  Vertex.swift
//  Graph
//
//  Created by ShannonChen on 2017/11/23.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import Foundation


/// 顶点
public struct Vertex<T: Hashable> {
    
    public var data: T
    public let index: Int
    
    init(data: T) {
        self.init(data: data, index: 0)
    }
    
    init(data: T, index: Int) {
        self.data = data
        self.index = index
    }
}


extension Vertex: Hashable {
    
    public var hashValue: Int {
        return "\(data)".hashValue
    }
    
    public static func ==(lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        return (lhs.data == rhs.data)
    }
}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(data)"
    }
}
