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
 
 ##### 旋转要点/规律
 - 一种平衡策略就是从找离新插入的节点最近的不平衡的树进开始调整，然后往上递归平衡
 - 不平衡的树一定在从新插入的节点到根节点的路径上
 - 每一次需要平衡的是该“局部不平衡树”的根节点到新插入“节点”路径上的连续3个不同层级的节点
 - 旋转这 3 个节点后，得到的结果一定是最小的节点作为左子树，最大的节点作为右子树，大小居中的节点作为这颗“局部不平衡树”的根节点
 - 对于一个合法的BST来说，任意节点的左子树上的所有节点一定比右子树的所有节点值要小，所以，我们在旋转后，可以按大小顺序重新调整子树的位置
 
 
          (4)            3
          /    右旋      / \
左-左    (3)    ---->   2  (4)
        /
       2
 
        (2)                3
          \      左旋      / \
右-右      (3)   ----->   2   4
            \
             4
 
          4                 (4)              3
         /       先左旋      /     再右旋     /  \
左-右   (2)       ----->   (3)     ---->    2   4
         \                /
         (3)             2
 
         2                (2)                  3
          \     先右旋       \      再左旋      /  \
 右-左    (4)   ------>      (3)      --->    2   4
         /                    \
        (3)                    4
 
 
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
 http://blog.csdn.net/liyong199012/article/details/29219261
 
 */

