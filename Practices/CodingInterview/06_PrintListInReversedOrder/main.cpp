//
//  main.cpp
//  06_PrintListInReversedOrder
//
//  Created by ShannonChen on 2018/3/26.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>
#include <stack>
#include "List.hpp"

using namespace std;

int main(int argc, const char * argv[]) {
    
    ListNode *node = CreateListNode(5);
//    cout << node->m_nValue << endl;
    AddToTail(&node, 7);
    AddToTail(&node, 12);
    PrintList(node);
    RemoveNode(&node, 7);
    PrintList(node);
    
    return 0;
}
