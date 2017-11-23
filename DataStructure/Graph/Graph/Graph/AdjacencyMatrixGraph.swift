//
//  AdjacencyMatrixGraph.swift
//  Graph
//
//  Created by ShannonChen on 2017/11/23.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import Foundation

/*
 
 
      A    B     C     D
 
  A       4.5    5.2
 
  B       1.2          7.8
 
  C  2.5  3.5          5.6
 
  D              3.3
 
 
 */

/// 邻接矩阵
open class AdjacencyMatrixGraph<T: Hashable> {
    
    // 如果 adjacencyMatrix[row][column] 不为空，那么从 vertex i 到 vertex j 就会有一条边
    fileprivate var adjacencyMatrix: [[Double?]] = []   // edge 矩阵
    public var vertices: [Vertex<T>] = []               // 顶点列表
    
    public init() {}
}


extension AdjacencyMatrixGraph: Graphable {
    public typealias Element = T

    // 创建新的顶点
    func createVertex(data: T) -> Vertex<T> {
        // 先判断是否已经有了吗
        let matchingVertices = vertices.filter({ (vertex) -> Bool in
            return vertex.data == data
        })
        
        if matchingVertices.count > 0 {
            return matchingVertices.last!
        }
        
        // 创建顶点
        let vertex = Vertex(data: data, index: vertices.count)
        
        // 补充和现有顶点的连接的占位：在矩阵中每一行的最后添加一个空值
        for row in 0 ..< adjacencyMatrix.count {
            adjacencyMatrix[row].append(nil)
        }
        
        // 在矩阵中最后添加新的一行
        let newRow = [Double?](repeatElement(nil, count: vertices.count + 1))
        adjacencyMatrix.append(newRow)
        
        // 添加新顶点到顶点列表中
        vertices.append(vertex)
        
        return vertex
    }
    
    // 创建新连接
    func addEdge(_ type: EdgeType, from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        switch type {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(vertices: (source, destination), weight: weight)
        }
    }
    
    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        adjacencyMatrix[source.index][destination.index] = weight
    }
    
    func addUndirectedEdge(vertices: (Vertex<T>, Vertex<T>), weight: Double?) {
        addDirectedEdge(from: vertices.0, to: vertices.1, weight: weight)
        addDirectedEdge(from: vertices.1, to: vertices.0, weight: weight)
    }
    
    // 边的权
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        return adjacencyMatrix[source.index][destination.index]
    }
    
    // 顶点的所有连接
    func edges(from source: Vertex<T>) -> [Edge<T>]? {
        
        var outEdges = [Edge<T>]()
        
        // 获取顶点的 index
        let row = source.index
        
        // 遍历顶点的 edge list，找出不为空的值
        for column in 0 ..< adjacencyMatrix[row].count {
            
            if let weight = adjacencyMatrix[row][column], column < vertices.count {
                let edge = Edge(source: source, destination: vertices[column], weight: weight)  // 创建对应的 Edge
                outEdges.append(edge)  // 添加到数组中
            }
        }
        
        // 返回结果
        return outEdges
    }
    
    public var description: CustomStringConvertible {
        var grid = [String]()
        let n = self.adjacencyMatrix.count
        for i in 0..<n {
            var row = "\n"
            for j in 0..<n {
                if let value = self.adjacencyMatrix[i][j] {
                    let number = NSString(format: "%.1f", value)
                    row += "\(value >= 0 ? " " : "")\(number)   "
                } else {
                    row += "  ø    "
                }
            }
            grid.append(row)
        }
        return (grid as NSArray).componentsJoined(by: "\n")
    }
    
}
