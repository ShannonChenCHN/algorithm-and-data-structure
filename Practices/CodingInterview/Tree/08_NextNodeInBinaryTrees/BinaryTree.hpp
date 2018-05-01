//
//  BinaryTree.hpp
//  08_NextNodeInBinaryTrees
//
//  Created by ShannonChen on 2018/3/28.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#ifndef BinaryTree_hpp
#define BinaryTree_hpp

#include <stdio.h>

/// 二叉树节点（带有指向父节点的指针）
struct BinaryTreeNode {
    int                    m_nValue;
    BinaryTreeNode*        m_pLeft;
    BinaryTreeNode*        m_pRight;
    BinaryTreeNode*        m_pParent;
};


/// 创建二叉树节点
BinaryTreeNode* CreateBinaryTreeNode(int value);

/// 链接二叉树节点
void ConnectTreeNodes(BinaryTreeNode* pParent, BinaryTreeNode* pLeft, BinaryTreeNode* pRight);

/// 打印二叉树节点信息
void PrintTreeNode(const BinaryTreeNode* pNode);

/// 打印二叉树
void PrintTree(const BinaryTreeNode* pRoot);

/// 销毁二叉树
void DestroyTree(BinaryTreeNode* pRoot);

#endif /* BinaryTree_hpp */
