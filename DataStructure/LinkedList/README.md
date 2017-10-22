# 链表（Linked List）


### 一、什么是链表

链表跟数组类似，也是一个有序集合。但他们的区别在于，创建数组时需要分配一大块内存用来存储元素，而链表中的元素在内存分配上是相互独立的，元素与元素之间是通过指针或者引用连接起来的。

```
+--------+      +--------+      +--------+      +--------+
|        | next |        | next |        | next |        |
| node 0 |----->| node 1 |----->| node 2 |----->| node 3 |
|        |      |        |      |        |      |        |
+--------+      +--------+      +--------+      +--------+
```
						图 1. 单向链表

#### 1. 节点
一般我们把链表中的元素称为“节点”。

#### 2. 单向链表与双向链表（Singly vs doubly linked lists）
节点与节点之间会通过指针或者引用连接起来，根据节点连接方式的不同，我们可以把链表分为**单向链表**和**双向链表**两种。

#### 单向链表
上面图 1 中所示的就是一个单向链表。单向链表中的节点只有一个指向下一个元素的指针/引用(“next”指针)。

#### 双向链表
下面图 2 中所示的是一个双向链表。双向链表中的节点有一个指向下一个元素的指针/引用（“next”指针），同时还有一个指向上一个元素的指针/引用（“previous”指针）。

```
+--------+ next +--------+ next +--------+ next +--------+
|        |----->|        |----->|        |----->|        |
| node 0 |      | node 1 |      | node 2 |      | node 3 |
|        |<-----|        |<-----|        |<-----|        |
+--------+ prev +--------+ prev +--------+ prev +--------+
```
						图 2. 双向链表
						
#### 3. head 指针和 tail 指针
在使用链表时，我们一般需要知道链表从哪里开始的，所以链表一般会有一个 head 指针，指向链表中的第一个元素。此时第一个元素的 previous 指针为 nil。

有时候，我们还会有一个 tail 指针，指向链表中的最后一个元素。此时最后一个元素的 next 指针为 nil。

```
        +--------+ next +--------+ next +--------+ next +--------+
head--->|        |----->|        |----->|        |----->|        |--->nil
        | node 0 |      | node 1 |      | node 2 |      | node 3 |
nil <---|        |<-----|        |<-----|        |<-----|        |<---tail
        +--------+ prev +--------+ prev +--------+ prev +--------+
```
						图 3. head 指针和 tail 指针
						
#### 4. 其他类型的链表
- 循环链表（Circular Linked list）
- 多重表（Multiply linked list）

### 二、为什么使用链表（链表的特点）
相比数组，链表的插入和删除效率更高，对于不需要搜索但变动频繁且无法预知数量上限的数据，更适合用链表。

比如，当我们从一个数组中移除第一个元素后，需要将后面的元素在内存中的位置都往前移，这就意味着需要重新进行内存分配和内存布局，因为数组中的元素在内存上是连续的。但是对于链表，我们只需要把 `head` 指针/引用指向第二个元素就可以了。

所以链表的**特点**显而易见：

- 优点
  - 链表是一个动态的数据结构，其容量可以随意增大和减小
  - 链表不需要在初始化时，提前申请用于存储元素的内存
  - 链表是一个将多个**局部节点**连接起来的数据结构（类似的还有树和图）
  - 插入删除不需要移动其他元素，操作起来非常简单
- 缺点
  - 链表比数组要占用更多的内存，因为链表除了需要用于值存储之外，还有一些指针也需要占用空间
  - 读取链表的节点时，必须要从表头或者表尾开始一个一个按顺序读
  - 从链表中查找元素是比较费时的，因为链表中的节点不是连续存储的，所以访问单个节点的效率比较低


### 三、链表的实现

实现链表有几个要点：

- 设计链表的两个要素
  - 节点
    - `next`指针
    - `previous` 指针（双向链表）
  - 表头和表尾
    - `head` 指针
    - `tail` 指针（可选）
