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


/**
 栈的创建
 
 @param MaxElements 栈的最大容量
 @return 一个结构体指针
 */
Stack CreateStack(int MaxElements);


/**
 销毁栈

 @param S 要销毁的栈
 */
void DisposeStack(Stack S);


/// 是否是空的
int IsEmpty(Stack S);

/// 是否已经满了
int IsFull(Stack S);

///
void MakeEmpty(Stack S);

void Push(ElementType X, Stack S);
void Pop(Stack S);
ElementType Top(Stack S);
ElementType TopAndPop(Stack S);


#endif /* Stack_h */
