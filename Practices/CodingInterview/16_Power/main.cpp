//
//  main.cpp
//  16_Power
//
//  Created by ShannonChen on 2018/4/8.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>

// 第16题：数值的整数次方
// 题目：实现函数double Power(double base, int exponent)，求base的exponent
// 次方。不得使用库函数，同时不需要考虑大数问题。


/*
 分析：需要考虑一下 exponent 为负数，以及 base 为 0 的情况。
 
 优化：逐个累乘效率比较低，可以用公式 Power(base, exponent) = Power(base, exponent/2) * Power(base, exponent/2) （exponent 为偶数）
                                                     = Power(base, exponent/2) * Power(base, exponent/2) * base （exponent 为奇数）
 */

bool g_InvalidInput = false;

double PowerWithUnsignedExponent(double base, unsigned int exponent);
bool DoubleIsEqual(double a, double b);

double Power(double base, int exponent) {
    g_InvalidInput = false; // 确保全局变量初始值为 false
    
    if (base == 0 && exponent < 0) {
        g_InvalidInput = true;
        return 0.0;
    }
    
    double result = 0;
    
    if (exponent < 0) {
        // 如果指数小于 0，取 exponent 的绝对值
        exponent = (unsigned int)-exponent;
        result = 1.0 / PowerWithUnsignedExponent(base, exponent);
        
    } else {
        result = PowerWithUnsignedExponent(base, exponent);
    }
    
    return result;
}

/*
 // 方案一：累乘
double PowerWithUnsignedExponent(double base, unsigned int exponent) {
    
    double result = 1;
    for (int i = 1; i <= exponent; i++) {
        result *= base;
    }
    
    return result;
}
 
 */


// 方案二：递归
double PowerWithUnsignedExponent(double base, unsigned int exponent) {
    
    if (exponent == 0) {
        return 1;
    }
    
    if (exponent == 1) {
        return base;
    }
    
    // 先计算出 a 的 n/2 次方
    double result = PowerWithUnsignedExponent(base, exponent >> 1);  // 这里用移位代替除以 2 ，比除法更高效
    
    // 再自相乘
    result *= result;
    
    // 如果是奇数，就再乘以基数
    if ((exponent & 0x1) == 1) {  // 这里用与运算代替除以 2 求余数，比除法更高效
        result *= base;
    }
    
    return result;
    
}

// 因为计算机在处理小数时可能会出现误差，所以在判断相等性时做估算
bool DoubleIsEqual(double a, double b) {
    
    if (a - b < 0.0000001 && a - b > -0.0000001) {
        return true;
    } else {
        return false;
    }
}


void Test(const char* testName, double base, int exponent, double expected, bool expectedFlag) {
    printf("\n============\n");
    
    if (testName != nullptr) {
        printf("%s Begins.", testName);
    }
    
    double result = Power(base, exponent);
    
    if (DoubleIsEqual(result, expected) && g_InvalidInput == expectedFlag) {
         printf("\nTest Passed.\n");
    } else {
        printf("\nTest Failed.\n");
    }
    
    printf("\n============\n");
}


int main(int argc, const char * argv[]) {
    
    // 底数、指数都为正数
    Test("Test1", 2, 3, 8, false);
    
    // 底数为负数、指数为正数
    Test("Test2", -2, 3, -8, false);
    
    // 指数为负数
    Test("Test3", 2, -3, 0.125, false);
    
    // 指数为0
    Test("Test4", 2, 0, 1, false);
    
    // 底数、指数都为0
    Test("Test5", 0, 0, 1, false);
    
    // 底数为0、指数为正数
    Test("Test6", 0, 4, 0, false);
    
    // 底数为0、指数为负数
    Test("Test7", 0, -4, 0, true);
    
    return 0;
}
