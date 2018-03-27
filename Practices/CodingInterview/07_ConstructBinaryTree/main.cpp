//
//  main.cpp
//  07_ConstructBinaryTree
//
//  Created by ShannonChen on 2018/3/26.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>

// 第7题：重建二叉树
// 题目：输入某二叉树的前序遍历和中序遍历的结果，请重建出该二叉树。假设输
// 入的前序遍历和中序遍历的结果中都不含重复的数字。例如输入前序遍历序列{1,
// 2, 4, 7, 3, 5, 6, 8}和中序遍历序列{4, 7, 2, 1, 5, 3, 8, 6}，则重建出
// 下图所示的二叉树并输出它的头结点。
//        1
//       /  \
//      2    3
//     /    /  \
//    4    5    6
//     \       /
//      7     8


/*
 
 前序遍历（根-左-右，所以根节点一定在最前面）
 中序遍历（左-根-右，所以根节点左边一定是左子树，右边一定是右子树）
 
前序遍历：  {1, | 2, 4, 7, | 3, 5, 6, 8}    根-左-右（1是根节点）
中序遍历：  {4, 7, 2, | 1, | 5, 3, 8, 6}    左-根-右
 
             左子树                         右子树
前序遍历： {2, | 4, 7} （2是根节点）     {3, | 5, | 6, 8}  （3是根节点）
中序遍历： {4, 7, | 2}                 {5, | 3,| 8, 6}
 
          左子树                           左子树        右子树
前序遍历： {4,| 7}   （4是根节点）             {5}        {6,| 8}  （6是根节点）
中序遍历： {4,| 7}   （7是右节点）             {5}        {8, | 6}  （8是左节点）
 
 
 
 测试用例：
 
 - 错误处理：需要考虑两个数组中节点（根节点和叶节点）匹配不上的情况
 
 */

#include "BinaryTree.hpp"
#include <exception>
using namespace std;

/**
 @param startPreorder 指向前序遍历起点位置的指针
 @param endPreorder 指向前序遍历终点位置的指针
 @param startInorder 指向中序遍历起点位置的指针
 @param endInorder 指向中序遍历终点位置的指针
 @return 二叉树
 */
BinaryTreeNode* ConstructCore(int* startPreorder, int* endPreorder, int* startInorder, int* endInorder);

BinaryTreeNode* Construct(int* preorder, int* inorder, int length) {
    
    if (preorder == nullptr || inorder == nullptr || length <= 0) {
        return nullptr;
    }
    
    return ConstructCore(preorder, preorder + length - 1, inorder, inorder + length - 1);
    
}

BinaryTreeNode* ConstructCore(int* startPreorder, int* endPreorder, int* startInorder, int* endInorder) {
    
    // 1. 构建根节点
    // 先序遍历的第一个元素就是根节点
    int rootValue = startPreorder[0];
    BinaryTreeNode* rootNode = new BinaryTreeNode();
    rootNode->m_nValue = rootValue;
    rootNode->m_pLeft = nullptr;
    rootNode->m_pRight = nullptr;
    
    // 如果只有根节点
    if (startPreorder == endPreorder) {
        if (startInorder == endInorder &&      // 中序遍历指针符合要求
            *startPreorder == *startInorder) { // 先序遍历和中序遍历的值相同
            // 错误处理：判断一致性（叶节点，也就是没有子节点的节点）
            
            return rootNode;
        } else {
            
            throw exception();
        }
    }
    
    
    // 2. 构建左右子树
    
    // 2.1 计算左右子树的长度，找出左右子树在先序遍历数组中的区间
    // 2.1.1 找到根节点在中序遍历数组中的位置
    int indxOfRootInInorder = 0;
    while (startInorder + indxOfRootInInorder <= endInorder) {
        
        if (startInorder[indxOfRootInInorder] == rootValue) {
            break;
        }
        
        indxOfRootInInorder++;
    }
    
    // 错误处理：如果在中序遍历数组中找不到根节点
    if (startInorder + indxOfRootInInorder > endInorder) {
        throw exception();
    }
    
    // 2.1.2 计算左右子树的长度
    int arrayCount = (int)(endPreorder - startPreorder) + 1;
    int lengthOfLeftChild = indxOfRootInInorder;
    int lengthOfRightChild = arrayCount - lengthOfLeftChild - 1;
    
    // 2.2 构建左子树
    if (lengthOfLeftChild > 0) {
        int *leftStartPreorder = startPreorder + 1;
        int *leftEndPreorder = startPreorder + lengthOfLeftChild;
        int *leftStartInorder = startInorder;
        int *leftEndInorder = startInorder + lengthOfLeftChild - 1;
        rootNode->m_pLeft = ConstructCore(leftStartPreorder, leftEndPreorder, leftStartInorder, leftEndInorder);
    }
    
    // 2.3 构建右子树
    if (lengthOfRightChild > 0) {
        int *rightStartPreorder = startPreorder + lengthOfLeftChild + 1;
        int *rightEndPreorder = endPreorder;
        int *rightStartInorder = startInorder + lengthOfLeftChild + 1;
        int *rightEndInorder = endInorder;
        rootNode->m_pRight = ConstructCore(rightStartPreorder, rightEndPreorder, rightStartInorder, rightEndInorder);
    }
    
    return rootNode;

}

