//: Playground - noun: a place where people can play

import UIKit


/**
 
 二叉搜索树
 ### 定义：一种按照特定规则排序的二叉树。
 
 ### 特点：
   - 若任意节点的左子树不空，则左子树上所有节点的值均小于它的根节点的值；
   - 若任意节点的右子树不空，则右子树上所有节点的值均大于它的根节点的值；
   - 任意节点的左、右子树也分别为二叉查找树；
   - 没有键值相等的节点。
 
 ### 插入新节点：
 从根节点开始往下依次与各级节点比较，将新节点的值与该节点的值相比，如果比该节点小，就选左侧子树，如果比该节点大，就选右侧子树，直到找到一个我们可以插入的空节点
 
 插入新节点的复杂度为 O(h)，h 为树的高度，一般我们在描述二叉查找树的复杂度的时候，用高度来作为参数
 
 ### 搜索：
 跟插入新节点的操作类似，从根节点依次往下找，将新节点的值与当前节点的值相比：
   - 如果比当前节点小，就选左侧子树
   - 如果比当前节点小，就选右侧子树
   - 如果跟当前节点一样大，就找到结果了
 
 搜索的复杂度为 O(h)
 
 ### 遍历：
 - 先序遍历：根-左-右
 - 中序遍历：左-根-右
 - 后序遍历：左-右-根
 
 ### 删除节点：
 当要删除的节点有子节点时，原节点就需要被替换：左侧最大的子节点或者右侧最小的子节点
 
 
 https://baike.baidu.com/item/二叉搜索树
 https://zh.wikipedia.org/wiki/二元搜尋樹
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Search%20Tree
 */



/// 方式一：用 class 的方式实现
public class BinarySearchTree<T: Comparable> {
    private(set) var value: T
    private(set) var parent: BinarySearchTree?
    private(set) var left: BinarySearchTree?
    private(set) var right: BinarySearchTree?
    
    public init(value: T) {
        self.value = value
    }
    
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    var isLeftChild: Bool {
        return parent?.left === self
    }
    
    
    var isRightChild: Bool {
        return parent?.right === self
    }
    
    var hasLeftChild: Bool {
        return left != nil
    }
    
    var hasRightChild: Bool {
        return right != nil
    }
    
    var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    var hasBothChild: Bool {
        return hasLeftChild && hasRightChild
    }
    
    // 这个节点加上子树的总节点个数
    var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    // 便捷初始化方法
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        
        self.init(value: array.first!) // 根节点
        
        // 依次插入剩余的新节点
        for value in array.dropFirst() {
            insert(value: value)
        }
    }
    
    
    // 插入新节点：从根节点开始往下依次与各级节点比较，将新节点的值与该节点的值相比，如果比该节点小，就选左侧子树，如果比该节点大，就选右侧子树，直到找到一个我们可以插入的空节点
    public func insert(value: T) {
        
        if value < self.value {
            
            if let left = left { // 有左节点
                left.insert(value: value)
            } else {
                left = BinarySearchTree.init(value: value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchTree.init(value: value)
                right?.parent = self
            }
        }
    }
    
    
    func search(value: T) -> BinarySearchTree? {
        if value < self.value {
            
        } else if value > self.value
    }
    
    
}

extension BinarySearchTree: CustomStringConvertible {
    
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
}



let tree = BinarySearchTree.init(array: [7, 2, 5, 10, 9, 1])
//let tree = BinarySearchTree.init(value: 7)
//tree.insert(2)
//tree.insert(5)
//tree.insert(10)
//tree.insert(9)
//tree.insert(1)

