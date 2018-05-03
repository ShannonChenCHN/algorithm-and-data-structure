//
//  main.cpp
//  26_SubstructureInTree
//
//  Created by ShannonChen on 2018/4/30.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>
#include "BinaryTree.hpp"

/*
 第26题：树的子结构
 题目：输入两棵二叉树A和B，判断B是不是A的子结构。
 
 1. 先中序遍历 A 树，找到与 B 树根节点相同的节点；
 2. 中序遍历递归比对 A 树和 B 树的节点是否是父子树的关系；
 3. 如果不是子树，就继续遍历 A 树，找出下一个与 B 树根节点相同的节点。然后再重复第 2 步。
 
 需要考虑两棵树分别为空的情况。
 
 为什么选择中序遍历？
 因为直接从根节点开始更直观？
 实际上不论采用哪种遍历方式，都会得到一个序列，只要遍历两棵树的方式相同，而且以序列的第一个元素为起点去对比，就一定能得出结果。
 
 
 */


// 对比两棵树
bool DoesTreeAContainsTreeB(BinaryTreeNode* pTreeANode, BinaryTreeNode* pTreeBNode) {
    if (pTreeBNode == nullptr) {
        return true;
    }
    
    if (pTreeANode == nullptr) {
        return false;
    }
    
    if (pTreeANode->m_nValue != pTreeBNode->m_nValue) {
        return false;
    }
    
    if (!DoesTreeAContainsTreeB(pTreeANode->m_pLeft, pTreeBNode->m_pLeft)) {
        return false;
    }
    
    if (!DoesTreeAContainsTreeB(pTreeANode->m_pRight, pTreeBNode->m_pRight)) {
        return false;
    }
    
    return true;
}

// 遍历 A 树
bool HasSubtree(BinaryTreeNode* pTreeANode, BinaryTreeNode* pTreeBNode) {
    if (pTreeANode == nullptr || pTreeBNode == nullptr) {
        return false;
    }
    
    // 根-左-右
    bool isSubtree = false;
    
    isSubtree = DoesTreeAContainsTreeB(pTreeANode, pTreeBNode);
    
    if (!isSubtree) {
        isSubtree = HasSubtree(pTreeANode->m_pLeft, pTreeBNode);
    }
    
    if (!isSubtree) {
        isSubtree = HasSubtree(pTreeANode->m_pRight, pTreeBNode);
    }
    
    return isSubtree;
}


// ====================测试代码====================

void Test(const char* testName, BinaryTreeNode* pTreeARoot, BinaryTreeNode* pTreeBRoot, bool expected) {
    if(testName != nullptr) {
        printf("Test %s begins\n", testName);
    }
    
    if (HasSubtree(pTreeARoot, pTreeBRoot) == expected) {
        printf("%s passed.\n", testName);
    } else {
        printf("%s failed.\n", testName);
    }
    
    printf("\n\n========================\n\n");
}



// 树中结点含有分叉，树B是树A的子结构
//                  8                8
//              /       \           / \
//             8         7         9   2
//           /   \
//          9     2
//               / \
//              4   7
void Test1() {
    
    BinaryTreeNode* pNodeA1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeA2 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeA3 = CreateBinaryTreeNode(7);
    BinaryTreeNode* pNodeA4 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeA5 = CreateBinaryTreeNode(2);
    BinaryTreeNode* pNodeA6 = CreateBinaryTreeNode(4);
    BinaryTreeNode* pNodeA7 = CreateBinaryTreeNode(7);
    
    ConnectTreeNodes(pNodeA1, pNodeA2, pNodeA3);
    ConnectTreeNodes(pNodeA2, pNodeA4, pNodeA5);
    ConnectTreeNodes(pNodeA5, pNodeA6, pNodeA7);
    
    BinaryTreeNode* pNodeB1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeB2 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeB3 = CreateBinaryTreeNode(2);
    
    ConnectTreeNodes(pNodeB1, pNodeB2, pNodeB3);
    
    Test("Test1", pNodeA1, pNodeB1, true);
    
    DestroyTree(pNodeA1);
    DestroyTree(pNodeB1);
}