- 操作链表时的两个要点
  - 更新 `next`指针和 `previous` 指针
  - 更新 `head` 指针和 `tail` 指针

#### 1. Swift（[源码](https://github.com/ShannonChenCHN/DataStructure-Algorithm-Notes/tree/master/DataStructure/LinkedList/Swift)）

> 注：这里是基于 `class` 实现的，当然你也可以使用 `enum`。

```
/// 链表节点
public class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    
    public init(value: T) {
        self.value = value
    }
}


/// 一个双向链表
public class LinkedList<T> {
    public typealias Node = LinkedListNode<T>
    
    private var head: Node?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }


    // 从 head 开始往后一步一步走，直到最后一个节点
    // 注：如果我们有一个记录 tail 节点的实例变量，那么这个 last 方法就可以直接返回 tail 节点。但是我们在这里没有这么做，所以这个 last 方法是一个比较耗时的操作，尤其是当链表特别长的时候
    public var last: Node? {
    
        if var node = head {
            while let next = node.next {
                node = next
            }
            return node
        } else {
            return nil
        }
    }
    
    // 找到最后一个节点，将新节点拼接在后面
    public func append(_ value: T) {
    
        let newNode = Node(value: value)
        
        if let lastNode = self.last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }

    // 从 head 开始往后一步一步走，每走一步 count 加 1
    // 注：这种方式的复杂度为 O(n)，如果我们给链表添加一个实例变量用来追踪 count 值的话，复杂度就变成了O(1)，但是这样我们就需要在每次添加或者移除一个节点的同时，去更新这个变量
    public var count: Int {
    
        if var node = head {
            var c = 1
            while let next = node.next {
                node = next
                c += 1
            }
            return c
        } else {
            return 0
        }
    }
    
    

    // 从 head 开始往后走，走 index 步就可以得到结果了
    // 0(head) -> 1 -> 2 -> 3
    public func nodeAt(_ index: Int) -> Node? {
    
        if index >= 0 {
            var node = head
            var leftStep = index // 需要走多少步
            
            while node != nil {
            
                if leftStep == 0 { return node }  // 直到剩余 0 步时才返回
                leftStep -= 1                     // 剩余步数减 1
                node = node!.next                 // 往前走一步
            }
     
//            // 另一种方案
//            for _ in 0..<index {
//                if let tempNode = node, tempNode.next != nil {
//                    node = tempNode.next
//                } else {
//                    node = nil
//                }
//            }
//            return node

        }
        return nil
    }
    
    // 下标方法，内部直接调用的是 nodeAt 方法，同时做了越界抛异常处理
    public subscript(index: Int) -> T {
        let node = nodeAt(index)
        assert(node != nil)
        return node!.value
    }
    
    /*  示意图：
     *  head --> A --> B --> C --> D --> E --> F --> nil
     *          prev  next
     */
     // 这个方法和 nodesBeforeAndAfter 方法同样适用于单向链表，因为它们的实现不依赖于 prev 指针
    public func insert(_ value: T, atIndex index: Int) {
        // 找到要插入的位置的前后节点，要注意为 nil 的情况
        let (prev, next) = nodesBeforeAndAfter(index)
        
        // 将新节点插入链表中，将其与前后节点链接起来
        let newNode = Node(value: value)
        newNode.previous = prev
        newNode.next = next
        prev?.next = newNode
        next?.previous = newNode
        
        // 当插入的位置是 0，那么就需要更新 head 了
        // 注：如果有 tail 并且插入的位置是最后的话，也需要更新 tail
        if prev == nil {
            head = newNode
        }
    }
    
    // 跟 nodeAt 方法类似，也是从 head 开始，一个一个往后找
    // 这个方法是用来查找位于 index 位置的节点以及位于 index 前面一位的节点
    private func nodesBeforeAndAfter(_ index: Int) -> (Node?, Node?) {
        assert(index >= 0)
        
        var i = index
        var next = head
        var prev: Node?
        
        while next != nil && i > 0 {
            i -= 1
            prev = next
            next = next!.next
        }
        
        assert(i == 0)  // 越界的处理
        
        return (prev, next)
    }
    
    
    // 移除某个节点
    // 这个方法的操作最简单，因为它不需要从头开始一个一个去找这个节点
    public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    public func removeLast() -> T {
        assert(!isEmpty)
        return remove(node: last!)
    }
    
    public func removeAt(_ index: Int) -> T {
        let node = nodeAt(index)
        assert(node != nil)
        return remove(node: node!)
    }

    
    // 移除所有的节点
    // 注：如果有 tail 的话，也要把 tail 置为 nil
    public func removeAll() {
        head = nil
    }
    
    
    
    
        /*
        
      pre +--------+  pre +--------+  pre +--------+  pre +--------+
 nil <----|        |<-----|        |<-----|        |<-----|        |
          | node 0 |      | node 1 |      | node 2 |      | node 3 |
head ---->|        |----->|        |----->|        |----->|        |-----> nil
          +--------+ next +--------+ next +--------+ next +--------+ next 
          
         
     
     next +--------+  pre +--------+  pre +--------+  pre +--------+
nil <-----|        |<-----|        |<-----|        |<-----|        |
          | node 0 |      | node 1 |      | node 2 |      | node 3 |
          |        |----->|        |----->|        |----->|        |-----> nil
          +--------+  pre +--------+ next +--------+ next +--------+ next
                              ∧
                              |
                             head

     next +--------+ next +--------+  pre +--------+  pre +--------+
nil <-----|        |<-----|        |<-----|        |<-----|        |
          | node 0 |      | node 1 |      | node 2 |      | node 3 |
          |        |----->|        |----->|        |----->|        |
          +--------+  pre +--------+ pre  +--------+ next +--------+
                                               ∧
                                               |
                                              head

     next +--------+ next +--------+ next +--------+ next +--------+
nil <-----|        |<-----|        |<-----|        |<-----|        |<---- head
          | node 0 |      | node 1 |      | node 2 |      | node 3 |
          |        |----->|        |----->|        |----->|        |-----> nil
          +--------+  pre +--------+ pre  +--------+  pre +--------+ pre
     

        */
    
    // 反转链表
    // 如上图所示：一步一步往后走，依次将每个节点的 prev 指针和 next 指针反转过来，同时还要把 head 和 tail（如果有的话）调换一下
    public func reverse() {
        
        var node = head
//        tail = node // If you had a tail pointer
        while let currentNode = node {
            
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            
            head = currentNode
        }
    }
    
```

