//
//  main.m
//  03_01_DuplicationInArray
//
//  Created by ShannonChen on 2018/3/25.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdbool.h>


/*
 面试题3（一）：找出数组中重复的数字
 题目：在一个长度为n的数组里的所有数字都在0到n-1的范围内。数组中某些数字是重复的，但不知道有几个数字重复了，
 也不知道每个数字重复了几次。请找出数组中任意一个重复的数字。例如，如果输入长度为7的数组{2, 3, 1, 0, 2, 5, 3}，
 那么对应的输出是重复的数字2或者3。
 
 
 解决思路：
 
 方案一：
 从头到尾按顺序扫描整个数组，每扫到一个数字，就将其跟后面的数字逐个对比
 
 扫描的时间复杂度 O(n)，对比的时间复杂度 O(logn)，所以总的时间复杂度为 O(nlogn)
 
 方案二：
 先将数组排序，然后再扫描数组找出重复数字。
 
 排序的时间复杂度为 O(nlogn)，扫描的时间复杂度为 O(n)
 
 方案三：
 从头到尾按顺序扫描整个数组，每扫到一个数字，就用O(1)的时间来判断哈希表中是否已经包含这个数字，没有包含就加入，包含了就说明重复了。
 
 时间复杂度为 O(n)，空间复杂度为O(n)
 
 
 方案四：
 
 首先从头到尾扫描这个数组，当扫描到下标为 i 的数字时，首先【比较】这个数字的值（假设为 m）是不是等于它的下标 i。如果是，就接着扫描下一个数字；如果不是，就拿它和第 m 个数字进行【比较】。如果它和第 m 个数字相等，就找到了，如果不相等，就互相【交换】位置。然后再继续重复这个比较、交换的过程，直到找到重复的数字为止。
 
 {2, 3, 1, 0, 2, 5, 3}
 ^     ^
 
 {1, 3, 2, 0, 2, 5, 3}
 ^     ^
 
 {1, 3, 2, 0, 2, 5, 3}
 ^  ^
 
 {3, 1, 2, 0, 2, 5, 3}
 ^  ^
 
 {3, 1, 2, 0, 2, 5, 3}
 ^        ^
 
 {0, 1, 2, 3, 2, 5, 3}
 ^        ^
 
 {0, 1, 2, 3, 2, 5, 3}
 ^     ^
 
 
 test case（完整性、边界条件）
 
 
 */




/**
 <#Description#>
 
 @param numbers 一个整数数组
 @param length 数组大小
 @param duplication 要找出的重复数字
 @return 是否找到结果，返回 true 则输入有效，并且数组中存在重复的数字。返回false 则输入无效，或者数组中没有重复的数字
 */
bool searchDuplicateNumber(int numbers[], int length, int *duplication) {
    
    // 0. 错误处理
    // 0.1 数组不能为 null 或者长度小于 0
    if (numbers == NULL || length <= 0) {
        return false;
    }
    
    // 0.1 数组中每个元素的大小都不能超过 0~n
    // 注：个人认为这里的判断其实也耗费了时间，为什么不放到后面的算法中去判断？
    for (int i = 0; i < length; i++) {
        if (numbers[i] < 0 || numbers[i] > length - 1) {
            return false;
        }
    }
    
    // 1. 查找重复数字
    // 1.1
    for (int i = 0; i < length; i++) {
        
        while (numbers[i] != i) {
            
            // 找到了
            if (numbers[i] == numbers[numbers[i]]) {
                *duplication = numbers[i];
                return true;
            }
            
            // 没找到就交换交换 numbers[i] 和 numbers[numbers[i]] 的位置
            int temp = numbers[i];
            numbers[i] = numbers[temp];
            numbers[temp] = temp;
        }
    }
    
    return false;
}

#pragma mark - 测试代码
// ====================测试代码====================
/// 给定的数组 array 中是否包含指定的数字 number
bool contains(int array[], int length, int number) {
    
    for(int i = 0; i < length; ++i) {
        if(array[i] == number) {
            return true;
        }
    }
    
    return false;
}

/// 编写一个测试函数，大概需要哪些要素？
/// 测试用例名，输入参数，预期结果

/**
 测试函数入口
 
 @param testName 测试用例名
 @param numbers 要查找的数组
 @param countOfNumbers 数组长度
 @param expectedResults 保存预期结果的数组
 @param countOfExpectedResults 保存预期结果的数组的长度
 @param foundOrNot 是否找到了结果
 */
void test(char *testName, int numbers[], int countOfNumbers, int expectedResults[], int countOfExpectedResults, bool foundOrNot) {
    
    printf("%s begins: ", testName);
    
    // 计算结果
    int duplication;
    bool hasFoundOrNot = searchDuplicateNumber(numbers, countOfNumbers, &duplication);
    
    // 判断查找结果和预期结果是否相符
    if (foundOrNot == hasFoundOrNot) {
        // 如果相符
        
        if (foundOrNot) {
            // 如果找到了重复数字
            
            if (contains(expectedResults, countOfExpectedResults, duplication)) {
                printf("Passed.\n");
            } else {
                printf("FAILED.\n");
            }
        }
        else {
            printf("Passed.\n");
        }
    }
    else {
        // 如果不相符
        printf("FAILED.\n");
    }
}

// 重复的数字是数组中最小的数字
void test1() {
    int numbers[] = {2, 1, 3, 1, 4};
    int duplications[] = {1};
    test("Test1", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int), true);
}

// 重复的数字是数组中最大的数字
void test2() {
    int numbers[] = {2, 4, 3, 1, 4};
    int duplications[] = {4};
    test("Test2", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int), true);
}

// 数组中存在多个重复的数字
void test3() {
    int numbers[] = { 2, 4, 2, 1, 4 };
    int duplications[] = { 2, 4 };
    test("Test3", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int), true);
}

// 没有重复的数字
void test4() {
    int numbers[] = { 2, 1, 3, 0, 4 };
    int duplications[] = { -1 }; // not in use in the test function
    test("Test4", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int), false);
}

// 没有重复的数字
void test5() {
    int numbers[] = { 2, 1, 3, 5, 4 };
    int duplications[] = { -1 }; // not in use in the test function
    test("Test5", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int), false);
}

// 无效的输入
void test6() {
    int *numbers = NULL;
    int duplications[] = { -1 }; // not in use in the test function
    test("Test6", numbers, 0, duplications, sizeof(duplications) / sizeof(int), false);
}


#pragma mark - main 函数
int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        test1();
        test2();
        test3();
        test4();
        test5();
        test6();
        
        printf("\n==============");
        printf("\n\n");
    }
    return 0;
}
