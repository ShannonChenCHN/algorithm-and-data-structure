//
//  main.c
//  05_ReplaceSpaces
//
//  Created by ShannonChen on 2018/3/26.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <stdio.h>
#include <string.h>

// 第5题：替换空格
// 题目：请实现一个函数，把字符串中的每个空格替换成"%20"。例如输入“We are happy.”，
// 则输出“We%20are%20happy.”。
//
// 延伸：URL 参数转换规则是在 % 后面加上 ASII 码的两位十六进制，比如空格的 ASII 码是 32，十六进制就是 0x20，因此空格就被替换成 %20

/*
 char 类型相关概念：https://github.com/ShannonChenCHN/iOSLevelingUp/issues/99#issuecomment-376074724
 
 字符串以 '\0' 字符结尾。
 
 char *string 是指针
 char string[] 是数组
 
 以下面四个字符串为例：
 char *string1 = "I Love U";
 char *string2 = "I Love U";
 char string3[] = "I Love U";
 char string4[] = "I Love U";
 
 结论是：
 string1 == string2 成立
 string3 == string4 不成立
 
 因为，string1 和 string2 是指针，为了节省内存，C/C++吧常量字符串放到一个单独的内存区域，所以，当几个指针指向相同的常量字符串时，它们实际上指向的是同一个地址。
 string3 和 string4 是数组，我们会为他们分配两个长度为 9 个字节的空间，并把 "I Love U" 的内容分别复制到两个数组中去，所以这是两个起始地址不同的数组。
 
 */

/*
 
 方案一：
 
 在原来的字符串上做替换：
 
 方案 A：从前到后，扫描整个字符串，一旦发现空格（1个字节），就将其替换为 %20（3个字节），然后再将后面的字符统一后移 2 位。
 
        时间复杂度为 O(n²)
 
 方案 B：先计算整个字符串有多少个空格，然后从后往前，扫描整个字符串，依次将各个字符移到后面的指定位置，如果遇到空格就替换成 %20
 
        时间复杂度为 O(n)
 
        |W|e| |a|r|e| |h|a|p|p|y|.|\0|             2 个空格
        |W|e| |a|r|e| |h|a|p|p|y|.|\0| | | | |     多预留 4 个字符的空间
        |W|e| |a|r|e| |h|a|p|p|y|.|  | | | |\0|    从后往前扫描，依次复制/替换
 
        ...
 
        |W|e| | | |a|r|e|%|2|0|h|a|p|p|y|.|\0|
 
        |W|e|%|2|0|a|r|e|%|2|0|h|a|p|p|y|.|\0|
 
 
 方案二：
 
 创建新字符串，并在新的字符串上做替换
 
 
 
 */


// length 为字符数组str的总容量，大于或等于字符串str的实际长度
void replaceWhiteSpaceWithString(char originalString[], int length) {
    
    if (originalString == NULL || length <= 0) {
        return;
    }
    
    // 统计空格个数
    int lengthOfOriginalString = 0;  // originalLength 为字符串 originalString 的实际长度，包括 '\0'
    int nummberOfWhiteSpace = 0;
    int i = 0;
    while (originalString[i] != '\0') {
        
        lengthOfOriginalString++;
        
        if (originalString[i] == ' ') {
            nummberOfWhiteSpace++;
        }
        
        i++;
    }
    
    // newLength 为把空格替换成'%20'之后的长度
    int newLength = lengthOfOriginalString + nummberOfWhiteSpace * 2;
    if(newLength > length) return;

    // 从后往前逐个复制/替换
    int indexOfOriginal = lengthOfOriginalString;
    int indexOfNew = newLength;
    while (indexOfOriginal >= 0 && indexOfOriginal < indexOfNew) { // 每个循环都有限制条件
//        printf("%c\n", originalString[indexOfOriginal]);
        
        if (originalString[indexOfOriginal] != ' ') {
            originalString[indexOfNew] = originalString[indexOfOriginal];
            indexOfNew--;
        } else {
            originalString[indexOfNew] = '0';
            originalString[indexOfNew - 1] = '2';
            originalString[indexOfNew - 2] = '%';
            indexOfNew = indexOfNew - 3;
            
        }
        
        indexOfOriginal--;
        
    }
    
    
    
}


#pragma mark - 测试
//====================测试代码=================
void test(char *testName, char originalString[], int length, char expectedResult[]) {
    
    if (testName != NULL) {
        printf("%s begins: ", testName);
    }
    
    replaceWhiteSpaceWithString(originalString, length);
    
    if(expectedResult == NULL && originalString == NULL) {
        // 结果和预期都为 NULL
        
        printf("passed.\n");
    } else if (expectedResult == NULL && originalString != NULL) {
        // 预期为 NULL，但是结果不为 NULL
        
        printf("failed.\n");
    } else if(strcmp(originalString, expectedResult) == 0) {
        // 预期和结果相同
        
        printf("passed.\n");
    } else {
        printf("failed.\n");
    }
    
}

// 空格在句子中间
void test1() {
    const int length = 100;
    
    char str[length] = "hello world"; // 这里必须要声明数组大小，为了有足够大小来替换空格
    test("Test1", str, length, "hello%20world");
}

// 空格在句子开头
void test2() {
    const int length = 100;
    
    char str[length] = " helloworld";
    test("Test2", str, length, "%20helloworld");
}

// 空格在句子末尾
void test3() {
    const int length = 100;
    
    char str[length] = "helloworld ";
    test("Test3", str, length, "helloworld%20");
}

// 连续有两个空格
void test4() {
    const int length = 100;
    
    char str[length] = "hello  world";
    test("Test4", str, length, "hello%20%20world");
}

// 传入NULL
void test5() {
    test("Test5", NULL, 0, NULL);
}

// 传入内容为空的字符串
void test6() {
    const int length = 100;
    
    char str[length] = "";
    test("Test6", str, length, "");
}

//传入内容为一个空格的字符串
void test7() {
    const int length = 100;
    
    char str[length] = " ";
    test("Test7", str, length, "%20");
}

// 传入的字符串没有空格
void test8() {
    const int length = 100;
    
    char str[length] = "helloworld";
    test("Test8", str, length, "helloworld");
}

// 传入的字符串全是空格
void test9() {
    const int length = 100;
    
    char str[length] = "   ";
    test("Test9", str, length, "%20%20%20");
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
    
    return 0;
}
