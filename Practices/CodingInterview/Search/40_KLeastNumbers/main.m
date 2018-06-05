//
//  main.m
//  KLeastNumbers
//
//  Created by ShannonChen on 2018/6/5.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QuickSort.h"

// 题40：最小的k个数
// 题目：输入n个整数，找出其中最小的k个数。例如输入4、5、1、6、2、7、3、8
// 这8个数字，则最小的4个数字是1、2、3、4。

// 先用快排算法按照从小到大的顺序排序，然后再找到前 k 个
// 时间复杂度O(nlogn)
void getLeastNumbers_Solution0(int* input, int n, int* output, int k) {
    
    // 快排排序
    quickSort(input, 0, n-1);
    
    // 取出前 4 个元素
    for (int i = 0; i < k; i++) {
        output[i] = input[i];
    }
}

// 类似于快排，利用 randomPartion 函数来排序，同时基于数组的第 k 个元素来调整，
// 这样就使得比第 k 个数字小的排在前面，大的排在后面，但是不需要整个数组的所有元素都排好序
// 时间复杂度O(n)
void getLeastNumbers_Solution1(int* input, int n, int* output, int k) {
    
    int index = randomPartion(input, 0, n - 1);
    
    while (index != k - 1) {
        if (index > k - 1) {
            // 如果是在前半部分
            index = randomPartion(input, 0, index - 1);
        } else {
            // 如果是在后半部分
            index = randomPartion(input, index + 1, n - 1);
        }
    }
    
    // 取出前 4 个元素
    for (int i = 0; i < k; i++) {
        output[i] = input[i];
    }
}


int main(int argc, const char * argv[]) {
    int a[] = {7,15,21,36,72,23,13,35,21,36,72,23,13,35};
    int b[4] = {};
//    getLeastNumbers_Solution0(a, 14, b, 4);
    getLeastNumbers_Solution1(a, 14, b, 4);
    
    return 0;
}
