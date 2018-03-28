//
//  main.cpp
//  15_NumberOf1InBinary
//
//  Created by ShannonChen on 2018/3/28.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>


// 110101

int NumberOfNumOneInBinary(int num) {
    
    int count = 0;
    
    while (num) {
        num = (num - 1) & num;
        count++;
    }
    
    return count;
}

void Test(const char *testName, int number, int expected) {
    
    printf("\n============\n");
    
    if (testName != nullptr) {
        printf("%s Begins.", testName);
    }
    
    int result = NumberOfNumOneInBinary(number);
    
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
    
    
    return 0;
}
