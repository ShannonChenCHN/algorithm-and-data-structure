//
//  main.cpp
//  06_PrintListInReversedOrder
//
//  Created by ShannonChen on 2018/3/26.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>
#include <stack>
#include "List.hpp"

using namespace std;

// 第6题：从尾到头打印链表
// 题目：输入一个链表的头结点，从尾到头反过来打印出每个结点的值。

/*
 
 方案一：
 
 递归调用
 
 方案二：
 
 利用栈结构“先进后出”的特点
 
 方案三：
 翻转链表，再遍历
 
 */

/// 利用栈结构“先进后出”的特点
void PrintListReversingly_Iteratively(ListNode* pHead) {
    
    stack<ListNode*> nodes;
    
    // 先一个一个入栈
    ListNode* pNode = pHead;
    while(pNode != nullptr) {
        nodes.push(pNode);
        pNode = pNode->m_pNext;
    }
    
    // 然后再一个一个出栈
    while(!nodes.empty()) {
        pNode = nodes.top();
        printf("%d\t", pNode->m_nValue);
        nodes.pop();
    }
}

/// 递归调用函数
void PrintListReversingly_Recursively(ListNode* pHead) {
    if(pHead != nullptr)    {
        if (pHead->m_pNext != nullptr) {
            PrintListReversingly_Recursively(pHead->m_pNext);
        }
        
        printf("%d\t", pHead->m_nValue);
    }
}

// ====================测试代码====================
void Test(ListNode* pHead) {
    PrintList(pHead);
    PrintListReversingly_Iteratively(pHead);
    printf("\n");
    PrintListReversingly_Recursively(pHead);
}

// 1->2->3->4->5
void Test1() {
    
    printf("\nTest1 begins.\n");
    
    ListNode* pNode1 = CreateListNode(1);
    ListNode* pNode2 = CreateListNode(2);
    ListNode* pNode3 = CreateListNode(3);
    ListNode* pNode4 = CreateListNode(4);
    ListNode* pNode5 = CreateListNode(5);
    
    ConnectListNodes(pNode1, pNode2);
    ConnectListNodes(pNode2, pNode3);
    ConnectListNodes(pNode3, pNode4);
    ConnectListNodes(pNode4, pNode5);
    
    Test(pNode1);
    
    DestroyList(pNode1);
}

// 只有一个结点的链表: 1
void Test2() {
    printf("\nTest2 begins.\n");
    
    ListNode* pNode1 = CreateListNode(1);
    
    Test(pNode1);
    
    DestroyList(pNode1);
}

// 空链表
void Test3() {
    printf("\nTest3 begins.\n");
    
    Test(nullptr);
}



int main(int argc, const char * argv[]) {
    
//    ListNode *node = CreateListNode(5);
//    AddToTail(&node, 7);
//    AddToTail(&node, 12);
//    PrintList(node);
//    RemoveNode(&node, 7);
//    PrintList(node);
    
    Test1();
    Test2();
    Test3();
    
    return 0;
}