/**
 Swift 相关知识点：
 
 1. Optionals and String Interpolation

 https://stackoverflow.com/questions/42543007/how-to-solve-string-interpolation-produces-a-debug-description-for-an-optional
 https://segmentfault.com/a/1190000007791822
 
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
    
    
    /// 更新树的高度
    fileprivate func updateHeightUpwards(node: Node?) {
        if let node = node {
            let lHeight = node.leftChild?.height ?? 0
            let rHeight = node.rightChild?.height ?? 0
            
            node.height = max(lHeight, rHeight) + (node.hasAnyChild ? 1 : 0)
            
            updateHeightUpwards(node: node.parent)
        }
    }
    
    /// 平衡因子 = 左子树的高度 - 右子树的高度
    fileprivate func lrDifference(node: Node?) -> Int {
        let lHeight = node?.leftChild?.height ?? 0
        let rHeight = node?.rightChild?.height ?? 0
        return lHeight - rHeight
    }
    
    
    fileprivate func balance(node: Node?) {
        guard let node = node else {
            return
        }
    
        // 因为插入了新节点，所以需要更新高度，用于后面计算平衡因子
        updateHeightUpwards(node: node.leftChild)
        updateHeightUpwards(node: node.rightChild)
        
        // 3 个参与旋转的点
        var pivot: Node? = nil
        var pivotLeftChild: Node? = nil
        var pivotRightChild: Node? = nil

        var subtrees = [Node?](repeatElement(nil, count: 4))  // 4 个子树：参与旋转的节点的子节点，subtrees 中的元素是从小到大排列的
        let nodeParent = node.parent
    
        // 计算当前节点的平衡因子
        let lrFactor = lrDifference(node: node)
        
        if lrFactor > 1 {
            // 左-左 或者 左-右
            
            // 计算左子树的平衡因子
            if lrDifference(node: node.leftChild) > 0 {
                // 左-左                                                     //       (6)                   (4)
                pivotRightChild = node                                      //       /  \                  /  \
                pivot = node.leftChild                                      //     (4)   7               (2)  (6)
                pivotLeftChild = node.leftChild?.leftChild                  //     / \                   / \  / \
                                                                            //   (2)  5      ---->      1  3 5   7
                                                                            //   / \
                // 参与旋转的其他子节点                                         //  1   3
                subtrees[0] = pivotLeftChild?.leftChild
                subtrees[1] = pivotLeftChild?.rightChild
                subtrees[2] = pivot?.rightChild
                subtrees[3] = pivotRightChild?.rightChild
                
            } else {
                // 左-右                                                     //        (10)                  (8)
                pivotRightChild = node                                      //         / \                  / \
                pivotLeftChild = node.leftChild                             //       (5) 11               (5) (10)
                pivot = node.leftChild?.rightChild                          //       / \      ----->      / \  / \
                                                                            //      4  (8)               4  6 9   11
                                                                            //         / \
                // 参与旋转的其他子节点                                         //        6   9
                subtrees[0] = pivotLeftChild?.leftChild
                subtrees[1] = pivot?.leftChild
                subtrees[2] = pivot?.rightChild
                subtrees[3] = pivotRightChild?.rightChild

            }
            
            
        } else if lrFactor < -1 {
            // 右-右 或者 右-左
            
            // 计算右子树的平衡因子
            if lrDifference(node: node.rightChild) < 0 {
                // 右-右                                                      //       (2)                   (4)
                pivotLeftChild = node                                        //       / \                   /  \
                pivot = node.rightChild                                      //      1  (4)               (2)  (7)
                pivotRightChild = node.rightChild?.rightChild                //         / \    ----->     / \  / \
                                                                             //        3  (7)            1  3 6   8
                                                                             //           / \
                // 参与旋转的其他子节点                                          //          6   8
                subtrees[0] = pivotLeftChild?.leftChild
                subtrees[1] = pivot?.leftChild
                subtrees[2] = pivotRightChild?.leftChild
                subtrees[3] = pivotRightChild?.rightChild
                
                
            } else {
                // 右-左                                                      //        (3)                 (7)
                pivotLeftChild = node                                        //        / \                 /  \
                pivotRightChild = node.rightChild                            //       2  (9)             (3)  (9)
                pivot = node.rightChild?.leftChild                           //          / \   ---->     / \  / \
                                                                             //        (7) 10           2  6 8   10
                                                                             //        / \
                // 参与旋转的其他子节点                                          //       6   8
                subtrees[0] = pivotLeftChild?.leftChild
                subtrees[1] = pivot?.leftChild
                subtrees[2] = pivot?.rightChild
                subtrees[3] = pivotRightChild?.rightChild
            }
            
            
        } else {
            // 如果当前节点不需要平衡调整，就调整父节点
            balance(node: node.parent)
            return
        }
        
        // 旋转后， 作为转轴的节点 pivot 替代原来的父节点，也就是当前节点
        if node.isRoot {
            root = pivot
            root?.parent = nil
        } else if node.isLeftChild {
            nodeParent?.leftChild = pivot
            pivot?.parent = nodeParent
        } else if node.isRightChild {
            nodeParent?.rightChild = pivot
            pivot?.parent = nodeParent
        }
        
        // 连接转轴节点和左右子节点
        pivot?.leftChild = pivotLeftChild
        pivotLeftChild?.parent = pivot
        pivot?.rightChild = pivotRightChild
        pivotRightChild?.parent = pivot
        
        
        // 重新连接参与旋转的节点和相关子节点的连接， subtrees 中的元素是从小到大排列的
        pivotLeftChild?.leftChild = subtrees[0]
        subtrees[0]?.parent = pivotLeftChild
        pivotLeftChild?.rightChild = subtrees[1]
        subtrees[1]?.parent = pivotLeftChild
        
        
        pivotRightChild?.leftChild = subtrees[2]
        subtrees[2]?.parent = pivotRightChild
        pivotRightChild?.rightChild = subtrees[3]
        subtrees[3]?.parent = pivotRightChild
        
        // 平衡旋转后，需要重新更新高度
        updateHeightUpwards(node: pivotLeftChild)
        updateHeightUpwards(node: pivotRightChild)
        
        // 调整父节点
        balance(node: pivot?.parent)
    }
    
}

// MARK: Delete node

extension AVLTree {
    
    // 删除指定 key
    public func delete(key: Key) {
        
        // 如果是根节点，直接清空
        if size == 1 {
            root = nil
            size -= 1
        } else if let node = search(key: key, node: root) { // 找出对应的节点，如果没找到，就什么都不做
            delete(node: node)
            size -= 1
        }
    }
    
    // 删除指定节点
    private func delete(node: Node) {
        
        // 叶节点可以直接移除，再调整平衡
        if node.isLeaf {
            
            // 是不是根节点？
            if let nodeParent = node.parent {
                // 检测合法性
                guard node.isLeftChild || node.isRightChild else {
                    fatalError("Error: tree is valid.")
                }
                
                if node.isLeftChild {
                    nodeParent.leftChild = nil
                } else if node.isRightChild {
                    nodeParent.rightChild = nil
                }
                
                balance(node: nodeParent)
                
            } else {
                // 如果是根节点
                root = nil
            }
            
        } else {
            // 如果不是叶节点，就递归替换，直到找到一个叶节点
            if let replacement = node.leftChild?.maximum(), node !== replacement {
                node.key = replacement.key
                node.payload = replacement.payload
                delete(node: replacement)
                
            } else if let replacement = node.rightChild?.minimum(), node !== replacement {
                node.key = replacement.key
                node.payload = replacement.payload
                delete(node: replacement)
            }
        }
    }
}

// MARK: - Advanced Stuff
extension AVLTree {
    
    // 中序遍历/顺序遍历：左-根-右
    public func doInOrder(node: Node?, _ completion: (Node) -> Void) {
        if let node = node {
            doInOrder(node: node.leftChild) { lnode in
                completion(lnode)
            }
            completion(node)
            doInOrder(node: node.rightChild) { rnode in
                completion(rnode)
            }
        }
    }
    
    // 先序遍历：根-左-右
    public func doInPreOrder(node: Node?, _ completion: (Node) -> Void) {
        if let node = node {
            completion(node)
            doInPreOrder(node: node.leftChild) { lnode in
                completion(lnode)
            }
            doInPreOrder(node: node.rightChild) { rnode in
                completion(rnode)
            }
        }
    }
    
    // 后序遍历：左-右-根
    public func doInPostOrder(node: Node?, _ completion: (Node) -> Void) {
        if let node = node {
            doInPostOrder(node: node.leftChild) { lnode in
                completion(lnode)
            }
            doInPostOrder(node: node.rightChild) { rnode in
                completion(rnode)
            }
            completion(node)
        }
    }
}


// MARK: - Debugging
extension TreeNode: CustomDebugStringConvertible {
    public var debugDescription: String {
        var s = "key: \(key), payload: \(String(describing: payload)), height: \(height)"
        if let parent = parent {
            s += ", parent: \(parent.key)"
        }
        if let left = leftChild {
            s += ", left = [" + left.debugDescription + "]"
        }
        if let right = rightChild {
            s += ", right = [" + right.debugDescription + "]"
        }
        return s
    }
}

extension AVLTree: CustomDebugStringConvertible {
    public var debugDescription: String {
        return root?.debugDescription ?? "[]"
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = leftChild {
            s += "(\(left.description)) <- "
        }
        s += "\(key)"
        if let right = rightChild {
            s += " -> (\(right.description))"
        }
        return s
    }
}

extension AVLTree: CustomStringConvertible {
    public var description: String {
        return root?.description ?? "[]"
    }
}


let tree = AVLTree<Int, Int>.init()
tree.insert(key: 6)
print(tree)
tree.insert(key: 4)
print(tree)
tree.insert(key: 7)
print(tree)
tree.insert(key: 5)
print(tree)
tree.insert(key: 2)
print(tree)
tree.insert(key: 1)
print(tree)
tree.insert(key: 3)

print(tree)
print(tree.debugDescription)

tree.delete(key: 2)
print(tree)
print(tree.debugDescription)

tree.doInOrder(node: tree.root) { (node) in
    print(node.key)
}
