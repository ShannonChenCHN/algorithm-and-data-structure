//
//  main.cpp
//  TrieTreeInCPlusPlus
//
//  Created by ShannonChen on 2018/6/26.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//
//  C++ implementation to count words in a trie
//  https://www.geeksforgeeks.org/counting-number-words-trie/


// 1. 定义数节点结构：首先定义一个表征 Trie 节点的数据结构，其实就是一个树的节点，每个节点包括 0~26 个子节点。
//    另外，每个节点有一个变量来记录是否是叶节点。
//
// 2. 插入单词：从前往后依次遍历单词的每一个字符，每位字符对应树的每一层（根节点为空，所以根节点除外），
//    如果树中对应的层中没有该字符，就在这一层中该字符对应的位置（0~25）插入一个节点


#include <iostream>

/// Alphabet size (# of symbols)
#define ALPHABET_SIZE   26

/// Calucate array size
#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])

/// Converts key current character into index
/// use only 'a' through 'z' and lower case
#define CHAR_TO_INDEX(c) ((int)c - (int)'a')


/// Trie node
struct TrieNode {
    TrieNode *children[ALPHABET_SIZE];
    bool isLeaf;
};


/// Returns new trie node (initialized to NULLs)
TrieNode *creatNode(void) {
    TrieNode *pNode = new TrieNode;
    pNode->isLeaf = false;
    
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        pNode->children[i] = nullptr;
    }
    
    return pNode;
}

/// If not present, inserts key into trie
/// If the key is prefix of trie node, just
/// marks leaf node
void insert(TrieNode *pRoot, const char *key) {
    // 1. get the length of the key
    int keyLength = (int)strlen(key);
    
    // 2. iterate the key string, if the character
    // is not presented in the corresponding level,
    // insert a new node.
    TrieNode *pNode = pRoot;
    for (int level = 0; level < keyLength; level++) {
        int indexOfCurrentChar = CHAR_TO_INDEX(key[level]);
        if (pNode->children[indexOfCurrentChar] == nullptr) {
            pNode->children[indexOfCurrentChar] = creatNode();
        } else {
            pNode->children[indexOfCurrentChar]->isLeaf = false;
        }
        
        pNode = pNode->children[indexOfCurrentChar];
    }
    
    // 3. Set the node that doesn't have any children as leaf.
    pNode->isLeaf = true;
    for (int index = 0; index < ALPHABET_SIZE; index++) {
        if (pNode->children[index] != nullptr) {
            pNode->isLeaf = false;
        }
    }
    
}

void printTrie(TrieNode *pRoot) {
    
    // pre-order
    for (int index = 0; index < ALPHABET_SIZE; index++) {
        TrieNode *currentNode = pRoot->children[index];
        
        if (currentNode != nullptr) {
            char rootChar = index + 'a';
            printf("%c", rootChar);
            
            if (currentNode->isLeaf) {
                printf(", ");
            } else {
                printTrie(currentNode);
            }
        }
    }
    
}

int main(int argc, const char * argv[]) {
    
    // Input keys (use only 'a' through 'z' and lower case)
    // The array used to hold input keys is two-dimensional array
    char keys[][8] = {"the", "a", "there", "answer",
        "any", "by", "bye", "their"};
    
    TrieNode *pRoot = creatNode();
    
    // Construct Trie
    for (int i = 0; i < ARRAY_SIZE(keys); i++) {
        insert(pRoot, keys[i]);
    }
    
    printTrie(pRoot);
    
    return 0;
}
