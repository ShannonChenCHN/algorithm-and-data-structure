//
//  main.cpp
//  08_NextNodeInBinaryTrees
//
//  Created by ShannonChen on 2018/3/27.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>
#include "BinaryTree.hpp"

// 第8题：二叉树的下一个结点
// 题目：给定一棵二叉树和其中的一个结点，如何找出**中序遍历**顺序的下一个结点？
// 树中的结点除了有两个分别指向左右子结点的指针以外，还有一个指向父结点的指针。

/*
 
       a
     /   \
    b     c
   / \   / \
  d   e f   g
     / \
    h   i
   /
  j
 
 [d, b, j, h, e, i, a, f, c, g]
 
 规律：
 中序遍历的特点是左-根-右。
 
 
 
 1.如果一个节点有右子树，那么它的下一个节点就是右子树的最左边的节点。
 （b 的下一个节点是 j，a 的下一个节点是 f，e 的下一个节点是 i，c 的下一个节点时 g）
 
 2.如果一个节点么有右子树，就看它自己是不是左子树。
      2.1 如果它自己是左子树，那么下一个就是它的父节点；
         （d 的下一个节点是 b，j 的下一个节点是 h，h 的下一个节点是 e，f 的下一个节点是 c）
 
      2.2 如果它自己不是左子树，那么沿着父节点的指针一直往上找，直到一个作为左子节点的节点。
          （i 的下一个节点是 a）
 
 */

BinaryTreeNode* GetNext(BinaryTreeNode* pNode) {
    if (pNode == nullptr) {
        return nullptr;
    }
    
    BinaryTreeNode *pNextNode = nullptr;
    if (pNode->m_pRight != nullptr) {
        // 如果一个节点有右子树
        
        BinaryTreeNode *pRightNode = pNode->m_pRight;
        while (pRightNode->m_pLeft != nullptr) {
            pRightNode = pRightNode->m_pLeft;
        }
        
        pNextNode = pRightNode;
    }
    else {
        if (pNode->m_pParent == nullptr) {
            // 根节点
            
            pNextNode = nullptr;
            
        } else {
            // 不是根节点
            
            BinaryTreeNode *pCurrentNode = pNode;
            BinaryTreeNode *pParentNode = pNode->m_pParent;
            while (pParentNode != nullptr) {
                if (pParentNode->m_pLeft == pCurrentNode) break;
                pCurrentNode = pParentNode;
                pParentNode = pParentNode->m_pParent;
            }
            
            pNextNode = pParentNode;
            
        }
    }
    
    return pNextNode;
}

// ====================测试代码====================
void Test(const char* testName, BinaryTreeNode* pNode, BinaryTreeNode* expected) {
    if(testName != nullptr)
        printf("%s begins: ", testName);
    
    BinaryTreeNode* pNext = GetNext(pNode);
    if(pNext == expected)
        printf("Passed.\n");
    else
        printf("FAILED.\n");
}

//            8
//        6      10
//       5 7    9  11
void Test1_7() {
    BinaryTreeNode* pNode8 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNode6 = CreateBinaryTreeNode(6);
    BinaryTreeNode* pNode10 = CreateBinaryTreeNode(10);
    BinaryTreeNode* pNode5 = CreateBinaryTreeNode(5);
    BinaryTreeNode* pNode7 = CreateBinaryTreeNode(7);
    BinaryTreeNode* pNode9 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNode11 = CreateBinaryTreeNode(11);
    
    ConnectTreeNodes(pNode8, pNode6, pNode10);
    ConnectTreeNodes(pNode6, pNode5, pNode7);
    ConnectTreeNodes(pNode10, pNode9, pNode11);
    
    Test("Test1", pNode8, pNode9);
    Test("Test2", pNode6, pNode7);
    Test("Test3", pNode10, pNode11);
    Test("Test4", pNode5, pNode6);
    Test("Test5", pNode7, pNode8);
    Test("Test6", pNode9, pNode10);
    Test("Test7", pNode11, nullptr);
    
    DestroyTree(pNode8);
}

//            5
//          4
//        3
//      2
void Test8_11() {
    BinaryTreeNode* pNode5 = CreateBinaryTreeNode(5);
    BinaryTreeNode* pNode4 = CreateBinaryTreeNode(4);
    BinaryTreeNode* pNode3 = CreateBinaryTreeNode(3);
    BinaryTreeNode* pNode2 = CreateBinaryTreeNode(2);
    
    ConnectTreeNodes(pNode5, pNode4, nullptr);
    ConnectTreeNodes(pNode4, pNode3, nullptr);
    ConnectTreeNodes(pNode3, pNode2, nullptr);
    
    Test("Test8", pNode5, nullptr);
    Test("Test9", pNode4, pNode5);
    Test("Test10", pNode3, pNode4);
    Test("Test11", pNode2, pNode3);
    
    DestroyTree(pNode5);
}

//        2
//         3
//          4
//           5
void Test12_15() {
    BinaryTreeNode* pNode2 = CreateBinaryTreeNode(2);
    BinaryTreeNode* pNode3 = CreateBinaryTreeNode(3);
    BinaryTreeNode* pNode4 = CreateBinaryTreeNode(4);
    BinaryTreeNode* pNode5 = CreateBinaryTreeNode(5);
    
    ConnectTreeNodes(pNode2, nullptr, pNode3);
    ConnectTreeNodes(pNode3, nullptr, pNode4);
    ConnectTreeNodes(pNode4, nullptr, pNode5);
    
    Test("Test12", pNode5, nullptr);
    Test("Test13", pNode4, pNode5);
    Test("Test14", pNode3, pNode4);
    Test("Test15", pNode2, pNode3);
    
    DestroyTree(pNode2);
}

void Test16() {
    BinaryTreeNode* pNode5 = CreateBinaryTreeNode(5);
    
    Test("Test16", pNode5, nullptr);
    
    DestroyTree(pNode5);
}

int main(int argc, const char * argv[]) {
    
    Test1_7();
    Test8_11();
    Test12_15();
    Test16();
    
    return 0;
}
