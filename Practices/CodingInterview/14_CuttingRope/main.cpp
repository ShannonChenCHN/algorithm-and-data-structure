//
//  main.cpp
//  14_CuttingRope
//
//  Created by ShannonChen on 2018/3/28.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>


// 第14题：剪绳子
// 题目：给你一根长度为n绳子，请把绳子剪成m段（m、n都是整数，n>1并且m≥1）。
// 每段的绳子的长度记为k[0]、k[1]、……、k[m]。k[0]*k[1]*…*k[m]可能的最大乘
// 积是多少？
//
// 例如当绳子的长度是8时，我们把它剪成长度分别为2、3、3的三段，此
// 时得到最大的乘积18。


/*
 
 动态规划：
 1. 求最优解
 2. 可分解为小问题
 3. 小问题之间有重叠
 4. 从上往下分析问题，从下往上求解问题
 
 
 剪绳子的问题可以抽象成：
 
 f(<=0) = 0;
 f(1) = 0;
 f(2) = 1;
 f(3) = 3;
 f(4) = Max(f(1) * f(3), f(2) * f(2));
 f(5) = Max(f(1) * f(4), f(2) * f(3));
 f(6) = Max(f(1) * f(5), f(2) * f(4), f(3) * f(3));
 ...
 f(n) = Max(f(1) * f(n-1), f(2) * f(n-2), ...);
 
 */


// ====================动态规划====================
int maxProductAfterCutting_solution1(int length) {
    if(length < 2) {
        return 0;
    } else if(length == 2) {
        return 1;
    } else if(length == 3) {
        return 2;
    }
    
//    int solutions[length + 1]; // 因为数组大小不确定，所以这里只能用动态数组
    int* solutions = new int[length + 1];
    // 因为前四个作为子部分的话，可以不被切，所以其本身的长度就是最大的值
    solutions[0] = 0;
    solutions[1] = 1;
    solutions[2] = 2;
    solutions[3] = 3;
    
    for (int tempLength = 4; tempLength <= length; tempLength++) { // 从 4 开始到 length
        
        int maxSolution = 0;
        for (int subLength = 1; subLength <= tempLength / 2; subLength++) {
            
            int solution = solutions[subLength] * solutions[tempLength - subLength];
            
            if (solution > maxSolution) {
                maxSolution = solution;
            }
            
            solutions[tempLength] = maxSolution;
        }
    }
    
    int result = solutions[length];
    delete [] solutions;
    
    return result;
}

// ====================贪婪算法====================
int maxProductAfterCutting_solution2(int length) {
    // TODO
    
    return 0;
    
}


// ====================测试代码====================
void test(const char* testName, int length, int expected)
{
    int result1 = maxProductAfterCutting_solution1(length);
    if(result1 == expected)
        std::cout << "Solution1 for " << testName << " passed." << std::endl;
    else
        std::cout << "Solution1 for " << testName << " FAILED." << std::endl;
    
//    int result2 = maxProductAfterCutting_solution2(length);
//    if(result2 == expected)
//        std::cout << "Solution2 for " << testName << " passed." << std::endl;
//    else
//        std::cout << "Solution2 for " << testName << " FAILED." << std::endl;
}

void test1()
{
    int length = 1;
    int expected = 0;
    test("test1", length, expected);
}

void test2()
{
    int length = 2;
    int expected = 1;
    test("test2", length, expected);
}

void test3()
{
    int length = 3;
    int expected = 2;
    test("test3", length, expected);
}

void test4()
{
    int length = 4;
    int expected = 4;
    test("test4", length, expected);
}

void test5()
{
    int length = 5;
    int expected = 6;
    test("test5", length, expected);
}

void test6()
{
    int length = 6;
    int expected = 9;
    test("test6", length, expected);
}

void test7()
{
    int length = 7;
    int expected = 12;
    test("test7", length, expected);
}

void test8()
{
    int length = 8;
    int expected = 18;
    test("test8", length, expected);
}

void test9()
{
    int length = 9;
    int expected = 27;
    test("test9", length, expected);
}

void test10()
{
    int length = 10;
    int expected = 36;
    test("test10", length, expected);
}

void test11()
{
    int length = 50;
    int expected = 86093442;
    test("test11", length, expected);
}

int main(int agrc, char* argv[]) {
    test1();
    test2();
    test3();
    test4();
    test5();
    test6();
    test7();
    test8();
    test9();
    test10();
    test11();
    
    return 0;
}
