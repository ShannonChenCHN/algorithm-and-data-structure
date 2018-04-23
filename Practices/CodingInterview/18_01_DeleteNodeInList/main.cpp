//
//  main.cpp
//  18_01_DeleteNodeInList
//
//  Created by ShannonChen on 2018/4/23.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>

// 第 18.1 题：在O(1)时间删除链表结点
// 题目：给定单向链表的头指针和一个结点指针，定义一个函数在O(1)时间删除该结点。
//

/*
 方案一：先从头结点遍历到要删除的节点的前一个节点，然后再删除该节点，并将前一个节点的 next 指针指向要删除的节点的下一个节点。
 
 时间效率为 O(n)，不符合要求。
 
 方案二：用要删除的节点的下一个节点的值覆盖要删除的节点的值，然后再将要删除的节点的 next 指针指向要删除的节点的下下个节点。
 
 时间效率为 O(1)。
 
 */

int main(int argc, const char * argv[]) {
    
    return 0;
}
