//: Playground - noun: a place where people can play

import UIKit


/*
 
 ### 一、树是什么？
 一图胜千言
 
 树是由 n（n>=1）个有限节点组成一个具有层次关系的集合。
 树是一种非线性的数据结构。
 一个树结构一般是由多个节点组成的，而且这些节点之间是相连的。每个节点都有指向子节点的引用，有时也可以有指向父节点的引用。一个节点最多只能有一个父节点，但是可以有多个子节点。
 树的结构有层次（level）的概念，根节点（root）的 level 为 0，每往下走一级，level 就加 1。
 
 ### 二、树能用来干嘛？
 - 表征一组有层级关系的数据
 - 让搜索更高效更快
 - 提供一个有序集合
 - powering prefix matching in text fields
 
 ### 三、相关术语
 
 - 节点（Node）：组成树结构中每个独立的元素称为节点，每个节点中可以包含一些数据。
 
 - 父节点/双亲节点：
 
 - 子节点/孩子节点：
 
 - 根节点（Root）：没有父节点的节点，在树结构中 level 为 0，同时也是树结构的入口。
 
 - 叶节点（Leaf）：又称终端节点，没有子节点的节点。
 
 - 树的高度（Height of the tree）：根节点到最低层级的叶节点之间的连接（link）个数
 
 - 节点的深度（Depth of a node）：该节点到到根节点之间的连接（link）个数
 
 
 ### 四、树的基本实现
 
 ### 五、其他种类的树
 - 二叉树（Binary Tree）：每个节点最多只有两个子节点。
 - 二叉搜索树（Binary Search Tree）：一种限制条件更多的二叉树，搜索效率高的有序树。
 - AVL树（AVL Tree）：
 - B 树/B-树（B-Tree）：
 - 基数树(Radix Tree)：
 - 最小生成树(Minimum Spanning Tree)：
 - 红黑树（Red-Black Tree）：
 - 线段树（Segment Tree）：
 - 二叉线索树(Threaded Binary Tree)：
 - 前缀树/字典树（Trie）：是一种有序树，用于保存关联数组，其中的键通常是字符串。与二叉查找树不同，键不是直接保存在节点中，而是由节点在树中的位置决定。
 - 并查集(Union-Find)：
 
 ### 六、延伸
 
 #### 1. 树和图（Graph）之间的关系：
 树和图都是非线性的数据结构。图相对于树来说，是更加抽象和复杂的。可以认为树是图的基础，树是一种更简单意义上的图。
 
 在树结构中，每一个数据元素都可能和下一层中多个元素（即子结点）相关，但却只能与上一层中的一个元素（即父结点）相关。
 而在图结构中，结点之间的关系可以是任意的，图中任意两个数据之间都可能相关。
 
 示意图
 
 #### 2. 链表也是一种简单形式的树
 
 */



/// 节点
class Node<T> {
    var value: T
    var children: [Node] = []
    weak var parent: Node? // 1. 并不是所有的节点都有父节点，比如根节点，所以这里用的是 optional;
                           // 2. 因为父节点对这个节点强引用了，所以这里对父节点的引用应该为 weak，避免循环引用
    
    
    // 所有的 non-optional stored properties 都需要初始化
    init(value: T) {
        self.value = value
    }
    
    // 插入节点时用于串联节点的方法
    func add(child: Node) {
        children.append(child)
        child.parent = self
    }
}


extension Node: CustomStringConvertible {
    
    var description: String {
        
        var text = "\(value)"
        
        if !children.isEmpty {
            text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }
}


// 必须是 Equatable 类型的值，才能使用这个 extension 中的搜索方法
extension Node where T: Equatable {
    
    // 从树结构中查找是否存在一个给定的值，如果找到了就返回对应的节点，如果没有就返回 nil
    func search(value: T) -> Node? {
        
        // 自己是否匹配
        if value == self.value {
            return self
        }
        
        // 子节点是否匹配，递归查找
        for child in children {
            if let found = child.search(value: value) {
                return found
            }
        }
        
        // 没找到就返回 nil
        return nil
        
    }
}



let beverages = Node.init(value: "beverages")

let hotBeverage = Node(value: "hot")
let coldBeverage = Node(value: "cold")

let tea = Node.init(value: "tea")
let coffee = Node.init(value: "coffe")
let cocoa = Node.init(value: "cocoa")

let blackTea = Node(value: "black")
let greenTea = Node(value: "green")
let chaiTea = Node(value: "chai")

let soda = Node(value: "soda")
let milk = Node(value: "milk")

let gingerAle = Node(value: "ginger ale")
let bitterLemon = Node(value: "bitter lemon")

beverages.add(child: hotBeverage)
beverages.add(child: coldBeverage)

hotBeverage.add(child: tea)
hotBeverage.add(child: coffee)
hotBeverage.add(child: cocoa)

coldBeverage.add(child: soda)
coldBeverage.add(child: milk)

tea.add(child: blackTea)
tea.add(child: greenTea)
tea.add(child: chaiTea)

soda.add(child: gingerAle)
soda.add(child: bitterLemon)

print(beverages)

beverages.search(value: "cocoa") // returns the "cocoa" node
beverages.search(value: "chai") // returns the "chai" node
beverages.search(value: "bubbly") // returns nil


let number = Node(value: 5)



