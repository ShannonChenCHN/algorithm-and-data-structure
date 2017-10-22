
# 栈（Stack）

### 一、什么是栈？
栈是一种类似于数组的数据结构，但是其功能有限。

你只能通过 push 来给添加新元素到栈顶，通过 pop 来移除栈顶的元素，以及通过 top 来读取栈顶的元素。


### 二、栈的特点
栈可以保证元素存入和取出的顺序是后进先出(last-in first-out, LIFO)的。
你最近一次 push 到栈中的元素，就是你接下来 pop 操作时会从栈中移除的元素。

> 延伸：有一种与栈非常类似的数据结构是队列，队列的存取操作规则是先进先出（first-in first-out, FIFO）。

### 三、栈模型：图形表示

#### 1. 通过 push 向栈输入，通过 pop 和 top 从栈中输出

```
   Pop(S)    ╔═══════════╗     Push(X, S)
<----------  ║  Stack S  ║ <-------------
   Top(S)    ╚═══════════╝
```

#### 2. 只有栈顶的元素是可以访问的

```
   Top
-------> ║   6    ║
         ╠════════╣
         ║   72   ║
         ╠════════╣
         ║   37   ║
         ╠════════╣
         ║   52   ║
         ╚════════╝
```

### 四、栈的实现

#### 1. 实现思路
因为栈实际上是一个表，因此任何实现表的方法都能实现栈。

目前有两种实现栈的常用方式：
- 使用指针
- 使用数组

#### 2. 使用指针实现(TODO)

#### 3. 使用数组实现

##### 3.1 C 版本