#### 2. Objective-C（[源码](https://github.com/ShannonChenCHN/DataStructure-Algorithm-Notes/tree/master/DataStructure/LinkedList/Objective-C/LinkedList)）
 
``` Objective-C
NS_ASSUME_NONNULL_BEGIN

/**
 链表节点
 */
@interface SCLinkedListNode<__covariant ObjectType> : NSObject

@property (strong, nonatomic) ObjectType value;
@property (strong, nonatomic, nullable) SCLinkedListNode *next;
@property (weak, nonatomic, nullable) SCLinkedListNode *previous;

- (instancetype)initWithValue:(ObjectType)value;

@end

NS_ASSUME_NONNULL_END

```
``` Objective-C
@implementation SCLinkedListNode

- (instancetype)initWithValue:(id)value {

    self = [super init];
    if (self) {
        _value = value;
    }
    return self;
}

- (NSString *)description {
    return self.value;
}

@end


```

``` Objective-C
NS_ASSUME_NONNULL_BEGIN

typedef SCLinkedListNode SCNode;

/**
 一个双向链表
 有 head，但是没有 tail
 
 0(head/first) -> 1 -> 2 -> 3 -> 4(last)
 
 */
@interface SCLinkedList<__covariant ObjectType> : NSObject

@property (assign, nonatomic, readonly) BOOL isEmpty;     ///< 是否为空
@property (strong, nonatomic, readonly) SCNode *first;    ///< 第一个节点
@property (strong, nonatomic, readonly) SCNode *last;     ///< 最后一个节点

@property (assign, nonatomic) NSUInteger count; ///< 节点个数


// 插入节点
- (void)appendNodeWithValue:(ObjectType)value;
- (void)insertNodeWithValue:(ObjectType)value atIndex:(NSInteger)index;

// 访问节点
- (SCNode *)nodeAtIndex:(NSInteger)index;
- (ObjectType)objectAtIndexedSubscript:(NSInteger)index;

// 移除操作
- (SCNode *)removeNode:(SCNode *)node;
- (SCNode *)removeNodeAtIndex:(NSUInteger)index;
- (SCNode *)removeLastNode;
- (void)removeAllNodes;

// 翻转链表
- (void)reverse;

@end

NS_ASSUME_NONNULL_END

```
``` Objective-C
@interface SCLinkedList ()

@property (strong, nonatomic, nullable) SCNode *head;     ///< 链表头

@end

@implementation SCLinkedList

#pragma mark - Getter
- (BOOL)isEmpty {
    return self.head == nil;
}

- (SCNode *)first {
    return self.head;
}

// 从 head 开始往后一步一步走，直到最后一个节点
// 注：如果我们有一个记录 tail 节点的实例变量，那么这个 last 方法就可以直接返回 tail 节点。但是我们在这里没有这么做，所以这个 last 方法是一个比较耗时的操作，尤其是当链表特别长的时候
- (SCNode *)last {
    
    // 如果表头为空，直接返回 nil
    if (self.head == nil) {
        return nil;
    }
    
    
    // 0(head) -> 1 -> 2 -> 3 -> 4(last)
    
    SCNode *currentNode = self.head;
    while (currentNode.next != nil) { // 下一个节点不是空的就去下一个
        currentNode = currentNode.next;
    }
    
    return currentNode;
}

// 从 head 开始往后一步一步走，每走一步 count 加 1
// 注：这种方式的复杂度为 O(n)，如果我们给链表添加一个实例变量用来追踪 count 值的话，复杂度就变成了O(1)，但是这样我们就需要在每次添加或者移除一个节点的同时，去更新这个变量
- (NSUInteger)count {
    
    // 0(head) -> 1 -> 2 -> 3 -> 4(last)
    //
    
    if (self.head == nil) {
        return 0;
    }
    
    SCNode *currentNode = self.head;
    
    NSInteger count = 1;
    while (currentNode.next != nil) { // 下一个节点不是空的，就往下去一个
        count++;
        currentNode = currentNode.next;
    }
    
    return count;
}



#pragma mark - 读取节点

// 从 head 开始往后走，走 index 步就可以得到结果了
// 0(head) -> 1 -> 2 -> 3
- (SCNode *)nodeAtIndex:(NSInteger)index {
    NSAssert(index >= 0, @"Error: Out of bounds");

    // 链表为空就直接返回 nil
    if (self.head == nil) {
        return nil;
    }
    
    
    SCNode *currentNode = self.head; // 从 head 往后走
    
    NSInteger step = index;
    
    // 剩余步数不为 0
    while (step > 0) {
        
        // 往后走一步
        step--;
        currentNode = currentNode.next;
        
        // 出界了就返回 nil
        if (currentNode == nil) {
            return nil;
        }
    }
    
    return currentNode;
}


// http://www.cnblogs.com/zenny-chen/p/3593660.html
// 下标方法，内部直接调用的是 nodeAt 方法，同时做了越界抛异常处理
- (id)objectAtIndexedSubscript:(NSInteger)index {
    
    SCNode *node = [self nodeAtIndex:index];
    NSAssert(node != nil, nil);
    
    return node.value;
}


#pragma mark - 插入节点
// 找到最后一个节点，将新节点拼接在后面
- (void)appendNodeWithValue:(id)value {
    
    // 0(head) -> 1 -> 2 -> 3(last)
    // 0(head) -> 1 -> 2 -> 3 -> 4(last)
    
    SCNode *newNode = [[SCNode alloc] initWithValue:value];
    
    if (self.last) {
        newNode.previous = self.last;
        self.last.next = newNode;
    } else {
        self.head = newNode;
    }
}

// 跟 nodeAt 方法类似，也是从 head 开始，一个一个往后找
// 这个方法是用来查找位于 index 位置的节点以及位于 index 前面一位的节点
- (void)p_findNodesBeforeAndAtIndex:(NSInteger)index completion:(void(^)(SCNode *prev, SCNode *this))completion {
    NSAssert(index >= 0, @"Error: out of bounds");
    
    // 0(head) -> 1 -> 2 -> 3
    
    NSInteger step = index;
    SCNode *currentNode = self.head;
    SCNode *prevOfCurrentNode = nil;
    
    while (step > 0 && currentNode.next) {
        step--;
        prevOfCurrentNode = currentNode;
        currentNode = currentNode.next;
    }
    
    NSAssert(step == 0, @"Error: Out of bounds");
    
    // 返回结果
    if (completion) {
        completion(prevOfCurrentNode, currentNode);
    }


}


/*  示意图：
 *  head --> A --> B --> C --> D --> E --> F --> nil
 *          prev  next
 */
// 这个方法和 nodesBeforeAndAtIndex 方法同样适用于单向链表，因为它们的实现不依赖于 prev 指针
- (void)insertNodeWithValue:(id)value atIndex:(NSInteger)index {

    [self p_findNodesBeforeAndAtIndex:index completion:^(SCNode *prev, SCNode *next) {
        
        
        // 将新节点插入链表中，将其与前后节点链接起来
        SCNode *newNode = [[SCNode alloc] initWithValue:value];
        newNode.previous = prev;
        newNode.next = next;
        prev.next = newNode;
        next.previous = newNode;
        
        
        // 当插入的位置是 0，那么就需要更新 head 了
        // 注：如果有 tail 并且插入的位置是最后的话，也需要更新 tail
        if (prev == nil) {
            self.head = prev;
        }
        
    }];
    
}

#pragma mark - 移除节点
- (SCNode *)removeNode:(SCNode *)node {
    
    // head --> A --> B --> C --> D --> E
    SCNode *prev = node.previous;
    SCNode *next = node.next;
    
    if (node == self.head) { // 要移除的是 head
        
        self.head = next;
        next.previous = nil;
        
    } else { // 要移除的不是 head，而是 A，B.....
    
        prev.next = next;
        next.previous = prev;
    }
    
    
    // 切断 node 的前后连接
    node.previous = nil;
    node.next = nil;
    
    return node.value;
}

- (SCNode *)removeNodeAtIndex:(NSUInteger)index {
    
    SCNode *node = [self nodeAtIndex:index];
    
    NSAssert(node != nil, nil);
    
    return [self removeNode:node];
}

- (SCNode *)removeLastNode {
    NSAssert(self.isEmpty == NO, nil);
    
    return [self removeNode:self.last];
}


// 移除所有的节点
// 注：如果有 tail 的话，也要把 tail 置为 nil
- (void)removeAllNodes {
    self.head = nil;
}

#pragma mark - 翻转链表

       /*
        
      pre +--------+  pre +--------+  pre +--------+  pre +--------+
 nil <----|        |<-----|        |<-----|        |<-----|        |
          | node 0 |      | node 1 |      | node 2 |      | node 3 |
head ---->|        |----->|        |----->|        |----->|        |-----> nil
          +--------+ next +--------+ next +--------+ next +--------+ next 
          
         
     
     next +--------+  pre +--------+  pre +--------+  pre +--------+
nil <-----|        |<-----|        |<-----|        |<-----|        |
          | node 0 |      | node 1 |      | node 2 |      | node 3 |
          |        |----->|        |----->|        |----->|        |-----> nil
          +--------+  pre +--------+ next +--------+ next +--------+ next
                              ∧
                              |
                             head

     next +--------+ next +--------+  pre +--------+  pre +--------+
nil <-----|        |<-----|        |<-----|        |<-----|        |
          | node 0 |      | node 1 |      | node 2 |      | node 3 |
          |        |----->|        |----->|        |----->|        |
          +--------+  pre +--------+ pre  +--------+ next +--------+
                                               ∧
                                               |
                                              head

     next +--------+ next +--------+ next +--------+ next +--------+
nil <-----|        |<-----|        |<-----|        |<-----|        |<---- head
          | node 0 |      | node 1 |      | node 2 |      | node 3 |
          |        |----->|        |----->|        |----->|        |-----> nil
          +--------+  pre +--------+ pre  +--------+  pre +--------+ pre
     

        */


// 反转链表
// 一步一步往后走，依次将每个节点的 prev 指针和 next 指针反转过来，同时还要把 head 和 tail（如果有的话）调换一下
- (void)reverse {
    
    
    
    SCNode *currentNode = self.head;
    
    while (currentNode != nil) {
        // 获取当前的这一步的节点
        SCNode *nodeToSwap = currentNode;
        
        // 往前走一步
        currentNode = nodeToSwap.next;
        
        // 翻转当前的这一步的节点
        SCNode *previous = nodeToSwap.previous;
        SCNode *next = nodeToSwap.next;
        nodeToSwap.next = previous;
        nodeToSwap.previous = next;
        
        // 设置 head
        self.head = currentNode;
    }
}

@end


```

