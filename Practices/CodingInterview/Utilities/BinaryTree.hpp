//
//  BinaryTree.hpp
//  07_ConstructBinaryTree
//
//  Created by ShannonChen on 2018/3/26.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#ifndef BinaryTree_hpp
#define BinaryTree_hpp

#include <stdio.h>


/// 二叉树的一个节点
struct BinaryTreeNode {
    int                    m_nValue;
    BinaryTreeNode*        m_pLeft;    ///< 左子树
    BinaryTreeNode*        m_pRight;   ///< 右子树
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
