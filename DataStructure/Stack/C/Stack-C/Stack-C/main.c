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
    
    Push(15, stack);
    printf("Top of Stack: %d \n", Top(stack));
    
    Push(72, stack);
    printf("Top of Stack: %d \n", Top(stack));
    
    Push(23, stack);
    printf("Top of Stack: %d \n", Top(stack));
    
    
    Pop(stack);
    printf("Top of Stack: %d \n", Top(stack));
    
    
    Pop(stack);
    printf("Top of Stack: %d \n", Top(stack));
    
    
    Pop(stack);
    printf("Top of Stack: %d \n", Top(stack));
    
    return 0;
}
