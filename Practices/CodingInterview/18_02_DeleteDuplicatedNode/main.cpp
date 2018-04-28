//
//  main.cpp
//  18_02_DeleteDuplicatedNode
//
//  Created by ShannonChen on 2018/4/28.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>
#include "List.hpp"

// 第 18（二）题：删除链表中重复的结点
// 题目：在一个排序的链表中，如何删除重复的结点？例如，在图3.4（a）中重复
// 结点被删除之后，链表如图3.4（b）所示。

/*
 
 第一种情况：
 1 -> 2 -> 4 -> 4 -> 5
 
 1 -> 2 -> 5
 
 第二种情况：
 
 1 -> 1
 
 删除后变成空链表
 
 第三种情况：
 
 1 -> 2 -> 4 -> 4 -> 4 -> 5
 
 1 -> 2 -> 5
 
 第四种情况：
 
 1 -> 2 -> 4 -> 4 -> 5 -> 5
 
 1 -> 2
 
 从头结点开始往后找，找到重复的节点后，标记一下需要删除，再看后面的节点是否还有重复的，最后将重复部分的前一个节点和后一个节点连接起来
 所以，这里需要记录一下前一个节点
 
       1  ->   2   ->  4   ->   4   ->   4   ->   5
  ↑    ↑       ↑
last  cur     next
 
       1  ->   2   ->  4   ->   4   ->   4   ->   5
       ↑       ↑       ↑
      last    cur     next
 
       1  ->   2   ->  4   ->   4   ->   4   ->   5
               ↑       ↑        ↑
              last    cur      next
 
       1  ->   2   ->  4   ->   4   ->   4   ->   5
               ↑       ×        ↑
              last    del      next
 
       1  ->   2   ->  4   ->   4   ->   4   ->   5
               ↑       ×        ×        ↑
             last              del      next
 
 */

void DeleteDuplicatedNodes(ListNode** pListHead) {
    
    ListNode* pCurrentNode = *pListHead;
    
    ListNode* pLastNode = nullptr; // 记录上一个不重复的节点
    
    while (pCurrentNode != nullptr) { // 从头结点开始
        
        
        // 先看看当前节点和下一个节点是否重复
        ListNode* pNextNode = pCurrentNode->m_pNext;
        bool needsDelete = false;
        if (pNextNode != nullptr && pCurrentNode->m_nValue == pNextNode->m_nValue) {
            needsDelete = true;
        }
        
        if (needsDelete) {
            // 有重复的
            
            int value = pCurrentNode->m_nValue;
            ListNode* pToBeDeletedNode = pCurrentNode; // 从重复部分的第一个节点开始删
            while (pToBeDeletedNode != nullptr && pToBeDeletedNode->m_nValue == value) { // 要删除节点必须满足的条件：不为空、值重复
                pNextNode = pToBeDeletedNode->m_pNext; // 更新 next 指针的位置

                delete pToBeDeletedNode; // 删除节点
                
                pToBeDeletedNode = pNextNode; // 尝试删除下一个节点
            }
            
            if (pLastNode == nullptr) { // 删除了头结点
                *pListHead = pNextNode;
            } else {
                pLastNode->m_pNext = pNextNode;
            }
            
            pCurrentNode = pNextNode;
            
        } else {
            // 没有重复的
            
            pLastNode = pCurrentNode;
            pCurrentNode = pNextNode;
        }
        
    }
    
}

void Test(const char* testName, ListNode* pListHead) {
    
    if (testName != nullptr) {
        printf("Test Begin: %s. \n\n", testName);
    }
    
    PrintList(pListHead);
    
    DeleteDuplicatedNodes(&pListHead);
    
    PrintList(pListHead);
    
    printf("\n=====================\n");
}


void Test1() {
    ListNode* pNode1 = CreateListNode(1);
    ListNode* pNode2 = CreateListNode(2);
    ListNode* pNode3 = CreateListNode(3);
    ListNode* pNode4 = CreateListNode(3);
    ListNode* pNode5 = CreateListNode(5);
    
    ConnectListNodes(pNode1, pNode2);
    ConnectListNodes(pNode2, pNode3);
    ConnectListNodes(pNode3, pNode4);
    ConnectListNodes(pNode4, pNode5);
    
    Test(__FUNCTION__, pNode1);
}


void Test2() {
    ListNode* pNode1 = CreateListNode(1);
    ListNode* pNode2 = CreateListNode(1);
    
    ConnectListNodes(pNode1, pNode2);
    
    Test(__FUNCTION__, pNode1);
}


void Test3() {
    ListNode* pNode1 = CreateListNode(1);
    ListNode* pNode2 = CreateListNode(3);
    ListNode* pNode3 = CreateListNode(3);
    ListNode* pNode4 = CreateListNode(3);
    ListNode* pNode5 = CreateListNode(5);
    
    ConnectListNodes(pNode1, pNode2);
    ConnectListNodes(pNode2, pNode3);
    ConnectListNodes(pNode3, pNode4);
    ConnectListNodes(pNode4, pNode5);
    
    Test(__FUNCTION__, pNode1);
}

void Test4() {
    ListNode* pNode1 = CreateListNode(1);
    ListNode* pNode2 = CreateListNode(3);
    ListNode* pNode3 = CreateListNode(3);
    ListNode* pNode4 = CreateListNode(4);
    ListNode* pNode5 = CreateListNode(5);
    ListNode* pNode6 = CreateListNode(5);
    ListNode* pNode7 = CreateListNode(6);
    
    ConnectListNodes(pNode1, pNode2);
    ConnectListNodes(pNode2, pNode3);
    ConnectListNodes(pNode3, pNode4);
    ConnectListNodes(pNode4, pNode5);
    ConnectListNodes(pNode5, pNode6);
    ConnectListNodes(pNode6, pNode7);
    
    Test(__FUNCTION__, pNode1);
}


void Test5() {
 
    Test(__FUNCTION__, nullptr);
}

void Test6() {
    ListNode* pNode1 = CreateListNode(1);
    
    Test(__FUNCTION__, pNode1);
}

void Test7() {
    ListNode* pNode1 = CreateListNode(1);
    ListNode* pNode2 = CreateListNode(2);
    ListNode* pNode3 = CreateListNode(3);
    ListNode* pNode4 = CreateListNode(4);
    ListNode* pNode5 = CreateListNode(5);
    
    ConnectListNodes(pNode1, pNode2);
    ConnectListNodes(pNode2, pNode3);
    ConnectListNodes(pNode3, pNode4);
    ConnectListNodes(pNode4, pNode5);
    
    Test(__FUNCTION__, pNode1);
}


int main(int argc, const char * argv[]) {
    
    Test1();
    Test2();
    Test3();
    Test4();
    Test5();
    Test6();
    Test7();
    
    return 0;
}
