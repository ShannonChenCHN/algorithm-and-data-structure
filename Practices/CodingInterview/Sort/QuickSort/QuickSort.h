//
//  QuickSort.h
//  AlgorithmPractices
//
//  Created by ShannonChen on 2018/6/5.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#ifndef QuickSort_h
#define QuickSort_h

#include <stdio.h>

int partion(int* input, int startIndex, int endIndex);
int randomPartion(int* input, int startIndex, int endIndex);
void quickSort(int* input, int firstIndex, int lastIndex);

#endif /* QuickSort_h */
