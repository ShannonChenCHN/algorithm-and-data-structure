//: Playground - noun: a place where people can play

import UIKit

/*
 AVL 树
 
 
 ### 定义：
 AVL树是最先发明的自平衡二叉查找树。在AVL树中任何节点的两个子树的高度最大差别为1，所以它也被称为高度平衡树。
 查找、插入和删除在平均和最坏情况下的时间复杂度都是 O(log n)。增加和删除可能需要通过一次或多次树旋转来重新平衡这个树。
 树的高度为 log(n) ，其中 n 是节点个数
 
 ### 特点：
 - 本身首先是一棵二叉搜索树。
 - 带有平衡条件：每个结点的左右子树的高度之差的绝对值（平衡因子）最多为1。
 也就是说，AVL树，本质上是带了平衡功能的二叉查找树（二叉排序树，二叉搜索树）。
 
 平衡树是计算机科学中的一类改进的二叉查找树。一般的二叉查找树的查询复杂度是跟目标结点到树根的距离（即深度）有关，因此当结点的深度普遍较大时，查询的均摊复杂度会上升，为了更高效的查询，平衡树应运而生了。
 在这里，平衡指所有叶子的深度趋于平衡，也就是说左右子树的节点个数大致相等，更广义的是指在树上所有可能查找的均摊复杂度偏低。
 
 平衡因子：左右子树的高度差
 ```
 balance factor = abs(height(left subtree) - height(right subtree))
 ```
 
 ### 树旋转：
 
 #### 两种方式
 - 单旋转（左左、右右）
 - 双旋转（左右、右左）
 #### 相关术语
 - 树根
 - 转轴
 - 旋转侧子树
 - 旋转侧对侧子树
 
 ##### 旋转要点
 - 找离新插入的节点最近的不平衡的树进行调整
 
 
 ### 实现 AVL 树
 
 AVL 树的实现与二叉查找树的大部分实现相同，只是在插入和删除节点的操作上会有些区别
 
 
 https://zh.wikipedia.org/wiki/平衡树
 https://zh.wikipedia.org/wiki/树旋转
 https://zh.wikipedia.org/wiki/AVL树
 https://baike.baidu.com/item/AVL树
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/AVL%20Tree
 
 
 http://blog.csdn.net/silangquan/article/details/8100936
 http://www.jianshu.com/p/6988699625d5
 http://www.cnblogs.com/huangxincheng/archive/2012/07/22/2603956.html
 http://blog.csdn.net/vesper305/article/details/13614403
 
 */



public class TreeNode<Key: Comparable, Payload> {
    public typealias Node = TreeNode<Key, Payload>
    
    var payload: Payload?       // 节点中的值
    
    fileprivate var key: Key    // 节点的名字，树根据 key 值的大小来排序
    internal var leftChild: Node?
    internal var rightChild: Node?
    fileprivate var height: Int
    weak fileprivate var parent: Node?
    
    public init(key: Key, payload: Payload?, leftChild: Node?, rightChild: Node?, parent: Node?, height: Int) {
        self.key = key
        self.payload = payload
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.parent = parent
        self.height = height
        
        self.leftChild?.parent = self
        self.rightChild?.parent = self
    }
    
    public convenience init(key: Key, payload: Payload?) {
        self.init(key: key, payload: payload, leftChild: nil, rightChild: nil, parent: nil, height: 1)
    }
    
    public convenience init(key: Key) {
        self.init(key: key, payload: nil)
    }
    
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return rightChild == nil && leftChild == nil
    }
    
    var isLeftChild: Bool {
        return parent?.leftChild === self
    }
    
    var isRightChild: Bool {
        return parent?.rightChild === self
    }
    
    var hasLeftChild: Bool {
        return leftChild != nil
    }
    
    var hasRightChild: Bool {
        return rightChild != nil
    }
    
    var hasAnyChild: Bool {
        return leftChild != nil || rightChild != nil
    }
    
    var hasBothChildren: Bool {
        return leftChild != nil && rightChild != nil
    }
    
}


// MARK: - The AVL tree
open class AVLTree<Key: Comparable, Payload> {
    public typealias Node = TreeNode<Key, Payload>
    
    fileprivate(set) var root: Node?        // 树根
    fileprivate(set) var size = 0           // 树的节点个数
    
    public init() { }
}


// MARK: - Searching
extension TreeNode {
    
    public func minimum() -> TreeNode? {
        return leftChild?.minimum() ?? self
    }
    
    public func maximum() -> TreeNode? {
        return rightChild?.maximum() ?? self
    }
}


extension AVLTree {
    
    /// 下标访问
    subscript(key: Key) -> Payload? {
        get {
            return search(input: key)
        }
        set {
            insert(key: key, payload: newValue)
        }
    }
    
    /// 根据 key 值进行查找
    public func search(input: Key) -> Payload? {
        return search(key: input, node: root)?.payload
    }
    
    
    
    /// 从指定节点开始往下找
    fileprivate func search(key: Key, node: Node?) -> Node? {
        if let node = node {
            if key == node.key {
                return node
            } else if key < node.key {
                return search(key: key, node: node.leftChild)
            } else {
                return search(key: key, node: node.rightChild)
            }
        }
        return nil
    }
}


// MARK: - Inserting new items
extension AVLTree {
    
    
    
