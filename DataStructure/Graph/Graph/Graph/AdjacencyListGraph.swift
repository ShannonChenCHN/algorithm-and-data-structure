//
//  AdjacencyList.swift
//  Graph
//
//  Created by ShannonChen on 2017/11/23.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import Foundation




/*
 
 For Directed
 
 Vertices            Adjacency List
    A                     B, C, D
    B                     A, D
    C                     A
    D
 
 
 For Undirected
 
 Vertices            Adjacency List
    A                     B, C, D
    B                     A, C, D
    C                     A, B
    D                     A, B
 */

/// 邻接链表
open class AdjacencyListGraph<T: Hashable> {
    public var adjacencyMap: [Vertex<T>: [Edge<T>]] = [:] // 存储顶点和对应边的映射关系的字典
    public init() {
        
    }
    
}


extension AdjacencyListGraph: Graphable {
    public typealias Element = T
    
    
    // 新添加一个顶点
    public func createVertex(data: T) -> Vertex<T> {
        // 创建1个新顶点
        let vertex = Vertex(data: data)
        
        // 添加对应的 vertex-edges 映射
        if adjacencyMap[vertex] == nil {
            adjacencyMap[vertex] = []
        }
        
        return vertex
    }
    
    /// 添加一条新边
    public func addEdge(_ type: EdgeType, from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        
        switch type {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(vertices: (source, destination), weight: weight)
        }
    }
    
    /// 添加一条新边（有向图）
    public func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencyMap[source]?.append(edge)
    }

    /// 添加一条新边（无向图）
    public func addUndirectedEdge(vertices: (Vertex<T>, Vertex<T>), weight: Double?) {
        let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }

    
    // 边的权
    public func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        // 找出 source 顶点的 edge list
        guard let edges = adjacencyMap[source] else {
            return nil
        }
        
        for edge in edges {
            if edge.destination == destination {  // 从 edge list 中找出 destination 匹配的 edge
                return edge.weight
            }
        }
        
        return nil
    }
    
    // 一个顶点相连的边
    public func edges(from source: Vertex<T>) -> [Edge<T>]? {
        return adjacencyMap[source]
    }
    
    
    public var description: CustomStringConvertible {
        var result = "\n "
        for (vertex, edges) in adjacencyMap {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) \t\t---> [ \(edgeString) ] \n ")
        }
        return result
    }
}

