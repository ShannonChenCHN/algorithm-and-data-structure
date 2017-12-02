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
 - 中序遍历/顺序遍历/深度优先：左-根-右
 - 后序遍历：左-右-根
 
 ### 删除节点：
 当要删除的节点有子节点时，原节点就需要被替换：左侧最大的子节点或者右侧最小的子节点
 
 
 ### 平衡树：
 当一个树结构的左右子树都包含相同数量的子节点，我们可以说这棵树就是平衡的。
 
 当一侧的子树比另一侧的子树要高很多的话，搜索操作时就会非常慢，复杂度接近于 O(n)，极端情况下，这样一个树结构就变成了链表
 
 所以，一种比较好的操作方式，就是插入新节点时采用随机的方式
 另外一种方式就是采用自平衡树的结构（能够在插入和删除节点时，自动保持平衡），比如 AVL 树，红黑树
 
 https://baike.baidu.com/item/二叉搜索树
 https://zh.wikipedia.org/wiki/二元搜尋樹
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Search%20Tree
 */


/*
 
 Swift 相关知识点：
 discardableResult 关键字
 http://blog.csdn.net/jason_chen13/article/details/76618887
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
    
    // 查找，一般从根节点开始找
    public func search(value: T) -> BinarySearchTree? {
        
        if value < self.value {         // 比当前节点数值小，就到左边子树下面找
            return left?.search(value: value)  // 没有左子树，就代表没找到，就返回 nil
            
        } else if value > self.value {  //  比当前节点数值大，就到右边子树下面找
            return right?.search(value: value)
            
        } else {
            return self
        }
    }
    
    // 中序遍历
    public func traverseInOrder(process: (T) -> Void) {
        left?.traverseInOrder(process: process)
        process(value)
        right?.traverseInOrder(process: process)
    }
    
    // 前序遍历
    public func traversePreOrder(process: (T) -> Void) {
        process(value)
        left?.traverseInOrder(process: process)
        right?.traverseInOrder(process: process)
    }
    
    // 后序遍历
    public func traversePostOrder(process: (T) -> Void) {
        left?.traverseInOrder(process: process)
        right?.traverseInOrder(process: process)
        process(value)
    }
    
    // 最小值
    public func minimum() -> BinarySearchTree {
        if let left = left {
            return left.minimum()
        } else {
            return self
        }
    }
    
    // 最大值
    public func maximum() -> BinarySearchTree {
        if let right = right {
            return right.maximum()
        } else {
            return self
        }
    }
    
    // 连接父节点
    private func reconnectParentTo(node: BinarySearchTree?) {
        if let parent = parent {
            if self.isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        
        node?.parent = parent
    }
    
    // 删除节点
    @discardableResult public func remove() -> BinarySearchTree? {
        // 找到替代者
        let replacement: BinarySearchTree?
        if let right = right {
            replacement = right.minimum()
        } else if let left = left {
            replacement = left.maximum()
        } else {
            replacement = nil  // 如果没有子节点就最直接移除
        }
        
        // 切断替代者的现有连接：递归移除，直到叶节点
        replacement?.remove()
        
        /* 将树中的当前节点替换为替代者 */
        // 处理子节点的连接
        replacement?.left = left
        replacement?.right = right
        left?.parent = replacement
        right?.parent = replacement
        
        // 处理父节点的连接
        reconnectParentTo(node: replacement)
        
        // 清空当前节点的所有连接
        parent = nil
        left = nil
        right = nil
        
        return replacement
    }
    
    // 树的高度：每两级节点之间的高度都为 1，复杂度为 O(n)
    public func height() -> Int {
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
    
    // 节点的深度：当前节点到根节点之间的层级间隔
    public func depth() -> Int {
        var node = self
        var edges = 0
        while let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }
    
    // （按大小顺序排）找出当前节点前面的一个节点：有左侧子树的话，就找左侧子树的最大值，没有的话，就从父节点往上找，直到比当前节点小的值
    // 复杂度为 O(h)
    public func predecessor() -> BinarySearchTree<T>? {
        if let left = left {
            return left.maximum()
        } else {
            var node = self
            while let parent = node.parent {
                if parent.value < value {
                    return parent
                }
                node = parent
            }
            return nil
        }
    }
    
    // 检查树的合法性：不论哪一层极，父节点永远比左侧子节点大，永远比右侧子节点小
    public func isBST(minValue: T, maxValue: T) -> Bool {
        
        if value < minValue || value > maxValue {
            return false
        }
        
        let leftBST = left?.isBST(minValue: minValue, maxValue: value) ?? true
        let rightBST = right?.isBST(minValue: value, maxValue: maxValue) ?? true
        
        return leftBST && rightBST
    }
    
    // （按大小顺序排）找出当前节点后面的一个节点：
    public func successor() -> BinarySearchTree<T>? {
        if let right = right {
            return right.minimum()
        } else {
            var node = self
            while let parent = node.parent {
                if parent.value > value {
                    return parent
                }
                node = parent
            }
            return nil
        }
    }
    
    // 映射函数
    public func map(formula: (T) -> T) -> [T] {
        var a = [T]()
        if let left = left {
            a += left.map(formula: formula)
        }
        a.append(formula(value))
        if let right = right {
            a += right.map(formula: formula)
        }
        return a
    }
    
    // 转成数组
    public func toArray() -> [T] {
        return map { $0 }
    }
}

//extension BinarySearchTree: CustomStringConvertible {
//
//    public var description: String {
//        var s = ""
//        if let left = left {
//            s += "(\(left.description)) <- "
//        }
//        s += "\(value)"
//        if let right = right {
//            s += " -> (\(right.description))"
//        }
//        return s
//    }
//}



//let tree = BinarySearchTree.init(value: 7)
//tree.insert(2)
//tree.insert(5)
//tree.insert(10)
//tree.insert(9)
//tree.insert(1)

let tree = BinarySearchTree.init(array: [7, 2, 5, 10, 9, 1])

tree.search(value: 5)
tree.search(value: 2)
tree.search(value: 7)
tree.search(value: 6)   // nil

tree.traverseInOrder { value in
    print(value)
}

tree.height()

if let node9 = tree.search(value: 9) {
    node9.depth()   // returns 2
}

if let node1 = tree.search(value: 1) {
    tree.isBST(minValue: Int.min, maxValue: Int.max)  // true
    node1.insert(value: 100)                                 // EVIL!!!
    tree.search(value: 100)                                  // nil
    tree.isBST(minValue: Int.min, maxValue: Int.max)  // false
}




/// 方式二：采用枚举实现
//enum BinarySearchTree<T: Comparable> {
//
//}

