//
//  BinaryTree.cpp
//  08_NextNodeInBinaryTrees
//
//  Created by ShannonChen on 2018/3/28.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include "BinaryTree.hpp"



BinaryTreeNode* CreateBinaryTreeNode(int value) {
    
    BinaryTreeNode* pNode = new BinaryTreeNode();
    pNode->m_nValue = value;
    pNode->m_pLeft = nullptr;
    pNode->m_pRight = nullptr;
    pNode->m_pParent = nullptr;
    
    return pNode;
}


void ConnectTreeNodes(BinaryTreeNode* pParent, BinaryTreeNode* pLeft, BinaryTreeNode* pRight) {
    if(pParent != nullptr) { // 访问 pParent 指针前确保其不为空
        pParent->m_pLeft = pLeft;
        pParent->m_pRight = pRight;
        
        if(pLeft != nullptr) {
            pLeft->m_pParent = pParent;
        }
        if(pRight != nullptr) {
            pRight->m_pParent = pParent;
        }
    }
}

void PrintTreeNode(BinaryTreeNode* pNode) {
    if(pNode != nullptr) {
        
        // 打印当前节点的值
        printf("value of this node is: %d\n", pNode->m_nValue);
        
        // 打印左子树
        if(pNode->m_pLeft != nullptr) {
            printf("value of its left child is: %d.\n", pNode->m_pLeft->m_nValue);
        } else {
            printf("left child is null.\n");
        }
        
        // 打印右子树
        if(pNode->m_pRight != nullptr) {
            printf("value of its right child is: %d.\n", pNode->m_pRight->m_nValue);
        } else {
            printf("right child is null.\n");
        }
    }
    else {
        printf("this node is null.\n");
    }
    
    printf("\n");
}


void PrintTree(BinaryTreeNode* pRoot) {
    // 打印当前节点
    PrintTreeNode(pRoot);
    
    if(pRoot != nullptr) {
        // 递归打印左子树
        if(pRoot->m_pLeft != nullptr) {
            PrintTree(pRoot->m_pLeft);
        }
        
        // 递归打印右子树
        if(pRoot->m_pRight != nullptr) {
            PrintTree(pRoot->m_pRight);
        }
    }
}

void DestroyTree(BinaryTreeNode* pRoot) {
    
    if(pRoot != nullptr) {
        // 保存左右子树
        BinaryTreeNode* pLeft = pRoot->m_pLeft;
        BinaryTreeNode* pRight = pRoot->m_pRight;
        
        // 删除根节点
        delete pRoot;
        pRoot = nullptr;
        
        // 递归删除左右子树
        DestroyTree(pLeft);
        DestroyTree(pRight);
    }
}
