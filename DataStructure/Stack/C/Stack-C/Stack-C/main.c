//
//  main.c
//  Stack-C
//
//  Created by ShannonChen on 2017/9/25.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#include <stdio.h>
#include "Stack.h"

int main(int argc, const char * argv[]) {
    
    printf("Hello, World!\n");
    
    Stack stack = CreateStack(5);
    
    Push(15, stack);            // [15]
    printf("Top of Stack: %d \n", Top(stack));
    
    Push(72, stack);            // [15, 72]
    printf("Top of Stack: %d \n", Top(stack));
    
    Push(23, stack);            // [15, 72, 23]
    printf("Top of Stack: %d \n", Top(stack));
    
    
    Pop(stack);                 // [15, 72]
    printf("Top of Stack: %d \n", Top(stack));
    
    
    Pop(stack);                 // [15]
    printf("Top of Stack: %d \n", Top(stack));
    
    
    printf("Top of Stack: %d \n", TopAndPop(stack)); // []
    
    printf("Top of Stack: %d \n", Top(stack));
    
    return 0;
}
