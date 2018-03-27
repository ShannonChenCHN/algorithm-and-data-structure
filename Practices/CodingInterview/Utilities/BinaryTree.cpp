//
//  BinaryTree.cpp
//  07_ConstructBinaryTree
//
//  Created by ShannonChen on 2018/3/26.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include "BinaryTree.hpp"


/// 创建二叉树节点
BinaryTreeNode* CreateBinaryTreeNode(int value) {
    
    BinaryTreeNode* pNode = new BinaryTreeNode();
    pNode->m_nValue = value;
    pNode->m_pLeft = nullptr;
    pNode->m_pRight = nullptr;
    
    return pNode;
}

/// 链接二叉树节点
void ConnectTreeNodes(BinaryTreeNode* pParent, BinaryTreeNode* pLeft, BinaryTreeNode* pRight) {
    
    if(pParent != nullptr) {
        pParent->m_pLeft = pLeft;
        pParent->m_pRight = pRight;
    }
}

/// 打印二叉树节点信息
void PrintTreeNode(const BinaryTreeNode* pNode) {
    
    if(pNode != nullptr) {
        // 当前节点
        printf("value of this node is: %d\n", pNode->m_nValue);
        
        // 左子节点
        if(pNode->m_pLeft != nullptr) {
            printf("value of its left child is: %d.\n", pNode->m_pLeft->m_nValue);
        } else {
            printf("left child is nullptr.\n");
        }
        
        // 右子节点
        if(pNode->m_pRight != nullptr) {
            printf("value of its right child is: %d.\n", pNode->m_pRight->m_nValue);
        } else {
            printf("right child is nullptr.\n");
        }
    }
    else {
        printf("this node is nullptr.\n");
    }
    
    printf("\n");
}

/// 打印二叉树（使用先序遍历）
void PrintTree(const BinaryTreeNode* pRoot) {
    
    // 访问当前节点
    PrintTreeNode(pRoot);
    
    
    if(pRoot != nullptr) {
        // 访问左子树
        if(pRoot->m_pLeft != nullptr) {
            PrintTree(pRoot->m_pLeft);
        }
        
        // 访问右子树
        if(pRoot->m_pRight != nullptr) {
            PrintTree(pRoot->m_pRight);
        }
    }
}

/// 销毁二叉树（使用先序遍历）
void DestroyTree(BinaryTreeNode* pRoot) {
    
    if(pRoot != nullptr) {
        
        // 先取出子树
        BinaryTreeNode* pLeft = pRoot->m_pLeft;
        BinaryTreeNode* pRight = pRoot->m_pRight;
        
        // 删除根节点
        delete pRoot;
        pRoot = nullptr;
        
        // 删除子树
        DestroyTree(pLeft);
        DestroyTree(pRight);
    }
}
