//
//  Stack.h
//  Stack-C
//
//  Created by ShannonChen on 2017/9/25.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#ifndef Stack_h
#define Stack_h

#include <stdio.h>


struct StackRecord;
typedef struct StackRecord *Stack;
typedef int ElementType;


Stack CreactStack(int MaxElements);
void DisposeStack(Stack S);

int IsEmpty(Stack S);
int IsFull(Stack S);
void MakeEmpty(Stack S);

void Push(ElementType X, Stack S);
void Pop(Stack S);
ElementType Top(Stack S);
ElementType TopAndPop(Stack S);


#endif /* Stack_h */
