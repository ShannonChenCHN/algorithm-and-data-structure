//: Playground - noun: a place where people can play

import UIKit

/*
 
 ### 一、什么是哈希表？
 散列表（Hash table，也叫哈希表），是根据键（Key）而直接访问在内存存储位置的数据结构。
 
 也就是说，它通过计算一个关于键值的函数，将所需查询的数据映射到表中一个位置来访问记录，这加快了查找速度。这个映射函数称做散列函数，存放记录的数组称做散列表。
 
 ### 二、哈希表能干嘛？
 哈希表能用来实现 `Dictionary`、 `Map` 和 `Associative Array` 等数据结构，这些数据结构可以通过树或者普通的数组来实现，但是用哈希表来实现会更有效率。
 
 这也就解释了为什么 Swift 的标准库中的 `Dictionary` 的 key 必须要遵循 `Hashable` 协议了，因为 `Dictionary` 就是基于哈希表实现的。
 
 ### 三、哈希表的实现原理
 
 哈希表本质上是一个数组。当我们通过 key 来访问哈希表时，它会用这个 key 计算出它在数组中的索引。
 
 比如，我们往一个哈希表中存入一个 key 为 `firstName` 的字符串，通过散列函数计算，作为 key 的 firstName 映射到数组中的索引是 3。
 
 哈希表是如何根据 key 来计算出其对应的索引值的呢？
 当我们写下下面这行代码时，哈希表会通过“散列法”来计算出这个 key 对应的索引值 ———— 哈希表会先通过字符串 `"firstName"` 的 hashValue 属性，获取其哈希值，然后再用这个值的绝对值除以数组大小并取余，最后得到的余数就是这个 key 在数组中对应的索引。
 
 ```
 hashTable["firstName"] = "Steve"

 
 The hashTable array:
 +--------------+
 | 0:           |
 +--------------+
 | 1:           |
 +--------------+
 | 2:           |
 +--------------+
 | 3: firstName |---> Steve
 +--------------+
 | 4:           |
 +--------------+
 
 ```
 
 这种计算索引的方式让 Dictionary 更高效，因为对 Dictionary 的所有操作的耗时都是常量，插入、读取、删除元素的复杂度都是 O(1)。
 
 
 ### 四、处理冲突
 
 上面的这种计算索引的方式可能会造成冲突，也就是说，当我们获取 key 的哈希值再除以数组大小并取余时，有可能出现计算不同的 key 值却得到一样的索引，这就是冲突。
 
 理论上，冲突是无法避免的。
 
 #### 解决冲突的方法
 
 解决冲突的方法有以下几种：
 - 开放定址法（Open Address）：如果在插入新元素到计算出来的索引出现冲突时，就插入到索引下一个没有被使用的位置。比如，要插入一个新元素到索引 2 的位置，但是出现了冲突，然后就看索引为 3 的位置是否为空，如果为空，就插入到索引为 3 的位置，否则，就继续往后找。这种方式的最大缺点就是有可能会出现聚集现象 ———— 在函数地址的表中，散列函数的结果不均匀地占据表的单元，形成区块，造成线性探测产生一次聚集（primary clustering）和平方探测的二次聚集（secondary clustering），散列到区块中的任何关键字需要查找多次试选单元才能插入表中，解决冲突，造成时间浪费。对于开放定址法，聚集会造成性能的灾难性损失，是必须避免的。
 - 单独链表法（Chaining）：将散列到同一个存储位置的所有元素保存在一个链表中。实现时，一种策略是散列表同一位置的所有冲突结果都是用栈存放的，新元素被插入到表的前端还是后端完全取决于怎样方便。
 - 双散列：
 - 再散列：
 - 建立一个公共溢出区
 
 #### 单独链表法
 
 现在假设 key 值为 firstName 和 lastName 映射的索引值都为 3，这就出现了冲突。
 
 使用单独链表法时，数组中的单个元素不再只是存储单个 key-value 数据了，而是存储一个装有一组 key-value 数据的列表。此时，数组中的元素被称为 bucket，每个元素中的列表被称为 chain。这个 chain 通常是用一个链表或者数组，而且它对顺序没有要求。
 
 假如现在我们要从下面图中所示的哈希表中获取 key 为 lastName 的元素，哈希表会首先计算 lastName 对应的索引值为 3，然后再找出 chain 中字符串值和 lastName 相等的 key，这样就得到了目标元素。
 

 
 
 ```
 buckets:
 +-----+
 |  0  |
 +-----+     +----------------------------+
 |  1  |---> | hobbies: Programming Swift |
 +-----+     +----------------------------+
 |  2  |
 +-----+     +------------------+     +----------------+
 |  3  |---> | firstName: Steve |---> | lastName: Jobs |
 +-----+     +------------------+     +----------------+
 |  4  |
 +-----+
 ```
 
 从哈希表中元素的个数与 bucket 个数之比（load factor）可以看出哈希表的性能，这个比例越大，性能可能就越差，因为这很可能意味着哈希表中的 chain 比较长了，所以当 load factor 大于 1 时，我们就需要通过扩大哈希表的容量来进行优化了。
 
 不过，需要注意的是，一旦改变了哈希表的容量，哈希表中的 key 所映射的索引也会跟着改变。所以，当我们扩大哈希表的容量后，需要重新将原来的 key-value 元素添加到扩容后的哈希表中。
 
 
 ### 五、哈希表的实现
 
 四个基本功能：增删改查
 
 */


public struct HashTable<Key: Hashable, Value> {
    
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]
    
    private(set) public var count = 0
    
    public var isEmpty: Bool {
        return (count == 0)
    }
    
    // 这里用的是一个固定大小的数组来存储
    public init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeatElement([], count: capacity))
    }
    
    // 根据 key 计算 index
    fileprivate func index(forKey key: Key) -> Int {
        return abs(key.hashValue) % buckets.count
    }
    
    
    // 查
    public func value(forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        
        for element in buckets[index] {
            if element.key == key {
                return element.value
            }
        }
        
        return nil
    }
    
    // 增、改
    public mutating func updateValue(value: Value, forKey key: Key) -> Value? {
        // 计算索引
        let index = self.index(forKey: key)
        
        // 判断 Bucket 是否已经有这个 key 了
        // 这里需要做一个遍历，是比较费时的，所以我们要保证 buckets 尽量小
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                let oldValue = element.value
                buckets[index][i].value = value
                return oldValue
                
            }
        }
        
        // 如果 Bucket 中不存在同样的 key，就填到后面
        buckets[index].append((key: key, value: value))
        count += 1
        
        return nil
    }
    
    // 删除
    public mutating func removeValue(forKey key: Key) ->Value? {
        // 计算索引
        let index = self.index(forKey: key)
        
        // 从 Bucket 找到这个 key
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                buckets[index].remove(at: i)
                count -= 1
                return element.value
            }
        }
        
        // 没找到
        return nil
        
    }
    
    // 下标访问
    public subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        
        set {
            
            // 当 bucket 中的元素变多时，就需要重新调整表的大小，以优化性能
            resize()
            
            if let value = newValue {
                updateValue(value: value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }
    
    
    private func resize() {
        
        let loadFactor = Double(count) / Double(buckets.count)
        if loadFactor > 0.75 {
            // 建一个新容器
            // 将原来的内容插入到
            // MARK: TODO
        }
    }
}


var hashTable = HashTable<String, String>.init(capacity: 5)









