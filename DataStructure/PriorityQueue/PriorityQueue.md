# Priority Queue

> 普通的队列是一种先进先出的数据结构，元素在队列尾追加，而从队列头删除。在优先队列中，元素被赋予优先级。当访问元素时，具有最高优先级的元素最先删除。优先队列具有最高级先出 （first in, largest out）的行为特征。

### 什么是优先队列
- 是一种抽象数据结构（ADT）
- 是一种队列，只是最重要的元素始终位于最前面
- 每个元素都有一个优先级，访问时会根据元素的优先级来按顺序处理，具有最高优先级的元素最先删除

### 如何实现优先队列？
- 有序数组（Sorted Array）
- 二叉查找树（BST）
- 堆

### 优先队列的操作
- Enqueue
- Dequeue
- 找最大/最小值
- 改变元素的优先级


### 应用
- 事件的优先级处理
- 哈弗曼编码（用于数据压缩）
- Dijkstra 算法
- A*路径查找（AI 领域）


### 参考：

- https://github.com/raywenderlich/swift-algorithm-club/tree/master/Priority%20Queue
- https://en.wikipedia.org/wiki/Priority_queue
- 数据结构和算法分析—— C 语言描述
- https://baike.baidu.com/item/优先队列/9354754?fr=aladdin
