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
 
 class 和 enum 两种方式实现的区别：
 基于 class 实现的是引用类型，基于 enum 实现的是值类型
 值类型是不可变的，所以在修改 class 类型的树时，修改的是内存上同一个实例，而修改 enum 类型的树时，会得到一份新 copy 的树
 
 Enumerations
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145
 
 */


/// 方式一：用 class 的方式实现
//public class BinarySearchTree<T: Comparable> {
//}


/// 方式二：采用枚举实现
public enum BinarySearchTree<T: Comparable> {
    case Empty          // 空节点
    case Leaf(T)        // 叶节点
    indirect case Node(BinarySearchTree, T, BinarySearchTree)  // 带有左右子节点的
    
    
    /// 节点个数
    public var count: Int {
        switch self {
        case .Empty:
            return 0
        case .Leaf:
            return 1
        case let .Node(left, _, right):
            return left.count + 1 + right.count
        }
    }
    
    
    /// 树的高度
    public var height: Int {
        switch self {
        case .Empty:
            return 0
        case .Leaf:
            return 1
        case let .Node(left, _, right):
            return 1 + max(left.height, right.height)
        }
    }
    
    
    /// 插入新节点
    public func insert(newValue: T) -> BinarySearchTree {
        switch self {
        case .Empty:
            return .Leaf(newValue)
            
        case .Leaf(let value):
            if newValue < value {
                return .Node(.Leaf(newValue), value, .Empty)
            } else {
                return .Node(.Empty, value, .Leaf(newValue))
            }
            
        case .Node(let left, let value, let right):
            if newValue < value {
                return .Node(left.insert(newValue: newValue), value, right)
            } else {
                return .Node(left, value, right.insert(newValue: newValue))
            }
        }
    }
    
    
    /// 查找
    public func search(value: T) -> BinarySearchTree? {
        switch self {
        case .Empty:
            return nil
        case .Leaf(let nodeValue):
            return (value == nodeValue) ? self : nil
        case let .Node(let left, let nodeValue, let right):
            if value < nodeValue {
                return left.search(value: value)
            } else if nodeValue < value {
                return right.search(value: value)
            } else {
                return self
            }
        }
    }
    
}

extension BinarySearchTree: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .Empty:
            return "."
        case .Leaf(let value):
            return "\(value)"
        case .Node(let left, let value, let right):
            return "(\(left.debugDescription) <- \(value) -> \(right.debugDescription))"
        }
    }
}


var tree = BinarySearchTree.Leaf(7)
tree = tree.insert(newValue: 2)
tree = tree.insert(newValue: 5)
tree = tree.insert(newValue: 10)
tree = tree.insert(newValue: 9)
tree = tree.insert(newValue: 1)


tree.search(value: 10)
tree.search(value: 1)
tree.search(value: 11)   // nil