// 树中结点含有分叉，树B不是树A的子结构
//                  8                8
//              /       \           / \
//             8         7         9   2
//           /   \
//          9     3
//               / \
//              4   7
void Test2() {
    
    BinaryTreeNode* pNodeA1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeA2 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeA3 = CreateBinaryTreeNode(7);
    BinaryTreeNode* pNodeA4 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeA5 = CreateBinaryTreeNode(3);
    BinaryTreeNode* pNodeA6 = CreateBinaryTreeNode(4);
    BinaryTreeNode* pNodeA7 = CreateBinaryTreeNode(7);
    
    ConnectTreeNodes(pNodeA1, pNodeA2, pNodeA3);
    ConnectTreeNodes(pNodeA2, pNodeA4, pNodeA5);
    ConnectTreeNodes(pNodeA5, pNodeA6, pNodeA7);
    
    BinaryTreeNode* pNodeB1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeB2 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeB3 = CreateBinaryTreeNode(2);
    
    ConnectTreeNodes(pNodeB1, pNodeB2, pNodeB3);
    
    Test("Test2", pNodeA1, pNodeB1, false);
    
    DestroyTree(pNodeA1);
    DestroyTree(pNodeB1);
}

// 树中结点只有左子结点，树B是树A的子结构
//                8                  8
//              /                   /
//             8                   9
//           /                    /
//          9                    2
//         /
//        2
//       /
//      5
void Test3() {
    BinaryTreeNode* pNodeA1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeA2 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeA3 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeA4 = CreateBinaryTreeNode(2);
    BinaryTreeNode* pNodeA5 = CreateBinaryTreeNode(5);
    
    ConnectTreeNodes(pNodeA1, pNodeA2, nullptr);
    ConnectTreeNodes(pNodeA2, pNodeA3, nullptr);
    ConnectTreeNodes(pNodeA3, pNodeA4, nullptr);
    ConnectTreeNodes(pNodeA4, pNodeA5, nullptr);
    
    BinaryTreeNode* pNodeB1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeB2 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeB3 = CreateBinaryTreeNode(2);
    
    ConnectTreeNodes(pNodeB1, pNodeB2, nullptr);
    ConnectTreeNodes(pNodeB2, pNodeB3, nullptr);
    
    Test("Test3", pNodeA1, pNodeB1, true);
    
    DestroyTree(pNodeA1);
    DestroyTree(pNodeB1);
}

// 树中结点只有左子结点，树B不是树A的子结构
//                8                  8
//              /                   /
//             8                   9
//           /                    /
//          9                    3
//         /
//        2
//       /
//      5
void Test4() {
    BinaryTreeNode* pNodeA1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeA2 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeA3 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeA4 = CreateBinaryTreeNode(2);
    BinaryTreeNode* pNodeA5 = CreateBinaryTreeNode(5);
    
    ConnectTreeNodes(pNodeA1, pNodeA2, nullptr);
    ConnectTreeNodes(pNodeA2, pNodeA3, nullptr);
    ConnectTreeNodes(pNodeA3, pNodeA4, nullptr);
    ConnectTreeNodes(pNodeA4, pNodeA5, nullptr);
    
    BinaryTreeNode* pNodeB1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeB2 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeB3 = CreateBinaryTreeNode(3);
    
    ConnectTreeNodes(pNodeB1, pNodeB2, nullptr);
    ConnectTreeNodes(pNodeB2, pNodeB3, nullptr);
    
    Test("Test4", pNodeA1, pNodeB1, false);
    
    DestroyTree(pNodeA1);
    DestroyTree(pNodeB1);
}

