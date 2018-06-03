//
//  main.cpp
//  18_01_DeleteNodeInList
//
//  Created by ShannonChen on 2018/4/23.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>
#include "List.hpp"

// 第 18.1 题：在O(1)时间删除链表结点
// 题目：给定单向链表的头指针和一个结点指针，定义一个函数在O(1)时间删除该结点。
//

/*
 方案一：先从头结点遍历到要删除的节点的前一个节点，然后再删除该节点，并将前一个节点的 next 指针指向要删除的节点的下一个节点。
 
 时间效率为 O(n)，不符合要求。
 
 方案二：用要删除的节点的下一个节点的值覆盖要删除的节点的值，然后再将要删除的节点的 next 指针指向要删除的节点的下下个节点。
 
 时间效率为 O(1)。
 
 */


/*
 
 情形1. 要删除的不是最后一个节点；
 情形2. 链表只有一个节点；
 情形3. 要删除的是链表的最后一个节点；
 
 */
void DeleteNode(ListNode** pListHead, ListNode* pTobeDeleted) {
    
    if (*pListHead == nullptr || pTobeDeleted == nullptr) {
        return;
    }
    
    if (pTobeDeleted->m_pNext != nullptr) { // 要删除的节点后面不为空
        
        // 链表结构：a -> b -> -c- -> d -> e
        //         a -> b ->  d   -----> e
        
        ListNode* pNextNode = pTobeDeleted->m_pNext;
        pTobeDeleted->m_nValue = pNextNode->m_nValue;
        pTobeDeleted->m_pNext = pNextNode->m_pNext;
    
        delete pNextNode;
        pNextNode = nullptr;
        
    } else if (*pListHead == pTobeDeleted) { // 只有一个节点
        
        // 链表结构：a
        // 直接删除头节点
        
        delete pTobeDeleted;
        *pListHead = nullptr;
        pTobeDeleted = nullptr;
        
    } else { // 要删除的是最后一个节点
        
        // 链表结构：a -> b -> c -> -d-
        // 需要找到要删除节点的前一个节点
        
        ListNode* pLastNode = *pListHead;
        while (pLastNode->m_pNext != pTobeDeleted) {
            pLastNode = pLastNode->m_pNext;
        }
        
        pLastNode->m_pNext = nullptr;
        
        delete pTobeDeleted;
        pTobeDeleted = nullptr;
    }
    
}

// ======================== 测试代码 ==========================================

void Test(const char* testName, ListNode* pListHead, ListNode* pTobeDeleted) {
    if (testName != nullptr) {
        printf("Test Begin: %s. \n\n", testName);
    }
    
    printf("\nThe original list is: \n");
    PrintList(pListHead);
    
    printf("\nThe node to be deleted is: \n");
    PrintListNode(pTobeDeleted);
    
    DeleteNode(&pListHead, pTobeDeleted);
    
    printf("\nThe result list is: \n");
    PrintList(pListHead);
    
    printf("Test End. \n\n");
    
    printf("===================== \n\n");
    
}

// 链表中有多个结点，删除中间的结点
void Test1() {
    ListNode* pNode1 = CreateListNode(1);
    ListNode* pNode2 = CreateListNode(2);
    ListNode* pNode3 = CreateListNode(3);
    ListNode* pNode4 = CreateListNode(4);
    ListNode* pNode5 = CreateListNode(5);
    
    ConnectListNodes(pNode1, pNode2);
    ConnectListNodes(pNode2, pNode3);
    ConnectListNodes(pNode3, pNode4);
    ConnectListNodes(pNode4, pNode5);
    
    Test(__FUNCTION__, pNode1, pNode3);
}

// 链表中有多个结点，删除的是尾节点
void Test2() {
    ListNode* pNode1 = CreateListNode(1);
    ListNode* pNode2 = CreateListNode(2);
    ListNode* pNode3 = CreateListNode(3);
    ListNode* pNode4 = CreateListNode(4);
    ListNode* pNode5 = CreateListNode(5);
    
    ConnectListNodes(pNode1, pNode2);
    ConnectListNodes(pNode2, pNode3);
    ConnectListNodes(pNode3, pNode4);
    ConnectListNodes(pNode4, pNode5);
    
    Test(__FUNCTION__, pNode1, pNode5);
}

// 链表中有多个结点，删除头结点
void Test3() {
    ListNode* pNode1 = CreateListNode(1);
    ListNode* pNode2 = CreateListNode(2);
    ListNode* pNode3 = CreateListNode(3);
    ListNode* pNode4 = CreateListNode(4);
    ListNode* pNode5 = CreateListNode(5);
    
    ConnectListNodes(pNode1, pNode2);
    ConnectListNodes(pNode2, pNode3);
    ConnectListNodes(pNode3, pNode4);
    ConnectListNodes(pNode4, pNode5);
    
    Test(__FUNCTION__, pNode1, pNode1);
}

// 链表只有一个节点
void Test4() {
    ListNode* pNode1 = CreateListNode(1);
    
    Test(__FUNCTION__, pNode1, pNode1);
}

// 链表为空
void Test5() {
    Test(__FUNCTION__, nullptr, nullptr);
}

int main(int argc, const char * argv[]) {
    
    
    Test1();
    Test2();
    Test3();
    Test4();
    Test5();
    
    return 0;
}
