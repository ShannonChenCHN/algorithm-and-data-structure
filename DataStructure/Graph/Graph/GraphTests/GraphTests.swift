//
//  GraphTests.swift
//  GraphTests
//
//  Created by ShannonChen on 2017/11/23.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

import XCTest
@testable import Graph

class GraphTests: XCTestCase {
    
    func testSwift4() {
        // last checked with Xcode 9.0b4
        #if swift(>=4.0)
            print("Hello, Swift 4!")
        #endif
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAdjacencyListGraph() {
        let adjacencyList = AdjacencyListGraph<String>()
        
        let singapore = adjacencyList.createVertex(data: "Singapore")
        let tokyo = adjacencyList.createVertex(data: "Tokyo")
        let hongKong = adjacencyList.createVertex(data: "Hong Kong")
        let detroit = adjacencyList.createVertex(data: "Detroit")
        let sanFrancisco = adjacencyList.createVertex(data: "San Francisco")
        let washingtonDC = adjacencyList.createVertex(data: "Washington DC")
        let austinTexas = adjacencyList.createVertex(data: "Austin Texas")
        let seattle = adjacencyList.createVertex(data: "Seattle")

        adjacencyList.addEdge(.undirected, from: singapore, to: hongKong, weight: 300)
        adjacencyList.addEdge(.undirected, from: singapore, to: tokyo, weight: 500)
        adjacencyList.addEdge(.undirected, from: hongKong, to: tokyo, weight: 250)
        adjacencyList.addEdge(.undirected, from: tokyo, to: detroit, weight: 450)
        adjacencyList.addEdge(.undirected, from: tokyo, to: washingtonDC, weight: 300)
        adjacencyList.addEdge(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
        adjacencyList.addEdge(.undirected, from: detroit, to: austinTexas, weight: 50)
        adjacencyList.addEdge(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
        adjacencyList.addEdge(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
        adjacencyList.addEdge(.undirected, from: washingtonDC, to: seattle, weight: 277)
        adjacencyList.addEdge(.undirected, from: sanFrancisco, to: seattle, weight: 218)
        adjacencyList.addEdge(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)

        print(adjacencyList.description)
        if let flightsFromSanFrancisco = adjacencyList.edges(from: sanFrancisco) {
            print("San Francisco Out Going Flights:")
            print("--------------------------------")
            for edge in flightsFromSanFrancisco {
                print("from: \(edge.source) to: \(edge.destination)")
            }
        }
        
        XCTAssertEqual(adjacencyList.weight(from: singapore, to: tokyo), 500)
        
    }
    
    func testAdjacencyMatrixGraph() {
        let adjacencyList = AdjacencyMatrixGraph<String>()
        
        let singapore = adjacencyList.createVertex(data: "Singapore")
        let tokyo = adjacencyList.createVertex(data: "Tokyo")
        let hongKong = adjacencyList.createVertex(data: "Hong Kong")
        let detroit = adjacencyList.createVertex(data: "Detroit")
        let sanFrancisco = adjacencyList.createVertex(data: "San Francisco")
        let washingtonDC = adjacencyList.createVertex(data: "Washington DC")
        let austinTexas = adjacencyList.createVertex(data: "Austin Texas")
        let seattle = adjacencyList.createVertex(data: "Seattle")
        
        adjacencyList.addEdge(.undirected, from: singapore, to: hongKong, weight: 300)
        adjacencyList.addEdge(.undirected, from: singapore, to: tokyo, weight: 500)
        adjacencyList.addEdge(.undirected, from: hongKong, to: tokyo, weight: 250)
        adjacencyList.addEdge(.undirected, from: tokyo, to: detroit, weight: 450)
        adjacencyList.addEdge(.undirected, from: tokyo, to: washingtonDC, weight: 300)
        adjacencyList.addEdge(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
        adjacencyList.addEdge(.undirected, from: detroit, to: austinTexas, weight: 50)
        adjacencyList.addEdge(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
        adjacencyList.addEdge(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
        adjacencyList.addEdge(.undirected, from: washingtonDC, to: seattle, weight: 277)
        adjacencyList.addEdge(.undirected, from: sanFrancisco, to: seattle, weight: 218)
        adjacencyList.addEdge(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)
        
        print(adjacencyList.description)
        if let flightsFromSanFrancisco = adjacencyList.edges(from: sanFrancisco) {
            print("San Francisco Out Going Flights:")
            print("--------------------------------")
            for edge in flightsFromSanFrancisco {
                print("from: \(edge.source) to: \(edge.destination)")
            }
        }
        
        XCTAssertEqual(adjacencyList.weight(from: singapore, to: tokyo), 500)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