    /// 插入新节点
    public func insert(key: Key, payload: Payload? = nil) {
        
        if let root = root { // 如果有了根节点
            insert(input: key, payload: payload, node: root)
        } else {
            root = Node(key: key, payload: payload)
        }
        
        // 每新添加一个新节点， size 加 1
        size += 1
    }
    
    
    /// 以指定节点为入口，插入新节点
    private func insert(input: Key, payload: Payload?, node: Node) {
        
        if input < node.key {
            if let left = node.leftChild {
                insert(input: input, payload: payload, node: left)
            } else {
                let child = Node(key: input, payload: payload, leftChild: nil, rightChild: nil, parent: node, height: 1)
                node.leftChild = child
                balance(node: child)
            }
        } else if input > node.key {
            if let right = node.rightChild {
                insert(input: input, payload: payload, node: right)
            } else {
                let child = Node(key: input, payload: payload, leftChild: nil, rightChild: nil, parent: node, height: 1)
                node.rightChild = child
                balance(node: child)
            }
        }
        
        // !!! 为什么没有 == 的情况？
    }
    
}

// MARK: - Balancing tree

extension AVLTree {
    
    
    /// 平衡因子
    fileprivate func lrDifference(node: Node?) -> Int {
        let lHeight = node?.leftChild?.height ?? 0
        let rHeight = node?.rightChild?.height ?? 0
        return lHeight - rHeight
    }
    
    
    func balance(node: Node?) {
        guard let node = node else {
            return
        }
    
        // 更新高度
        
        
        //
        var nodes = [Node?](repeatElement(nil, count: 3))     // 3 个要参与旋转的节点：第 0 个最大，第 1 个最小，第 2 个始终作为父节点，所以不大不小
        var subtrees = [Node?](repeatElement(nil, count: 4))  // 4 个子树：参与旋转的其他子节点
        let nodeParent = node.parent
    
        // 计算当前节点的平衡因子
        let lrFactor = lrDifference(node: node)
        
        if lrFactor > 1 {
            // 左-左 或者 左-右
            
            // 计算左子树的平衡因子
            if lrDifference(node: node.leftChild) > 0 {
                // 左-左                                                   //        C
                nodes[0] = node                                           //       /
                nodes[2] = node.leftChild                                 //      B
                nodes[1] = node.leftChild?.leftChild                      //     /
                                                                          //    A
                // 参与旋转的其他子节点
                subtrees[0] = node.leftChild?.leftChild?.leftChild
                subtrees[1] = node.leftChild?.leftChild?.rightChild
                subtrees[2] = node.leftChild?.rightChild
                subtrees[3] = node.rightChild
                
            } else {
                // 左-右                                                   //        C
                nodes[0] = node                                           //       /
                nodes[1] = node.leftChild                                 //      A
                nodes[2] = node.leftChild?.rightChild                     //       \
                                                                          //        B
                // 参与旋转的其他子节点
                subtrees[0] = node.leftChild?.leftChild
                subtrees[1] = node.leftChild?.rightChild?.leftChild
                subtrees[2] = node.leftChild?.rightChild?.rightChild
                subtrees[3] = node.rightChild
                
            }
            
            
        } else if lrFactor < -1 {
            // 右-右 或者 右-左
            
            // 计算右子树的平衡因子
            if lrDifference(node: node.rightChild) < 0 {
                // 右-右                                                   //        A
                nodes[1] = node                                           //         \
                nodes[2] = node.rightChild                                //          B
                nodes[0] = node.rightChild?.rightChild                    //           \
                                                                          //            C
                
                // 参与旋转的其他子节点
                subtrees[0] = node.rightChild?.rightChild?.leftChild
                subtrees[1] = node.leftChild
                subtrees[2] = node.rightChild?.leftChild
                subtrees[3] = node.rightChild?.rightChild?.rightChild
                
            } else {
                // 右-左                                                   //        A
                nodes[1] = node                                           //         \
                nodes[2] = node.rightChild                                //          C
                nodes[0] = node.rightChild?.rightChild                    //         /
                                                                          //        B
                
                // 参与旋转的其他子节点
                subtrees[0] = node.leftChild
                subtrees[1] = node.rightChild?.leftChild?.leftChild
                subtrees[2] = node.rightChild?.leftChild?.rightChild
                subtrees[3] = node.rightChild?.rightChild
            }
            
            
        } else {
            // 如果当前节点不需要平衡调整，就调整父节点
            balance(node: node.parent)
            return
        }
        
        // 旋转后， nodes[2] 替代原来的父节点，也就是当前节点
        if node.isRoot {
            root = nodes[2]
            root?.parent = nil
        } else if node.isLeftChild {
            nodeParent?.leftChild = nodes[2]
            nodes[2]?.parent = nodeParent
        } else if node.isRightChild {
            nodeParent?.rightChild = nodes[2]
            nodes[2]?.parent = nodeParent
        }
        
        nodes[2]?.leftChild = nodes[1]
        nodes[1]?.parent = nodes[2]
        nodes[2]?.rightChild = nodes[0]
        nodes[0]?.parent = nodes[2]
        
        
        nodes[1]?.leftChild = subtrees[0]
        subtrees[0]?.parent = nodes[1]
        nodes[1]?.rightChild = subtrees[1]
        subtrees[1]?.parent = nodes[1]
        
        
        nodes[0]?.leftChild = subtrees[2]
        subtrees[2]?.parent = nodes[0]
        nodes[0]?.rightChild = subtrees[3]
        subtrees[3]?.parent = nodes[1]
        
        // 更新高度
        
        
        // 调整父节点
        balance(node: nodes[2]?.parent)
    }
    
}
