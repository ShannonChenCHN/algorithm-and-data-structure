//
//  Graph.swift
//  Graph
//
//  Created by ShannonChen on 2017/11/23.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import Foundation


/// 图结构的抽象协议
protocol Graphable {
    associatedtype Element: Hashable                 /// 泛型容器中的数据
    var description: CustomStringConvertible { get } /// 方便 debug 的 description 方法
    
    
    /// 添加一个顶点
    func createVertex(data: Element) -> Vertex<Element>
    
    /// 添加一条边
    func addEdge(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    
    /// 给定边的权
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
    
    /// 跟给定顶点相连的边
    func edges(from source: Vertex<Element>) -> [Edge<Element>]?
    
}