#### 3. C（TODO）

### 四、复杂度
#### 1. 访问链表的单个元素的复杂度为 O(n)

如果我们想要访问链表中的第 3 个元素，并不能想数组那样直接通过 `list[2]` 就能访问到。因为我们没有直接指向链表中每个元素的引用，我们只能从 `head` 指针指向的第一个元素开始查找，然后通过每个节点 `next` 指针，一个节点一个节点往后查找，直到指定位置的节点。

所以，查找元素并不是链表的特长。

#### 2. 更快捷的插入和删除操作

从前面的『为什么使用链表』部分，我们就已经了解到，链表相比数组的优势就在于更高效的插入和删除。

**如果你已经有了一个指向链表中某节点的指针/引用**，那么在该位置插入新节点和删除该节点的复杂度都为 O(1)。

所以，我们在操作链表时，应该尽可能利用已知的节点，比如借助 head、tail 插入新节点。


### 五、链表的应用



### 六、我所理解的链表
- 链表是一种有序集合
- 链表是一种最基本、最简单、最常见的数据结构之一，它可以被用来实现其它的一些抽象数据结构（ADT），比如表、栈、队列
- 链表中的元素就是节点，节点包含存储内容的 `value` 变量和 `next` 指针（双向链表的节点还包含`previous` 指针）
- 链表除了节点还有指向第 1 个元素的 `head` 指针和指向最后一个元素的 `tail` 指针
- 链表的优势在于插入删除操作的高效
- 链表的查找操作复杂度为 **O(n)**，无须查找的插入或者删除操作的复杂度为 **O(1)**

### 七、面试题
1. 为什么在使用 `for-in` 语句遍历 `NSArray` 变量时，同时插入或者删除元素会导致 crash？


### 八、参考资料
- [raywenderlich/swift-algorithm-club: Linked List](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Linked%20List)
- [Linked list - Wikipedia](https://en.wikipedia.org/wiki/Linked_list#Related_data_structures)
- [链表(linked list)这一数据结构具体有哪些实际应用？](https://www.zhihu.com/question/60724366?utm_medium=social&utm_source=wechat_session)
- [用链表的目的是什么？省空间还是省时间？](https://www.zhihu.com/question/31082722?utm_medium=social&utm_source=wechat_session)
