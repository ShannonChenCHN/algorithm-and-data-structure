//
//  main.cpp
//  11_MinNumberInRotatedArray
//
//  Created by ShannonChen on 2018/3/28.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>

// 第11题：旋转数组的最小数字
// 题目：把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。
// 输入一个递增排序的数组的一个旋转，输出旋转数组的最小元素。
// 例如数组 {3, 4, 5, 1, 2} 为 {1, 2, 3, 4, 5} 的一个旋转，该数组的最小值为1。

/*
 
 分析思路：
 跟二分法很相似，因为数组本身是排好序的，旋转后的数组中可以看成是两个排好序的小数组，最左边的元素肯定是大于或者等于最右边的元素（有一个特例是：旋转数组正好是数组本身）。
 所以我们可以用两个指针，一个指向最左边，一个指向最右边。然后再找一个中间的数字，判断这个数字是在前面的小数组中，还是后面的小数组中。如果它大于或者等于左边指针所指的数字，那么它就是在前面的数组中，最小的元素就在这个数的后面，反之，这个数就是在后面的数组中，最小的元素就在这个数的前面。
 
 {3, 4, 5, 1, 2}
  ^     |     ^
 
 5 > 3 所以，最小数在 5 的右边，接着再将左指针移到中间的数字
 
 {3, 4, 5, 1, 2}
        ^  |  ^
 
 1 < 5 所以，最小数在 5 的右边和 2 的左边，接着再将右指针移到中间的数字
 
 {3, 4, 5, 1, 2}
        ^  ^
        |
 
 此时只有 2 个数字了，所以就是 1 了
 
 
 
 
 特殊情况：
 
 - 旋转数组正好是数组本身 -----> 如果发现最左边的数字小于最右边的数字，就说明第一个数字就是最小值
 - 最左边、最右边和中间的数字都一样大，比如 {1, 1, 1, 0, 1} 和  {1, 1, 0, 1, 1, 1} -----> 只能按照顺序查找的方法来查找了
 
 */

#include <exception>


/// 线性查找
int LinearSearchMinimumNumberInArray(int *numbers, int leftIndex, int rightIndex);

/// 查找最小值
int SearchMinimumNumberInArray(int *numbers, int length) {
    if (numbers == nullptr || length <= 0) {
        throw std::exception(); // Invalid Input!
    }
    
    int leftIndex = 0;
    int rightIndex = length - 1;
    int minIndex = 0; // 如果发现最左边的数字小于最右边的数字，就说明第一个数字就是最小值
    
    while (numbers[leftIndex] >= numbers[rightIndex]) {
        // 前提是最左边的数字大于或者等于最右边的数字
        
        if (rightIndex - leftIndex == 1) {
            // 最后只剩 2 个数字时，也就是大数组和小数组的交界处
            minIndex = rightIndex;
            break;
        }
        
        int middleIndex = (leftIndex + rightIndex) / 2;
        
        if (numbers[leftIndex] == numbers[rightIndex] &&
            numbers[rightIndex] == numbers[middleIndex]) {
            // 如果最左边、最右边和中间的数字都一样大，比如 {1, 1, 1, 0, 1}
            // 线性查找
            return LinearSearchMinimumNumberInArray(numbers, leftIndex, rightIndex);
        }
        
        
        // 缩小查找范围
        if(numbers[middleIndex] >= numbers[leftIndex]) {
            // 最小数在右边
            
            leftIndex = middleIndex;
        } else if(numbers[middleIndex] <= numbers[rightIndex]) {
            // 最小数在左边
            
            rightIndex = middleIndex;
        }
        
    }
    
    return numbers[minIndex];
}

/// 线性查找
int LinearSearchMinimumNumberInArray(int *numbers, int leftIndex, int rightIndex) {
    int result = numbers[leftIndex];
    for(int i = leftIndex + 1; i <= rightIndex; ++i) {
        if(result > numbers[i]) {
            result = numbers[i];
        }
    }
    
    return result;
}

// ====================测试代码====================
void Test(int* numbers, int length, int expected) {
    int result = 0;
    try
    {
        
        for(int i = 0; i < length; ++i) {
            printf("%d ", numbers[i]);
        }
        
        result = SearchMinimumNumberInArray(numbers, length);
        
        if(result == expected) {
            printf("\n\tpassed\n");
        } else {
            printf("\n\tfailed\n");
        }
    }
    catch (...)
    {
        if(numbers == nullptr) {
            printf("\nTest passed.\n");
        } else {
            printf("\nTest failed.\n");
        }
    }
}


int main(int argc, const char * argv[]) {
    
    // 典型输入，单调升序的数组的一个旋转
    int array1[] = { 3, 4, 5, 1, 2 };
    Test(array1, sizeof(array1) / sizeof(int), 1);
    
    // 有重复数字，并且重复的数字刚好的最小的数字
    int array2[] = { 3, 4, 5, 1, 1, 2 };
    Test(array2, sizeof(array2) / sizeof(int), 1);
    
    // 有重复数字，但重复的数字不是第一个数字和最后一个数字
    int array3[] = { 3, 4, 5, 1, 2, 2 };
    Test(array3, sizeof(array3) / sizeof(int), 1);
    
    // 有重复的数字，并且重复的数字刚好是第一个数字和最后一个数字
    int array4[] = { 1, 0, 1, 1, 1 };
    Test(array4, sizeof(array4) / sizeof(int), 0);
    
    // 单调升序数组，旋转0个元素，也就是单调升序数组本身
    int array5[] = { 1, 2, 3, 4, 5 };
    Test(array5, sizeof(array5) / sizeof(int), 1);
    
    // 数组中只有一个数字
    int array6[] = { 2 };
    Test(array6, sizeof(array6) / sizeof(int), 2);
    
    // 输入nullptr
    Test(nullptr, 0, 0);
    
    return 0;
}
