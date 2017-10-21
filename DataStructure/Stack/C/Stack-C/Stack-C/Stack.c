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
struct StackRecord {
    int Capacity;           /// 栈的容量
    int TopOfStack;         /// 栈顶元素的索引，初始值为 -1
    ElementType *Array;     /// 栈内部存储栈元素的数组，其实是一个指针数组，元素为指向 int 类型变量的指针
};


/// 创建栈
Stack CreateStack(int MaxElements) {
    
    Stack S;
    
    if (MaxElements < MinStackSize) {
        Error("Stack size is too small");
    }
    
    /// 给栈的创建申请内存空间
    S = malloc(sizeof(struct StackRecord));
    if (S == NULL) {
        FatalError("Out of space");
    }
    
    // 初始化数组：给数组申请内存空间
    S->Array = malloc(sizeof(ElementType) * MaxElements);
    
    if (S->Array == NULL) {
        FatalError("Out of space");
    }
    
    // 初始化栈的容量
    S->Capacity = MaxElements;
    
    // 初始化栈顶元素
    S->TopOfStack = EmptyTOS;
    
    return S;
}


/// 销毁栈
void DisposeStack(Stack S) {
    if (S != NULL) {
        free(S->Array); // 释放存放栈元素的数组（指针数组）
        free(S);        // 释放栈（结构体指针）
    }
    
}

/// 栈是否为空
int IsEmpty(Stack S) {
    return S->TopOfStack == EmptyTOS;  // 栈顶元素为空，代表栈为空
}


/// 栈是否已满
int IsFull(Stack S) {
    return (S->TopOfStack) == (S->Capacity - 1);
}

/// 清空栈
void MakeEmpty(Stack S) {
    S->TopOfStack = EmptyTOS;
}

/// 压栈：push 一个新元素
void Push(ElementType X, Stack S) {
    if (IsFull(S)) {
        Error("Full Stack");
    } else {
        S->Array[++(S->TopOfStack)] = X;
    }
}

/// 出栈：pop 一个元素
void Pop(Stack S) {
    if (IsEmpty(S)) {
        Error("Empty stack");
    } else {
        (S->TopOfStack)--;
    }
}


/// 栈顶的元素
ElementType Top(Stack S) {
    if (!IsEmpty(S)) {
        return S->Array[S->TopOfStack];
    }
    
    Error("Empty stack");
    
    return 0; // return value used to avoid warning
}


/// 获取栈顶的元素，然后 pop
ElementType TopAndPop(Stack S) {
    if (!IsEmpty(S)) {
        return S->Array[S->TopOfStack--];
    }
    
    Error("Empty stack");
    
    return 0; // return value used to avoid warning
}

