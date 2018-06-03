//
//  main.cpp
//  09_QueueWithTwoStacks
//
//  Created by ShannonChen on 2018/3/27.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>

#include "Queue.hpp"

// ====================测试代码====================
void Test(char actual, char expected) {
    if(actual == expected) {
        printf("Test passed.\n");
    } else {
        printf("Test failed.\n");
    }
}

int main(int argc, const char * argv[]) {
    
    
    CQueue<char> queue;
    
    queue.appendTail('a');
    queue.appendTail('b');
    queue.appendTail('c');
    
    char head = queue.deleteHead();
    Test(head, 'a');
    
    head = queue.deleteHead();
    Test(head, 'b');
    
    queue.appendTail('d');
    head = queue.deleteHead();
    Test(head, 'c');
    
    queue.appendTail('e');
    head = queue.deleteHead();
    Test(head, 'd');
    
    head = queue.deleteHead();
    Test(head, 'e');
    
    return 0;
}
