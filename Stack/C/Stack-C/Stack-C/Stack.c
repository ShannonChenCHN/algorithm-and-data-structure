//
//  Stack.c
//  Stack-C
//
//  Created by ShannonChen on 2017/9/25.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#include "Stack.h"
#include "stdlib.h"

#define Error( Str )        FatalError( Str )
#define FatalError( Str )   fprintf( stderr, "%s\n", Str ), exit( 1 )


#define EmptyTOS        (-1)
#define MinStackSize    (5)


/**
 栈的声明
 */
struct StackRecord
{
    int Capacity;
    int TopOfStack;
    ElementType *Array;
};



/**
 栈的创建

 @param MaxElements 栈的最大容量
 @return <#return value description#>
 */
Stack CreateStack(int MaxElements)
{
    Stack S;
    
    if (MaxElements < MinStackSize)
    {
        Error("Stack size is too small");
    }
    
    S = malloc(sizeof(struct StackRecord));
    if (S == NULL)
    {
        FatalError("Out of space");
    }
    
    S->Array = malloc(sizeof(ElementType) * MaxElements);
    if (S->Array == NULL)
    {
        FatalError("Out of space");
    }
    
    S->Capacity = MaxElements;
    
    MakeEmpty(S);
    
    return S;
}


void DisposeStack(Stack S)
{
    if (S != NULL)
    {
        free(S->Array);
        free(S);
    }
    
}

int IsEmpty(Stack S)
{
    return S->TopOfStack == EmptyTOS;
}


int IsFull(Stack S)
{
    return S->TopOfStack == (MinStackSize - 1);
}
void MakeEmpty(Stack S)
{
    S->TopOfStack = EmptyTOS;
}

void Push(ElementType X, Stack S)
{
    if (IsFull(S))
    {
        Error("Full Stack");
    }
    else
    {
        S->Array[++S->TopOfStack] = X;
    }
}

void Pop(Stack S)
{
    if (IsEmpty(S))
    {
        Error("Empty stack");
    }
    else
    {
        S->TopOfStack--;
    }
}

ElementType Top(Stack S)
{
    if (!IsEmpty(S))
    {
        return S->Array[S->TopOfStack];
    }
    
    Error("Empty stack");
    
    return 0; // return value used to avoid warning
}

ElementType TopAndPop(Stack S)
{
    if (!IsEmpty(S))
    {
        return S->Array[S->TopOfStack--];
    }
    
    Error("Empty stack");
    
    return 0; // return value used to avoid warning
}

