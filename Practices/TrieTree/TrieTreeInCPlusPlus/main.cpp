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
//    根节点为空节点，另外，每个节点有一个变量来记录是否是单词词尾节点。
//
// 2. 插入单词：从前往后依次遍历单词的每一个字符，每位字符对应树的每一层（根节点为空，所以根节点除外），
//    如果树中对应的层中没有该字符，就在这一层中该字符对应的位置（0~25）插入一个节点
//
// 3. 打印所有单词：这里可以用先序遍历来实现，核心思路在于记录路径。
//    我们可以用一个数组来保存所有的“浏览”过的路径，如果遇到一个是单词结尾字符的节点，就打印数组中的所有字符。
//
// 4. 查找单词：满足两个条件，一是单词的每个字母都有对应的节点，二是单词末尾字符对应的节点正好是单词结尾节点


#include <iostream>

/// Alphabet size (# of symbols)
#define ALPHABET_SIZE   26

#define MAX_WORD_LENGTH   100

/// Calucate array size
#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])

/// Converts key current character into index
/// use only 'a' through 'z' and lower case
#define CHAR_TO_INDEX(c) ((int)c - (int)'a')




/// Trie node
struct TrieNode {
    TrieNode *children[ALPHABET_SIZE];
    bool isEndOfWord;  // isEndOfWord field is true, if the node represent an end of word. Else, it is false.
};


/// Returns new trie node (initialized to NULLs)
TrieNode *creatNode(void) {
    TrieNode *pNode = new TrieNode;
    pNode->isEndOfWord = false;
    
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
        }
        
        pNode = pNode->children[indexOfCurrentChar];
    }
    
    // 3. while inserting the last node, we also set the value of isEndOfWord to true.
    pNode->isEndOfWord = true;
    
}

void printWord(char *word, int length) {
    
    for (int i = 0; i < length; i++) {
        // we don't use printf("%s") to print string here,
        // because probably the real word we want to print is not equal to this word variable.
        // for example, if the word variable's value is "their", but what we really want to print
        // is "the", so in this case, we don't want to print the whole string.
        printf("%c", word[i]);
    }
    
    printf(", ");
}

void printAllWordsInTheTrie(TrieNode *pRoot, char *wordPath, int level = 0) {
    
    // pre-order
    for (int index = 0; index < ALPHABET_SIZE; index++) {
        TrieNode *currentNode = pRoot->children[index];
        
        if (currentNode != nullptr) {
            
            // Store every character on the tracking path
            char rootChar = index + 'a';
            wordPath[level] = rootChar;
            
            // If this node is the end of a word, print the word
            if (currentNode->isEndOfWord) {
                printWord(wordPath, level+1);
            }
            
            // Recursively tracking
            printAllWordsInTheTrie(currentNode, wordPath, level+1);
        }
    }
    
}

/// Search whether a word is present in the Trie or not.
/// The success case is when there exist a path and the last node in the path is also end-of-word.
bool searchForWordInTrie(const char *key, TrieNode *pRoot) {
    if (pRoot == nullptr) {
        printf("\"%s\" %s", key, "is NOT present in the Trie.");
        return false;
    }
    
    // 遍历整个字符串，如果当前的字符对应的节点为空，则没有找到；
    // 如果单词最后一个字母对应的节点不是单词末尾节点，也是没有找到
    
    bool isKeyPresent = true;
    int keyLength = (int)strlen(key);
    
    TrieNode *pNode = pRoot;
    for (int i = 0; i < keyLength; i++) {
        int index = CHAR_TO_INDEX(key[i]);
        TrieNode *pCurrentNode = pNode->children[index];
        
        if (pCurrentNode == nullptr) {
            isKeyPresent = false;
            break;
        }
        
        if (i == keyLength - 1 && pCurrentNode->isEndOfWord == false) {
            isKeyPresent = false;
            break;
        }
        
        pNode = pCurrentNode;
    }
    
    printf("\"%s\" %s", key, isKeyPresent ? "is present in the Trie." : "is NOT present in the Trie.");
    
    return isKeyPresent;
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
    
    // Print all words in the trie
    char wordPath[MAX_WORD_LENGTH];
    printAllWordsInTheTrie(pRoot, wordPath);
    printf("\n\n");
    
    searchForWordInTrie("the", pRoot);
    printf("\n\n");
    
    searchForWordInTrie("thc", pRoot);
    printf("\n\n");
    
    searchForWordInTrie("there", pRoot);
    printf("\n\n");
    
    return 0;
}
