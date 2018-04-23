//
//  main.cpp
//  17_Print1ToMaxOfNDigits
//
//  Created by ShannonChen on 2018/4/9.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>

/*
 第17题：打印1到最大的n位数
 题目：输入数字n，按顺序打印出从1最大的n位十进制数。比如输入3，则
 打印出1、2、3一直到最大的3位数即999（最左边第一个不为0的位数之前都不能为0）。
 
 
 
 注意：需要考虑大数问题，所以不能直接用 int、long 等数据类型，需要用数组来表示
 
      010        990
 001  011   ...  991
 002  012   ...  992
 ...  ...        ...
 009  019        999
 
 
 
 */



/*
 公共函数：打印字符串数字的有效位
 最左边的 0 不打印，从最高位开始遍历，直到发现第一个不为 0 的数字，开始打印
 */
void PrintNumber(char* numString) {
    
    bool hasStartedPrinting = false;
    int length = (int)strlen(numString);
    for (int i = 0; i < length; i++) {
        if (hasStartedPrinting == false && numString[i] == '0') {
            continue;
        }
        
        printf("%c", numString[i]);
        hasStartedPrinting = true;
    }
}


//===================================== 方案一 循环打印 ====================================

bool IncrementNumString_Solution1(char* numString);

// 方案一：循环的方式
void PrintOneToMaxOfNDigits_Solution1(int maxDigit) {
    if (maxDigit <= 0) {
        return;
    }
    
    // 初始化一个数组，用来存储各位的数字，最后有一位 \0
    char* numString = new char[maxDigit+1];
    memset(numString, '0', maxDigit);
    numString[maxDigit] = '\0';
    
    while (IncrementNumString_Solution1(numString)) { // 一个一个累加
//        printf("%s\n", numString);
        PrintNumber(numString);
        printf("\n");
    }
    
    
    delete [] numString;
    
}


// 从 1 开始一个一个累加，从最低位开始加，逢十进一
/*
 [0][0][1][\0]
 ...
 [0][0][9][\0]
 [0][1][0][\0]
 
 */
bool IncrementNumString_Solution1(char* numString) {
    
    // 从最低位开始加，逢十进一
    int maxDigit = (int)strlen(numString);
    for (int currentDigit = maxDigit - 1; currentDigit >= 0; currentDigit--) {
        
        int currentDigitASCII = numString[currentDigit] - '0'; // 取出当前位字符转成一个整数
        
        if (currentDigitASCII == 9) {
            // 逢十进一，当前位置 0
            numString[currentDigit] = '0';
            continue;
            
        } else {
            currentDigitASCII++; // 当前位数加 1
            numString[currentDigit] = currentDigitASCII + '0'; // 将数字转成对应的字符，并赋值给当前位
            
            return true;
        }
        
    }
    
    // 当超过 n 位最大数的时候就返回 false
    return false;
}

//===================================== 方案一 递归打印 ====================================

void IncrementNumString_Solution2(int startDigit, char* numString);

// 方案二：递归打印各位数
/**
 通过递归实现数字字符串打印
 可以把这个数字字符串想象成树，从最高位开始，每设置一位的值（0~9）就往下一位递归设置，直到最后一位就开始打印
 假如 n=2
 
 十位            个位
  0   -->  0, 1, 2, ... 9
  1   -->  0, 1, 2, ... 9
      ...
  9   -->  0, 1, 2, ... 9
 
 
 
 */
void PrintOneToMaxOfNDigits_Solution2(int maxDigit) {
    
    if (maxDigit <= 0) {
        return;
    }
    
    // 初始化一个数组，用来存储各位的数字，最后有一位 \0
    char* numString = new char[maxDigit+1];
    memset(numString, '0', maxDigit);
    numString[maxDigit] = '\0';
    
    int currentDigit = 0;
    int nextDigit = currentDigit + 1;
    for (int i = 0; i <= 9; i++) {
        numString[0] = '0' + i;
        IncrementNumString_Solution2(nextDigit, numString);
    }
    
}


void IncrementNumString_Solution2(int startDigit, char* numString) {
    int length = (int)strlen(numString);
    
    if (startDigit >= length) {
//        printf("%s\n", numString);
        PrintNumber(numString);
        printf("\n");
        return;
    }
    
    
    int nextDigit = startDigit + 1;
    for (int i = 0; i <= 9; i++) {
        numString[startDigit] = '0' + i;
        IncrementNumString_Solution2(nextDigit, numString);
    }
}


int main(int argc, const char * argv[]) {
    
    PrintOneToMaxOfNDigits_Solution1(2);
    PrintOneToMaxOfNDigits_Solution2(2);
    
    return 0;
}
