//
//  main.m
//  04_FindInPartiallySortedMatrix
//
//  Created by ShannonChen on 2018/3/26.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <stdio.h>
#include <stdbool.h>

// 第4题：二维数组中的查找
// 题目：在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按
// 照从上到下递增的顺序排序。请完成一个函数，输入这样的一个二维数组和一个
// 整数，判断数组中是否含有该整数。


/*
 
 二维数组相关概念：https://github.com/ShannonChenCHN/iOSLevelingUp/issues/99#issuecomment-376065751
 
 比如有这样一个二位数组，从中查找数字 7
 
 ------------->
  1  2  8   9   |
  2  4  9   12  |
  5  7  10  13  |
  6  10 12  15  |
                \/
 
 方案一：
 从第一行开始，从左到右，从上到下逐行扫描，直到找到最终结果。
 
 方案二：
 每一行的末尾数字最大，每一列的首个数字最小，从右上角（一行中最大，一列中最小）开始找。
 9比7大，去掉最后一列，8比7大，去掉倒数第二列，2比7小，去掉第一行，4比7小，去掉第二行，最终找到了 7。
 
 错误检查：
 - 数组不为null
 - 数组不为空，rowCount > 0 columnCount > 0
 
 测试用例：
 - 要查找的数在数组中
 - 要查找的数不在数组中
 - 要查找的数是数组中最小的数字
 - 要查找的数是数组中最大的数字
 - 要查找的数比数组中最小的数字还小
 - 要查找的数比数组中最大的数字还大
 - 鲁棒性测试，输入空指针
 
 */


bool searchNumInMatrix(int *matrix, int rowCount, int columnCount, int numberToSearch) {
    
    bool found = false;
    if (matrix != NULL && rowCount > 0 && columnCount > 0) {
        
        // 右上角
        int row = 0;
        int column = columnCount - 1;
        while (row <= rowCount - 1 && column >= 0) { // 每个循环都要有限制条件
            
            int currentNum = matrix[row * columnCount + column];
            if (currentNum == numberToSearch) {
                // 如果正好相等
                
                found = true;
                break;
            } else if (currentNum > numberToSearch) {
                // 如果当前数字比要查找的数字大
                // 删除列
                
                column -= 1;
            } else {
                // 如果当前数字比要查找的数字小
                // 删除行
                
                row += 1;
            }
            
        }
    }
    
    return found;
}

#pragma mark - 测试
// ====================测试代码====================
void test(char *testName, int *matrix, int rowCount, int columnCount, int numberToSearch, bool expectedResult) {
    
    if(testName != NULL) {
        printf("%s begins: ", testName);
    }
    
    bool result = searchNumInMatrix(matrix, rowCount, columnCount, numberToSearch);
    if(result == expectedResult) {
        printf("Passed.\n");
    } else {
        printf("Failed.\n");
    }
}

//  1   2   8   9
//  2   4   9   12
//  4   7   10  13
//  6   8   11  15
// 要查找的数在数组中
void test1() {
    int matrix[][4] = {{1, 2, 8, 9}, {2, 4, 9, 12}, {4, 7, 10, 13}, {6, 8, 11, 15}};
    test("Test1", (int*)matrix, 4, 4, 7, true);
}

//  1   2   8   9
//  2   4   9   12
//  4   7   10  13
//  6   8   11  15
// 要查找的数不在数组中
void test2() {
    int matrix[][4] = {{1, 2, 8, 9}, {2, 4, 9, 12}, {4, 7, 10, 13}, {6, 8, 11, 15}};
    test("Test2", (int*)matrix, 4, 4, 5, false);
}

//  1   2   8   9
//  2   4   9   12
//  4   7   10  13
//  6   8   11  15
// 要查找的数是数组中最小的数字
void test3() {
    int matrix[][4] = {{1, 2, 8, 9}, {2, 4, 9, 12}, {4, 7, 10, 13}, {6, 8, 11, 15}};
    test("Test3", (int*)matrix, 4, 4, 1, true);
}

//  1   2   8   9
//  2   4   9   12
//  4   7   10  13
//  6   8   11  15
// 要查找的数是数组中最大的数字
void test4() {
    int matrix[][4] = {{1, 2, 8, 9}, {2, 4, 9, 12}, {4, 7, 10, 13}, {6, 8, 11, 15}};
    test("Test4", (int*)matrix, 4, 4, 15, true);
}

//  1   2   8   9
//  2   4   9   12
//  4   7   10  13
//  6   8   11  15
// 要查找的数比数组中最小的数字还小
void test5() {
    int matrix[][4] = {{1, 2, 8, 9}, {2, 4, 9, 12}, {4, 7, 10, 13}, {6, 8, 11, 15}};
    test("Test5", (int*)matrix, 4, 4, 0, false);
}

//  1   2   8   9
//  2   4   9   12
//  4   7   10  13
//  6   8   11  15
// 要查找的数比数组中最大的数字还大
void test6() {
    int matrix[][4] = {{1, 2, 8, 9}, {2, 4, 9, 12}, {4, 7, 10, 13}, {6, 8, 11, 15}};
    test("Test6", (int*)matrix, 4, 4, 16, false);
}

// 鲁棒性测试，输入空指针
void test7() {
    test("Test7", NULL, 0, 0, 16, false);
}

int main(int argc, const char * argv[]) {

    test1();
    test2();
    test3();
    test4();
    test5();
    test6();
    test7();
    
    
    return 0;
}
