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
 
 
 
 方案二：递归打印各位数
 
 
 */


// 方案一：从 1 开始一个一个累加，从最低位开始加，逢十进一
/*
  [0][0][1][\0]
 ...
 [0][0][9][\0]
 [0][1][0][\0]
 
 */
bool Increment(char* numString) {
    
    // 从最低位开始加，逢十进一
    int maxDigit = (int)strlen(numString);
    for (int currentDigit = maxDigit - 1; currentDigit >= 0; currentDigit--) {
        
        int currentDigitASCII = numString[currentDigit] - '0'; // 取出当前位字符转成一个整数
        
        if (currentDigitASCII == 9) {
            // 逢十进一
            numString[currentDigit] = '0';
            continue;
            
        } else {
            currentDigitASCII++; // 当前位数加 1
            numString[currentDigit] = currentDigitASCII + '0'; // 将数字转成对应的字符，并赋值给当前位
            
            return true;
        }
        
    }
    
    return false;
}

void PrintNumber(char* numString) {
    
}

void PrintOneToMaxOfNDigits_Solution1(int maxDigit) {
    if (maxDigit <= 0) {
        return;
    }
    
    char* numString = new char[maxDigit+1]; // 最后有一位 \0
    memset(numString, '0', maxDigit);
    numString[maxDigit] = '\0';
    
    while (Increment(numString)) {
        printf("%s\n", numString);
    }
    
    
    delete [] numString;
    
}


void PrintOneToMaxOfNDigits_Solution2(int maxDigit) {
    
    
}


int main(int argc, const char * argv[]) {
    
    PrintOneToMaxOfNDigits_Solution1(2);
    
    return 0;
}
