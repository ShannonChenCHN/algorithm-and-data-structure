//: Playground - noun: a place where people can play

import UIKit


/*
 二叉树
 
 二叉树的每个结点至多只有二棵子树(不存在度大于2的结点)，二叉树的子树有左右之分，次序不能颠倒。
 
 二叉树遍历：从树的根节点出发，按照某种次序依次访问二叉树中所有的结点，使得每个结点被访问仅且一次。
 三种遍历方式：
 - 中序遍历（In-order / depth-first）：左-根-右
 - 前序遍历（Pre-order）：根-左-右
 - 后序遍历（Post-order）：左-右-根
 
 二叉树的种类：
 - 斜树
 - 满二叉树
 - 完全二叉树
 - 二叉堆
 - 二叉查找树

 
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Tree
 https://www.cnblogs.com/polly333/p/4740355.html
 https://baike.baidu.com/item/二叉树
 
 */


/*
 Swift 相关知识点：
 
 1. indirect 关键字和嵌套 Enum
 indirect 主要用于 Enum 的嵌套定义
 
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html
 http://swifter.tips/indirect-nested-enum/
 
 */


public indirect enum BinaryTree<T> {
    case node(BinaryTree<T>, T, BinaryTree<T>)
    case empty
    
    // 节点数
    var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        case .empty:
            return 0
        }
    }
    
    // 中序遍历
    public func traverseInOrder(process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            left.traverseInOrder(process: process)
            process(value)
            right.traverseInOrder(process: process)
        }
    }
    
    // 前序遍历
    public func traversePreOrder(process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            process(value)
            left.traverseInOrder(process: process)
            right.traverseInOrder(process: process)
        }
    }
    
    // 后序遍历
    public func traversePostOrder(process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            left.traverseInOrder(process: process)
            right.traverseInOrder(process: process)
            process(value)
        }
    }
}

extension BinaryTree: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .node(left, value, right):
            return "value: \(value), left: \(left), right: \(right)"
        case .empty:
            return ""
        }
    }
}

/*
 表达式：(5 * (a - 10)) + (-4 * (3 / b))
 */

// 页节点
let node5 = BinaryTree.node(.empty, "5", .empty)
let nodeA = BinaryTree.node(.empty, "a", .empty)
let node10 = BinaryTree.node(.empty, "10", .empty)
let node4 = BinaryTree.node(.empty, "4", .empty)
let node3 = BinaryTree.node(.empty, "3", .empty)
let nodeB = BinaryTree.node(.empty, "b", .empty)

// 左侧中间部分的节点
let Aminus10 = BinaryTree.node(nodeA, "-", node10)
let timesLeft = BinaryTree.node(node5, "*", Aminus10)

// 右侧的中间节点
let minus4 = BinaryTree.node(.empty, "-", node4)
let divide3andB = BinaryTree.node(node3, "/", nodeB)
let timesRight = BinaryTree.node(minus4, "*", divide3andB)

// 根节点
let tree = BinaryTree.node(timesLeft, "+", timesRight)


tree.traverseInOrder(process: { value in
    print("\(value)")
})

print("\n\n\n")

tree.traversePreOrder(process: { value in
    print("\(value)")
})

print("\n\n\n")

tree.traversePostOrder(process: { value in
    print("\(value)")
})


