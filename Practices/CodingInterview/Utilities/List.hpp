//
//  List.hpp
//  06_PrintListInReversedOrder
//
//  Created by ShannonChen on 2018/3/26.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#ifndef List_hpp
#define List_hpp

#include <stdio.h>

/// 链表节点
struct ListNode {
    int       m_nValue;
    ListNode *m_pNext;
};

/// 创建链表节点
ListNode* CreateListNode(int value);

/// 连接链表节点
void ConnectListNodes(ListNode* pCurrent, ListNode* pNext);

/// 打印链表节点
void PrintListNode(ListNode* pNode);

/// 打印链表
void PrintList(ListNode* pHead);

/// 销毁链表
void DestroyList(ListNode* pHead);

/// 添加新节点到尾部
void AddToTail(ListNode** pHead, int value);

/// 移除节点
void RemoveNode(ListNode** pHead, int value);

#endif /* List_hpp */
