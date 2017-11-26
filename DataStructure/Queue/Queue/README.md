# 队列（Queue）


### 一、什么是队列

队列，又称为伫列（queue），是先进先出（FIFO, First-In-First-Out）的线性表（list）。在具体应用中通常用链表或者数组来实现。

队列只允许在后端（称为rear）进行插入操作，在前端（称为front）进行删除操作。

队列的操作方式和**栈**类似，唯一的区别在于队列只允许新数据在后端进行添加。

 
```
                              ^
                              |
┏━━━━━━┓ ┏━━━━━━┓ ┏━━━━━━┓ ┏━━━━━━┓ ┏━━━━━━┓
┃      ┃ ┃  10  ┃ ┃  10  ┃ ┃  10  ┃ ┃   3  ┃
┃      ┃ ┃      ┃ ┃  3   ┃ ┃  3   ┃ ┃  57  ┃
┃      ┃ ┃      ┃ ┃      ┃ ┃  57  ┃ ┃      ┃
┗━━━━━━┛ ┗━━━━━━┛ ┗━━━━━━┛ ┗━━━━━━┛ ┗━━━━━━┛
   ^         ^       ^
   |         |       |
   10        3       57  
```
图 1. 队列

队列的种类：
- 双端队列（Deque）：两端都可以入队、出队
- 优先队列（Priority queue）：一种有序队列，最重要的元素始终放在最前面

### 二、为什么使用队列（队列的特点）

当你在处理一组数据时，需要考虑添加和移除元素的顺序，而且需要先进先出这种处理机制，此时就可以用到队列。

### 三、复杂度

#### 1. enqueue 的复杂度：O(1)

因为每次添加一个元素到队列时，都是添加到数组的最后，而不管数组有多大，添加元素到数组最后的耗时都是一个常量。
 
> 延伸：为什么添加元素到数组后面的复杂度是 O(1)或者一个耗时为常量的操作？
 
因为在 Swift 的实现中，数组的末尾总是会有空余的空间，比如，现在有这样一个数组：

```
["Ada", "Steve", "Tim"]
```

在内存中，它实际上是这样的：

```
[ "Ada", "Steve", "Tim", xxx, xxx, xxx ]
```

`xxx` 就是暂时分配了内存但是没有用到的单元，如果添加了一个新元素，新添加的元素就会占用一个空白的内存单元：

```
[ "Ada", "Steve", "Tim", "Grace", xxx, xxx ]
```
 
**边界情况**：但是数组末尾分配的空余空间是有限的，当最后一个 `xxx` 也被用了的话，如果你还要添加新的元素到数组中，你就需要重新调整数组的大小。调整数组的大小意味着需要分配新的内存空间给一个新数组，并且将原来的数组元素全部拷贝到新数组中。这个时候的操作就是一个复杂度为 O(n) 的操作，但是这只是一种极端情况，所以可以说一般情况下，添加新元素到数组的最后还是 O(1) 的操作。
 
 
#### 2. dequeue 的复杂度为 O(n)
 
因为每次移除元素时，都是将数组中的第一个元素移除，然后再将后面剩余的元素往前移
比如在上面的例子中，当将 `Ada` 从队列中移除时，后面的 `Steve` 将会被拷贝到原来 `Ada` 的位置，`Tim` 将会被拷贝到原来 `Steve` 的位置 ...， 以此类推。
 
 ```
 before   [ "Ada", "Steve", "Tim", "Grace", xxx, xxx ]
                    /       /      /
                   /       /      /
                  /       /      /
                 /       /      /
 after    [ "Steve", "Tim", "Grace", xxx, xxx, xxx ]
 
 ```
 
 > 遗留问题
 
 > - 数组在内存中是如何布局的？
 > - 从数组中移除第一个元素后，数组后面的元素发生了什么变化？
 
### 四、队列的实现
实现队列的方式有多种：
- 基于数组（Array）
- 基于链表（Linked List）
- 基于环形缓存器（Circular Buffer）
- 基于堆（Heap）

> 这里我们只讨论基于最基本的数组来实现。

#### 1. 基本实现
我们可以基于数组来实现一个基本的队列结构，这个队列支持以下几种接口：

- count：元素个数
- isEmpty：是否为空
- front：第一个元素
- enqueue：加入元素到队列
- dequeue：从队列中移除元素

#### (1) Swift 版本的实现
``` Swift
/// 基于数组封装的队列
public struct Queue<T> {
    var array = [T]()
    
    // 是否为空
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    // 元素个数
    public var count: Int {
        return array.count
    }
    
    // 加入队列
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    // 移除队列
    public mutating func dequeue() -> T? {
        if array.isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    // 首元素
    public var front: T? {
        return array.first
    }
    
}

```

#### (2) Objective-C 版本的实现

Queue.h

``` Objective-C
@interface Queue<ObjectType> : NSObject

@property (assign, nonatomic, readonly) NSUInteger count;
@property (assign, nonatomic, readonly) BOOL isEmpty;
@property (strong, nonatomic, readonly) ObjectType front;

- (ObjectType)dequeue;
- (void)enqueueObject:(ObjectType)object;

@end

``` 

Queue.m

