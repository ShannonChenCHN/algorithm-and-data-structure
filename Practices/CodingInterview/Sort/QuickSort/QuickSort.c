//
//  QuickSort.c
//  AlgorithmPractices
//
//  Created by ShannonChen on 2018/6/5.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include "QuickSort.h"
#include <stdlib.h>

void swap(int* num1, int* num2) {
    int temp = *num1;
    *num1 = *num2;
    *num2 = temp;
}

int randomPartion(int* input, int startIndex, int endIndex) {
    int random = arc4random() % (endIndex - startIndex + 1) + startIndex; // 取随机的 pivot
    
    swap(&input[random], &input[endIndex]);
    
    int pivot = partion(input, startIndex, endIndex);
    
    return pivot;
}

int partion(int* input, int startIndex, int endIndex) {
    
    int pivot = input[endIndex];
    int firstIndexOfBigPart = startIndex; // 记录后半部分的第一个索引值
    for (int i = startIndex; i < endIndex; i++) {
        if (input[i] <= pivot) {
            swap(&input[firstIndexOfBigPart], &input[i]);
            
            firstIndexOfBigPart++;
        }
    }
    
    input[endIndex] = input[firstIndexOfBigPart];
    input[firstIndexOfBigPart] = pivot;
    
    return firstIndexOfBigPart;
}


void quickSort(int* input, int firstIndex, int lastIndex) {
    
    if (firstIndex < lastIndex) {
        int pivot = partion(input, firstIndex, lastIndex);  // 将比 lastIndex 小的放前面，大的放后面
        quickSort(input, firstIndex, pivot - 1); // 对前半部分进行递归排序
        quickSort(input, pivot + 1, lastIndex);  // 对后半部分进行递归排序
    }
    
}
