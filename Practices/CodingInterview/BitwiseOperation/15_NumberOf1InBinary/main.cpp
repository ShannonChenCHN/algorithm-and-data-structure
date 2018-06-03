//
//  main.cpp
//  15_NumberOf1InBinary
//
//  Created by ShannonChen on 2018/3/28.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>


// 第15题：二进制中1的个数
// 题目：请实现一个函数，输入一个整数，输出该数二进制表示中1的个数。例如
// 把9表示成二进制是1001，有2位是1。因此如果输入9，该函数输出2。


// 解法1：从最低位开始，一位一位跟 1 进行与运算
// 时间复杂度为：O(n)
// 例如： 1001
//      1001       1001   1001   1001
//      0001       0010   0100   1000
//      ----       ----   ----   ----
//      0001       0000   0000   1000
int NumberOfNumOneInBinary_Solution1(int num) {
    
    int count = 0;
    
    unsigned int flag = 1;
    while (flag) {
        if (num & flag) {
            count++;
        }
        
        flag = flag << 1;
    }
    
    return count;
}


// 解法2：任何一个整数减 1 后再跟原数进行与运算，就可以将最右边的 1 变成 0
// 规律：① 任何一个整数，减 1 后，都相当于对其二进制数的最右边的 1 及之后的每一位都取反，比如 10100000，减 1 后，就变成 10011111
//      ② 由上一个规律再进一步，对一个整数 减 1 再跟原数进行与运算，就会把最右边的 1 变成 0，比如 10100000，减 1 再跟原数进行与运算，就变成 10000000
// 时间复杂度：O(1)
int NumberOfNumOneInBinary_Solution2(int num) {
    
    int count = 0;
    
    while (num) {  // 只要这个数不等于 0，就至少有一位是 1
        count++;
        num = (num - 1) & num;
    }
    
    return count;
}

void Test(const char *testName, int number, int expected) {
    
    printf("\n============\n");
    
    if (testName != nullptr) {
        printf("%s Begins.", testName);
    }
    
    int result = NumberOfNumOneInBinary_Solution2(number);
    
    if (result == expected) {
        printf("\nTest Passed.\n");
    } else {
        printf("\nTest Failed.\n");
    }
    
    printf("\n============\n");
}

int main(int argc, const char * argv[]) {
    
    // 4,  100
    Test("Test1", 4, 1);
    
    // 5, 101
    Test("Test2", 5, 2);
    
    // 输入0，期待的输出是0
    Test("Test3", 0, 0);
    
    // 输入1，期待的输出是1
    Test("Test4", 1, 1);
    
    // 输入10，期待的输出是2
    Test("Test5", 10, 2);
    
    // 输入0x7FFFFFFF，期待的输出是31
    Test("Test6", 0x7FFFFFFF, 31);
    
    // 输入0xFFFFFFFF（负数），期待的输出是32
    Test("Test7", 0xFFFFFFFF, 32);
    
    // 输入0x80000000（负数），期待的输出是1
    Test("Test8", 0x80000000, 1);

    
    return 0;
}