源码请戳 [这里](https://github.com/ShannonChenCHN/DataStructure-Algorithm-Notes/tree/master/Stack)。

Stack.h
``` C 

#ifndef Stack_h
#define Stack_h

#include <stdio.h>


struct StackRecord;
typedef struct StackRecord *Stack;
typedef int ElementType;


Stack CreateStack(int MaxElements);
void DisposeStack(Stack S);

int IsEmpty(Stack S);
int IsFull(Stack S);
void MakeEmpty(Stack S);

void Push(ElementType X, Stack S);
void Pop(Stack S);
ElementType Top(Stack S);
ElementType TopAndPop(Stack S);


#endif /* Stack_h */

```

Stack.c
``` C
#include "Stack.h"
#include "stdlib.h"

#define Error( Str )        FatalError( Str )
#define FatalError( Str )   fprintf( stderr, "%s\n", Str ), exit( 1 )


#define EmptyTOS        (-1)
#define MinStackSize    (5)


/**
 栈的声明
 */
struct StackRecord
{
    int Capacity;
    int TopOfStack;
    ElementType *Array;
};



/**
 栈的创建

 @param MaxElements 栈的最大容量
 @return <#return value description#>
 */
Stack CreateStack(int MaxElements)
{
    Stack S;
    
    if (MaxElements < MinStackSize)
    {
        Error("Stack size is too small");
    }
    
    S = malloc(sizeof(struct StackRecord));
    if (S == NULL)
    {
        FatalError("Out of space");
    }
    
    S->Array = malloc(sizeof(ElementType) * MaxElements);
    if (S->Array == NULL)
    {
        FatalError("Out of space");
    }
    
    S->Capacity = MaxElements;
    
    MakeEmpty(S);
    
    return S;
}


void DisposeStack(Stack S)
{
    if (S != NULL)
    {
        free(S->Array);
        free(S);
    }
    
}

int IsEmpty(Stack S)
{
    return S->TopOfStack == EmptyTOS;
}


int IsFull(Stack S)
{
    return S->TopOfStack == (MinStackSize - 1);
}
void MakeEmpty(Stack S)
{
    S->TopOfStack = EmptyTOS;
}

void Push(ElementType X, Stack S)
{
    if (IsFull(S))
    {
        Error("Full Stack");
    }
    else
    {
        S->Array[++S->TopOfStack] = X;
    }
}

void Pop(Stack S)
{
    if (IsEmpty(S))
    {
        Error("Empty stack");
    }
    else
    {
        S->TopOfStack--;
    }
}

ElementType Top(Stack S)
{
    if (!IsEmpty(S))
    {
        return S->Array[S->TopOfStack];
    }
    
    Error("Empty stack");
    
    return 0; // return value used to avoid warning
}

ElementType TopAndPop(Stack S)
{
    if (!IsEmpty(S))
    {
        return S->Array[S->TopOfStack--];
    }
    
    Error("Empty stack");
    
    return 0; // return value used to avoid warning
}

```

##### 3.2 Swift 版本
栈在 Swift 中的实现非常容易。只需要包装一下自带的数组，将存取功能限制为 pop、push 和 peek 即可。

源码请戳 [这里](https://github.com/ShannonChenCHN/DataStructure-Algorithm-Notes/tree/master/Stack)。

``` Swift
struct Stack <T> {
    
    // MARK: Properties
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var top: T? {
        return array.last
    }
    
    public var count: Int {
        return array.count
    }
    
    // MARK: Methods
    public mutating func push(_ newElement: T) {
        array.append(newElement)
    }
    
    // pop 最后一个元素，有可能为空
    public mutating func pop() -> T? {
        return array.popLast()
    }

}

// 实现 Sequence 协议，以支持 for - in 循环遍历
extension Stack: Sequence {
    
    public func makeIterator() -> AnyIterator<T> {
        var curr = self
        
        return AnyIterator {
            return curr.pop()
        }
    }
}

```

#### 3.3 Objective-C 版本

源码请戳 [这里](https://github.com/ShannonChenCHN/DataStructure-Algorithm-Notes/tree/master/Stack)

``` Objective-C
@interface SCStack<__covariant ObjectType> : NSObject <NSFastEnumeration>

@property (nonatomic, readonly, nullable) ObjectType top;
@property (nonatomic, readonly) BOOL isEmpty;
@property (nonatomic, readonly) NSUInteger count;

// Push a new object into stack
- (void)push:(nonnull ObjectType)newObject;

// If the stack is empty, returns nil.
- (nullable ObjectType)pop;


@end

@interface SCStack ()

@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation SCStack

#pragma mark - Life Cycle
- (instancetype)init {
    
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Operation
- (void)push:(id)newObject {
    
    if (newObject) {
        [self.array addObject:newObject];
    }
    
}

- (nullable id)pop {
    
    id lastObject = self.array.lastObject;
    
    [self.array removeLastObject];
    
    return lastObject;
}


#pragma mark - Getter

- (nullable id)top {
    return self.array.lastObject;
}

- (NSUInteger)count {
    return self.array.count;
}

- (BOOL)isEmpty {
    return (self.array.count == 0);
}

#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id  _Nullable __unsafe_unretained [])buffer count:(NSUInteger)len {
    return [self.array countByEnumeratingWithState:state objects:buffer count:len];
}

@end

```

### 五、复杂度

- 栈的 push 和 pop 操作的复杂度为 O(1)

push 操作是将新元素压入数组的尾部，而不是头部。
在数组的头部插入元素是一个很耗时的操作，它的时间复杂度为 O(n)，因为需要将现有元素往后移位为新元素腾出空间。
而在尾部插入元素的时间复杂度为 O(1)；无论数组有多少元素，这个操作所消耗的时间都是一个常量。

- 通常栈是一个不考虑排序的数据结构，所以从栈中找出最大或者最小的元素的时间复杂度为 O(n)

### 六、栈的应用

#### 1. 函数的调用

操作系统会给每个线程创建一个栈用来存储函数调用时各个函数的参数、返回地址及临时变量。

所以每次你调用函数或方法，CPU 会将函数参数、返回地址及临时变量压入到运行栈中。当这个函数执行结束的时候，CPU 将返回地址从栈中取出，并据此返回到函数被调用的位置。所以，如果不断地调用太多的函数(例如死递归函数)，就会得到一个所谓的“栈溢出(stack overflow)” 错误，因为 CPU 运行栈没有空间了。

我们在 Xcode 上断点调试时，可以看到函数/方法的调用栈：
![](https://github.com/ShannonChenCHN/DataStructure-Algorithm-Notes/blob/master/Resources/stack_01.png?raw=true)

#### 2. iOS 应用中的 [UINavigationController](https://developer.apple.com/documentation/uikit/uinavigationcontroller)

> A navigation controller object manages the currently displayed screens using the navigation stack, which is represented by an array of view controllers. 

iOS 应用中的 UINavigationController 也是一个栈的结构，每次新 push 一个 controller 就相当于新添加一个 controller 到栈顶，每次 pop 操作时，都是将栈顶的 controller 移除掉。

从 UINavigationController 提供的 API 也可以看出栈的身影：
``` Swift
// Uses a horizontal slide transition. Has no effect if the view controller is already in the stack.
open func pushViewController(_ viewController: UIViewController, animated: Bool)

// Returns the popped controller.
open func popViewController(animated: Bool) -> UIViewController? 

// Pops view controllers until the one specified is on top. Returns the popped controllers.
open func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]?

// Pops until there's only a single view controller left on the stack. Returns the popped controllers.
open func popToRootViewController(animated: Bool) -> [UIViewController]?

 // The top view controller on the stack.
open var topViewController: UIViewController? { get }
```

### 七、我所理解的栈
- 栈是一种表
- 栈的存取规则是**后进先出**
- 通常只能访问栈顶的元素
- 通常栈只支持 push，pop，top 操作
- 栈可以用数组实现，也可以用指针（单链表）实现
- 栈的 push，pop，top 操作的时间复杂度为 O(1)，从栈中找出最大或者最小的元素的时间复杂度为 O(n)
- 每次我们调用函数或方法，CPU 会将函数参数、返回地址及临时变量压入到运行栈中，执行结束时，再从栈中取出来

### 参考资料
- [ksco/swift-algorithm-club-cn](https://github.com/ksco/swift-algorithm-club-cn/tree/master/Stack)
- 剑指 Offer
- 数据结构与算法分析：C 语言描述
- [UINavigationController - UIKit | Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uinavigationcontroller)