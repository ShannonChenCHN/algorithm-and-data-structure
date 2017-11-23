//
//  Edge.swift
//  Graph
//
//  Created by ShannonChen on 2017/11/23.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import Foundation

public enum EdgeType {
    case directed, undirected
}

/// 边
public struct Edge<T: Hashable> {
    
    public let source: Vertex<T>
    public let destination: Vertex<T>
    
    public let weight: Double? // 权重作为可选属性
    
}


extension Edge: Hashable {
    
    public var hashValue: Int {
        var string = "\(source.description)\(destination.description)"
        if weight != nil {
            string.append("\(weight!)")
        }
        return string.hashValue
    }
    
    public static func ==(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return (lhs.source == rhs.source &&
                lhs.destination == rhs.destination &&
                lhs.weight == rhs.weight)
    }
}