``` Objective-C
@interface Queue ()

@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation Queue

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isEmpty {
    return (self.count == 0);
}

- (NSUInteger)count {
    return self.array.count;
}

- (id)front {
    if (self.count == 0) {
        return nil;
    }
    
    return self.array.firstObject;
}

- (id)dequeue {
    if (self.array.count == 0) {
        return nil;
    }
    
    id objectToRemove = self.array.firstObject;
    [self.array removeObjectAtIndex:0];
    
    return objectToRemove;
}

- (void)enqueueObject:(id)object {
    [self.array addObject:object];
}

- (NSString *)description {
    
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"Queue: ["];
    for (id <NSObject> element in self.array) {
        if (element != self.array.firstObject) {
            [string appendString:@", "];
        }
        
        [string appendString:element.description];
    }
    
    [string appendString:@"]"];
    
    return string;
}

@end
```


#### 2. 更高效的队列


借鉴 Swift 中数组末尾预留内存的思路，我们可以 dequeue 时通过在数组前面保留一些空余内存空间，来提高队列的 dequeue 操作的效率。

其核心思想是：当我们从队列中移除一个元素后，我们会通过将这个元素在数组中的位置标记为空，来保证后面的元素在内存中的位置不发生改变。

比如，我们有这样一个数组：

 ```
 [ "Ada", "Steve", "Tim", "Grace", xxx, xxx ]
    head
 ```

移除第一个元素 Ada 后，变成这样：
 
 ```
 [ xxx, "Steve", "Tim", "Grace", xxx, xxx ]
          head
 ```
 
移除第二个元素 Steve 后，就变成这样
 ```
 [ xxx, xxx, "Tim", "Grace", xxx, xxx ]
              head
 ```
 
因为数组前面的空白单元都没有被重用，所以我们可以在某个时间点，再将数组中所有的元素都往前移，然后就变成这样
 ```
 ["Tim", "Grace", xxx, xxx ]
   head
 ```
 这种操作的复杂度为 O(n)，但是因为只是偶尔才出现一次，所以总的复杂度平均下来还是 O(1)。
 

#### (1) Swift 版本的实现
  
``` Swift
/// 更高效的队列
public struct EfficientQueue<T> {
    fileprivate var array = [T?]()   // 数组中的数据类型为 optional，因为会有 nil
    fileprivate var headIndex = 0    // 标记第一个真实元素的位置
    
    
    // 是否为空
    public var isEmpty: Bool {
        return (count == 0)
    }
    
    // 元素个数
    public var count: Int {
        return (array.count - headIndex)
    }
    
    // 加入队列
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    
    // 移除队列
    public mutating func dequeue() -> T? {
        // 异常处理，记录要移除的元素
        guard array.count > headIndex, let elementToRemove = array[headIndex] else {
            return nil
        }
        
        // 移除元素
        array[headIndex] = nil // 将要移除的元素的空间设为 nil
        headIndex += 1         // head 索引加 1
        
        // 定期调整元素位置
        let percentage = Double(headIndex) / Double(array.count)
        let triggerCount = 50
        if array.count > triggerCount, percentage > 0.25 {  //    或者其他条件：    if headIndex > 2 {
            array.removeFirst(headIndex)    // 移除前 headIndex 个元素
            headIndex = 0                   // 重置真实 head 索引值
        }
        
        return elementToRemove
    }
    
    // 首元素
    public var front: T? {
        // 先判断是否为空
        if isEmpty {
            return nil
        } else {
            return array[headIndex]
        }
    }
    
}

```

#### (2) Objective-C 版本的实现
  
EfficientQueue.h

``` Objective-C
@interface EfficientQueue<ObjectType> : NSObject

@property (assign, nonatomic, readonly) NSUInteger count;
@property (assign, nonatomic, readonly) BOOL isEmpty;
@property (strong, nonatomic, readonly) ObjectType front;

- (ObjectType)dequeue;
- (void)enqueueObject:(ObjectType)object;

@end
```

EfficientQueue.m

``` Objective-C

@interface EfficientQueue ()

@property (strong, nonatomic) NSMutableArray *array;
@property (assign, nonatomic) NSInteger headIndex;

@end

@implementation EfficientQueue

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
        _headIndex = 0;
    }
    return self;
}

- (BOOL)isEmpty {
    return (self.count == 0);
}

- (NSUInteger)count {
    return self.array.count - self.headIndex;
}

- (id)front {
    if (self.isEmpty) {
        return nil;
    }
    
    return self.array[self.headIndex];
}

- (id)dequeue {
    if (self.isEmpty) {
        return nil;
    }
    
    // 移除
    id objectToRemove = self.front;
    self.array[self.headIndex] = [NSNull null];
    self.headIndex++;
    
    // 定期清理空值
    double percentage = self.headIndex / (double)(self.array.count);
    if (percentage > 0.25 && self.count > 100) {
        [self.array removeObjectsInRange:NSMakeRange(0, self.headIndex)];
        self.headIndex = 0;
    }
    
    return objectToRemove;
}

- (void)enqueueObject:(id)object {
    [self.array addObject:object];
}

- (NSString *)description {
    
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"EfficientQueue: ["];
    
    for (id <NSObject> element in self.array) {
        if ([element isKindOfClass:[NSNull class]]) {
            continue;
        }
        
        if (element != self.front) {
            [string appendString:@", "];
        }
        
        [string appendString:element.description];
    }
    
    [string appendString:@"]"];
    
    return string;
}

@end
```

### 五、队列的应用
在经典的 iOS 图片下载框架 `SDWebImage` 中，`SDWebImageDownloader` 类里面就通过一个 `executionOrder` 来决定下载队列中下载任务的先后顺序，是 FIFO，还是 LIFO。


### 六、我所理解的队列
- 队列是一种表
- 队列的元素操作顺序是先进先出（FIFO）


### 七、相关面试题（TODO）

### 八、参考资料
- [raywenderlich/swift-algorithm-club/Queue](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Queue)
