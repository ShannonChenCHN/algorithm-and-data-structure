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
    
    Stack stack = CreactStack(5);
    Push(15, stack);
    Push(72, stack);
    Push(23, stack);
    
    printf("%d", Top(stack));
    
    return 0;
}