// 树中结点只有右子结点，树B是树A的子结构
//       8                   8
//        \                   \
//         8                   9
//          \                   \
//           9                   2
//            \
//             2
//              \
//               5
void Test5() {
    BinaryTreeNode* pNodeA1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeA2 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeA3 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeA4 = CreateBinaryTreeNode(2);
    BinaryTreeNode* pNodeA5 = CreateBinaryTreeNode(5);
    
    ConnectTreeNodes(pNodeA1, nullptr, pNodeA2);
    ConnectTreeNodes(pNodeA2, nullptr, pNodeA3);
    ConnectTreeNodes(pNodeA3, nullptr, pNodeA4);
    ConnectTreeNodes(pNodeA4, nullptr, pNodeA5);
    
    BinaryTreeNode* pNodeB1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeB2 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeB3 = CreateBinaryTreeNode(2);
    
    ConnectTreeNodes(pNodeB1, nullptr, pNodeB2);
    ConnectTreeNodes(pNodeB2, nullptr, pNodeB3);
    
    Test("Test5", pNodeA1, pNodeB1, true);
    
    DestroyTree(pNodeA1);
    DestroyTree(pNodeB1);
}

// 树A中结点只有右子结点，树B不是树A的子结构
//       8                   8
//        \                   \
//         8                   9
//          \                 / \
//           9               3   2
//            \
//             2
//              \
//               5
void Test6() {
    BinaryTreeNode* pNodeA1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeA2 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeA3 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeA4 = CreateBinaryTreeNode(2);
    BinaryTreeNode* pNodeA5 = CreateBinaryTreeNode(5);
    
    ConnectTreeNodes(pNodeA1, nullptr, pNodeA2);
    ConnectTreeNodes(pNodeA2, nullptr, pNodeA3);
    ConnectTreeNodes(pNodeA3, nullptr, pNodeA4);
    ConnectTreeNodes(pNodeA4, nullptr, pNodeA5);
    
    BinaryTreeNode* pNodeB1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeB2 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeB3 = CreateBinaryTreeNode(3);
    BinaryTreeNode* pNodeB4 = CreateBinaryTreeNode(2);
    
    ConnectTreeNodes(pNodeB1, nullptr, pNodeB2);
    ConnectTreeNodes(pNodeB2, pNodeB3, pNodeB4);
    
    Test("Test6", pNodeA1, pNodeB1, false);
    
    DestroyTree(pNodeA1);
    DestroyTree(pNodeB1);
}

// 树A为空树
void Test7() {
    BinaryTreeNode* pNodeB1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeB2 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeB3 = CreateBinaryTreeNode(3);
    BinaryTreeNode* pNodeB4 = CreateBinaryTreeNode(2);
    
    ConnectTreeNodes(pNodeB1, nullptr, pNodeB2);
    ConnectTreeNodes(pNodeB2, pNodeB3, pNodeB4);
    
    Test("Test7", nullptr, pNodeB1, false);
    
    DestroyTree(pNodeB1);
}

// 树B为空树
void Test8() {
    BinaryTreeNode* pNodeA1 = CreateBinaryTreeNode(8);
    BinaryTreeNode* pNodeA2 = CreateBinaryTreeNode(9);
    BinaryTreeNode* pNodeA3 = CreateBinaryTreeNode(3);
    BinaryTreeNode* pNodeA4 = CreateBinaryTreeNode(2);
    
    ConnectTreeNodes(pNodeA1, nullptr, pNodeA2);
    ConnectTreeNodes(pNodeA2, pNodeA3, pNodeA4);
    
    Test("Test8", pNodeA1, nullptr, false);
    
    DestroyTree(pNodeA1);
}

// 树A和树B都为空
void Test9() {
    Test("Test9", nullptr, nullptr, false);
}

int main(int argc, const char * argv[]) {
    
    Test1();
    Test2();
    Test3();
    Test4();
    Test5();
    Test6();
    Test7();
    Test8();
    Test9();
    
    return 0;
}
