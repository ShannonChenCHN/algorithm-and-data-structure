//
//  main.cpp
//  10_Fibonacci
//
//  Created by ShannonChen on 2018/3/28.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>


/*
 第 10 题：斐波那契数列
 题目：写一个函数，输入n，求斐波那契（Fibonacci）数列的第n项。
         0 (n <= 0)
 f(n) =  1 (n = 1)
         f(n-1) + f(n-2) (n > 1)
 
 */


// 方案一：递归
/*
          f(5)
         /   \
      f(4)   f(3)
      / \     /  \
  f(3) f(2) f(2) f(1)
  / \
f(2) f(1)   ...
 ...
 
 */
long long int fibonacci_Solution1(unsigned int n) {
    if (n <= 0) {
        return 0;
    }
    
    if (n == 1) {
        return 1;
    }
    
    return fibonacci_Solution1(n-1) + fibonacci_Solution1(n-2);
}

// 方案二：循环
long long int fibonacci_Solution2(unsigned int n) {
    
    int results[2] = {0, 1};
    if (n <= 1) {
        return results[n];
    }
    
    long long fibNMinusTwo = 0;
    long long fibNMinusOne = 1;
    long long fibN = 0;
    for (int i = 2; i <= n; i++) {
        fibN = fibNMinusOne + fibNMinusTwo;
        
        fibNMinusTwo = fibNMinusOne;
        fibNMinusOne = fibN;
    }
    
    return fibN;
}


// ====================测试代码====================
void Test(const char* testName, int n, int expected) {
    if (testName != nullptr) {
        printf("%s Begins.\n", testName);
    }
    
    long long result = fibonacci_Solution2(n);
    if (result == expected) {
        printf("Test Passed.\n\n");
    } else {
        printf("Test Failed.\n\n");
    }
}


int main(int argc, const char * argv[]) {
    
    Test("Test1", 0, 0);
    
    Test("Test2", 1, 1);
    
    Test("Test3", 2, 1);
    
    Test("Test4", 3, 2);
    
    Test("Test5", 4, 3);
    
    return 0;
}
