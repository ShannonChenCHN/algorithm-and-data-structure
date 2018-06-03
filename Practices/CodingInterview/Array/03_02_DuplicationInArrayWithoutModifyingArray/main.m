//
//  main.m
//  03_02_DuplicationInArrayWithoutModifyingArray
//
//  Created by ShannonChen on 2018/3/25.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <stdio.h>
#include <stdbool.h>

// 第3题（二）：不修改数组找出重复的数字
// 题目：在一个长度为n+1的数组里的所有数字都在1到n的范围内，所以数组中至
// 少有一个数字是重复的。请找出数组中任意一个重复的数字，但不能修改输入的
// 数组。例如，如果输入长度为8的数组{2, 3, 5, 4, 3, 2, 6, 7}，那么对应的
// 输出是重复的数字2或者3。


/*
 
 解决思路：
 
 方案一：
 创建一个长度相同的新数组 newArray，将原数组中的各元素逐个复制到新数组中。如果原数组中被复制的数字为 m，则把它复制到新数组中下标为 m 的位置。如果 newArray[m] 不为空，则说明有重复的元素了。这个方案其实跟题目一中的方案三相似，只不过那里用的是哈希表。
 
 空间复杂度为 O(n)
 
 方案二：
 
 因为数组大小为 n + 1，元素大小却是 1~n，所以一定会有重复的，所以可以采用二分法来实现。
 取中间值 m = n/2，判断数组中 1~m 的数字有多少个，如果超过 m 个，则再对前 m 个数字进行二分查找。
 如果没有超过 m 个，则对后半部分的数字进行二分查找。
 
 n = 8
 {2, 3, 5, 4, 3, 2, 6, 7}   1~7
 
 middle = 4  1~4, 5~7
 
 {2, 3, 4, 3, 2}  1~4  count = 5 > 4
 {5, 6, 7}        5~7  count = 3
 
 middle = 2  1~2, 3~4
 
 {2, 2}       1~2  count = 2
 {3, 4, 3}    3~4  count = 3
 
middle = 3   3, 4
 
 {3, 3}       3    count = 2
 {4}          4    count = 1
 
 */

int countOfRangeInArray(const int *numbers, int countOfNumbers, int start, int end);


int getDuplication(const int *numbers, int countOfNumbers) {
    if(numbers == NULL || countOfNumbers <= 0)
        return -1;
    
    int start = 1;
    int end = countOfNumbers - 1;
    
    while(end >= start) {  // 起点一定不大于终点，每个循环都要有限制条件
        
        // 取中点
        int middle = ((end - start) >> 1) + start;
        
        // 前半部分的个数
        int count = countOfRangeInArray(numbers, countOfNumbers, start, middle);
        
        // 这个时候就不能再分了，也就是把最后一次只有 2 个元素的数组进行二分得到的结果
        if(end == start) {
            if(count > 1) {
                return start;
            } else {
                // 非法输入，比如数组中有不符合 1~n 范围的数字
                break;
            }
        }
        
        // 继续二分法
        if(count > (middle - start + 1)) {
            // 在前半部分
            
            end = middle;
        } else {
            // 在后半部分
            
            start = middle + 1;
        }
    }
    return -1;
}


/**
 统计数组中符合指定大小区间的数字的个数

 @param numbers 数组
 @param countOfNumbers 数组大小
 @param start 区间起点
 @param end 区间终点
 @return 个数
 */
int countOfRangeInArray(const int *numbers, int countOfNumbers, int start, int end) {
    
    if(numbers == NULL) {
        return 0;
    }
    
    // 遍历数组，只要有一个符合 count 就  + 1
    int count = 0;
    for(int i = 0; i < countOfNumbers; i++) {
        if(numbers[i] >= start && numbers[i] <= end) {
            ++count;
        }
    }
    return count;
}

// ====================测试代码====================
void test(const char *testName, int *numbers, int length, int *duplications, int dupLength) {
    
    int result = getDuplication(numbers, length);
    
    for(int i = 0; i < dupLength; ++i) {
        if(result == duplications[i]) {
            printf("\n%s passed.\n", testName);
            return;
        }
    }
    printf("\n%s FAILED.\n", testName);
}

// 多个重复的数字
void test1() {
    int numbers[] = { 2, 3, 5, 4, 3, 2, 6, 7 };
    int duplications[] = { 2, 3 };
    test("test1", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int));
}

// 一个重复的数字
void test2() {
    int numbers[] = { 3, 2, 1, 4, 4, 5, 6, 7 };
    int duplications[] = { 4 };
    test("test2", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int));
}

// 重复的数字是数组中最小的数字
void test3() {
    int numbers[] = { 1, 2, 3, 4, 5, 6, 7, 1, 8 };
    int duplications[] = { 1 };
    test("test3", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int));
}

// 重复的数字是数组中最大的数字
void test4() {
    int numbers[] = { 1, 7, 3, 4, 5, 6, 8, 2, 8 };
    int duplications[] = { 8 };
    test("test4", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int));
}

// 数组中只有两个数字
void test5() {
    int numbers[] = { 1, 1 };
    int duplications[] = { 1 };
    test("test5", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int));
}

// 重复的数字位于数组当中
void test6() {
    int numbers[] = { 3, 2, 1, 3, 4, 5, 6, 7 };
    int duplications[] = { 3 };
    test("test6", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int));
}

// 多个重复的数字
void test7() {
    int numbers[] = { 1, 2, 2, 6, 4, 5, 6 };
    int duplications[] = { 2, 6 };
    test("test7", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int));
}

// 一个数字重复三次
void test8() {
    int numbers[] = { 1, 2, 2, 6, 4, 5, 2 };
    int duplications[] = { 2 };
    test("test8", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int));
}

// 没有重复的数字
void test9() {
    int numbers[] = { 1, 2, 6, 4, 5, 3 };
    int duplications[] = { -1 };
    test("test9", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int));
}

// 无效的输入
void test10() {
    int* numbers = NULL;
    int duplications[] = { -1 };
    test("test10", numbers, 0, duplications, sizeof(duplications) / sizeof(int));
}

int main(int argc, const char * argv[]) {
        
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
     
        printf("\n==============");
        printf("\n\n");
    return 0;
}
