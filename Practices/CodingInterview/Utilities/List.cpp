//
//  List.cpp
//  06_PrintListInReversedOrder
//
//  Created by ShannonChen on 2018/3/26.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include "List.hpp"
#include <stdlib.h>

/// 创建链表节点
ListNode* CreateListNode(int value) {
    ListNode *pNode = new ListNode();
    pNode->m_nValue = value;
    pNode->m_pNext = nullptr;
    
    return pNode;
}

/// 连接链表节点
void ConnectListNodes(ListNode* pCurrent, ListNode* pNext) {
    if(pCurrent == nullptr)
    {
        printf("Error to connect two nodes.\n");
        exit(1);
    }
    
    pCurrent->m_pNext = pNext;
}

/// 打印链表节点
void PrintListNode(ListNode* pNode) {
    if(pNode == nullptr)
    {
        printf("The node is nullptr\n");
    }
    else
    {
        printf("The key in node is %d.\n", pNode->m_nValue);
    }
}

/// 打印链表
void PrintList(ListNode* pHead) {
    printf("PrintList starts.\n");
    
    ListNode* pNode = pHead;
    while(pNode != nullptr)
    {
        printf("%d\t", pNode->m_nValue);
        pNode = pNode->m_pNext;
    }
    
    printf("\nPrintList ends.\n");
}

/// 销毁链表
void DestroyList(ListNode* pHead) {
    ListNode* pNode = pHead;
    while(pNode != nullptr)
    {
        pHead = pHead->m_pNext;
        
        // C++ 中动态分配内存，需要手动管理 http://www.runoob.com/cplusplus/cpp-dynamic-memory.html
        delete pNode;  // 释放内存
        pNode = pHead;
    }
}

/// 添加新节点到尾部
void AddToTail(ListNode** pHead, int value) {
    ListNode *pNew = new ListNode();
    pNew->m_nValue = value;
    pNew->m_pNext = nullptr;
    
    if (*pHead == nullptr) {
        // 如果指向 pHead 的指针是空的，说明链表为空
        // 注！！：这里 pHead 参数用的是指向头指针的指针，因为如果向一个空链表中插入新节点时，新节点就是头指针。
        // **由于此时需要修改“传递进来”的头指针**，所以必须要把 pHead 参数设为指向指针的指针，否则，除了这个函数的作用域，*pHead 仍然是一个空指针，因为参数传递进来的指针是复制的一份指针变量。
        //
        // 比如要通过函数来改变一个 NSString 对象的值，传入的参数只能是指向对象地址的指针的地址
        //
        // void change(NSString **string) {
        //     *string = @"newString";
        // }
        //
        // NSString *string = @"originalString";
        // change(&string);
        
        *pHead = pNew;
    } else {
        
        ListNode *pNode = *pHead;
        while (pNode->m_pNext != nullptr) {
            pNode = pNode->m_pNext;
        }
        
        pNode->m_pNext = pNew;
    }
}

/// 移除节点：重新连接节点，释放内存
void RemoveNode(ListNode** pHead, int value) {
    
    ListNode *nodeToRemove = nullptr;
    
    // 如果是头指针要修改
    if ((*pHead)->m_nValue == value) {
        nodeToRemove = *pHead;
        *pHead = (*pHead)->m_pNext;
    } else {
        
        ListNode *node = *pHead; // 从头指针开始找
        while (node->m_pNext != nullptr) {
            
            if (node->m_pNext->m_nValue == value) { // 找到了
                nodeToRemove = node->m_pNext;
                node->m_pNext = node->m_pNext->m_pNext;
                break;
            }
            
            node = node->m_pNext;
        }
    }
    
    if (nodeToRemove != nullptr) {
        delete nodeToRemove;
        nodeToRemove = nullptr;
    }
}