// ====================测试代码====================
void Test(const char* testName, int* preorder, int* inorder, int length) {
    
    if(testName != nullptr) {
        printf("%s begins:\n", testName);
    }
    
    printf("The preorder sequence is: ");
    
    for(int i = 0; i < length; ++ i) {
        printf("%d ", preorder[i]);
    }
    
    printf("\n");
    
    printf("The inorder sequence is: ");
    
    for(int i = 0; i < length; ++ i) {
        printf("%d ", inorder[i]);
    }
    printf("\n");
    
    try {
        BinaryTreeNode* root = Construct(preorder, inorder, length);
        PrintTree(root);
        
        DestroyTree(root);
    }
    catch(exception& exception)
    {
        printf("Invalid Input.\n");
    }
    
    printf("\n\n========================\n\n");
}

// 普通二叉树
//              1
//           /     \
//          2       3
//         /       / \
//        4       5   6
//         \         /
//          7       8
void Test1() {
    const int length = 8;
    int preorder[length] = {1, 2, 4, 7, 3, 5, 6, 8};
    int inorder[length] = {4, 7, 2, 1, 5, 3, 8, 6};
    
    Test("Test1", preorder, inorder, length);
}

// 所有结点都没有右子结点
//            1
//           /
//          2
//         /
//        3
//       /
//      4
//     /
//    5
void Test2() {
    const int length = 5;
    int preorder[length] = {1, 2, 3, 4, 5};
    int inorder[length] = {5, 4, 3, 2, 1};
    
    Test("Test2", preorder, inorder, length);
}

// 所有结点都没有左子结点
//            1
//             \
//              2
//               \
//                3
//                 \
//                  4
//                   \
//                    5
void Test3() {
    const int length = 5;
    int preorder[length] = {1, 2, 3, 4, 5};
    int inorder[length] = {1, 2, 3, 4, 5};
    
    Test("Test3", preorder, inorder, length);
}

// 树中只有一个结点
void Test4() {
    const int length = 1;
    int preorder[length] = {1};
    int inorder[length] = {1};
    
    Test("Test4", preorder, inorder, length);
}

// 完全二叉树
//              1
//           /     \
//          2       3
//         / \     / \
//        4   5   6   7
void Test5() {
    const int length = 7;
    int preorder[length] = {1, 2, 4, 5, 3, 6, 7};
    int inorder[length] = {4, 2, 5, 1, 6, 3, 7};
    
    Test("Test5", preorder, inorder, length);
}

// 输入空指针
void Test6() {
    Test("Test6", nullptr, nullptr, 0);
}

// 输入的两个序列不匹配
void Test7() {
    const int length = 7;
    int preorder[length] = {1, 2, 4, 5, 3, 6, 7};
    int inorder[length] = {4, 2, 8, 1, 6, 3, 7};
    
    Test("Test7: for unmatched input", preorder, inorder, length);
}

// 输入的两个序列不匹配
void Test8() {
    const int length = 7;
    int preorder[length] = {1, 2, 4, 5, 3, 6, 7};
    int inorder[length] = {4, 2, 8, 8, 6, 3, 7};
    
    Test("Test7: for unmatched input", preorder, inorder, length);
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
    
    return 0;
}
