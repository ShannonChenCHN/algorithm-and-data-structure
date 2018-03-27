//
//  Queue.hpp
//  09_QueueWithTwoStacks
//
//  Created by ShannonChen on 2018/3/27.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#ifndef Queue_hpp
#define Queue_hpp


// 第9题：用两个栈实现队列
// 题目：用两个栈实现一个队列。队列的声明如下，请实现它的两个函数appendTail
// 和deleteHead，分别完成在队列尾部插入结点和在队列头部删除结点的功能。
 
/*
 
 | c |  |   |       |   |  | a |       |   |  |   |
 | b |  |   |       |   |  | b |       |   |  | b |
 | a |  |   |       |   |  | c |       |   |  | c |
 +---+  +---+       +---+  +---+       +---+  +---+
   a,b,c  入列           a 出列             a 出列
 
 |   |  |   |       |   |  |   |
 |   |  | b |       |   |  |   |
 | d |  | c |       | d |  | c |
 +---+  +---+       +---+  +---+
    d 入列              b 出列
 
规律：
 - 入列时只添加到左边的栈中
 - 出列时只删除右边的栈顶的数据，如果右边没有，就先将左边栈中的元素都转移到右边，然后再删除右边的栈顶的数据
 
 */

#include <stdio.h>
#include <stack>
#include <exception>

using namespace std;

template <typename T>
class CQueue {
    
public:
    CQueue(void);
    ~CQueue(void);
    
    // 在队列末尾添加一个结点
    void appendTail(const T& node);
    
    // 删除队列的头结点
    T deleteHead();
    
    void printQueue();
    
private:
    stack<T> stack1;
    stack<T> stack2;
};

template <typename T>
CQueue<T>::CQueue(void) {
    
}

template <typename T>
CQueue<T>::~CQueue(void) {
}

/// 入列
template <typename T>
void CQueue<T>::appendTail(const T& node) {
    
    // 入列时只添加到左边的栈中
    stack1.push(node);
}

/// 出列
template <typename T>
T CQueue<T>::deleteHead() {
    
    // 出列时只删除右边的栈顶的数据，如果右边没有，就先将左边栈中的元素都转移到右边，然后再删除右边的栈顶的数据
    
    // 如果右边的栈为空
    if (stack2.size() <= 0) {
        
        // 将左边的栈中都搬到右边的栈
        while (stack1.size() > 0) {
            
            T& top = stack1.top();  // 这里使用引用类型，是因为 stack 的 push 方法只接受引用类型的参数
            stack1.pop();
            stack2.push(top);
        }
    }
    
    if (stack2.size() == 0) {
        throw exception();  // "queue is empty"
    }
    
    // 删除右边的栈顶的数据
    T head = stack2.top();
    stack2.pop();
    
    return head;
    
}


#endif /* Queue_hpp */
