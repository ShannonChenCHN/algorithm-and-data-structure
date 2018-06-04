//
//  main.m
//  58_02_LeftRotateString
//
//  Created by ShannonChen on 2018/6/4.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringUtil.h"

// 题58（二）：左旋转字符串
// 题目：字符串的左旋转操作是把字符串前面的若干个字符转移到字符串的尾部。
// 请定义一个函数实现字符串左旋转操作的功能。比如输入字符串"abcdefg"和数
// 字2，该函数将返回左旋转2位得到的结果"cdefgab"。

/*
 
 abcdefg
 
 
 ab  cdefg
 
 cdefgab
 
 
 分析：
 
 （1）objc 中的实现：先将字符串分成两部分——前 n 位字符和后面剩下的字符，然后再将这两段子字符串重新拼接起来。
 
 （2）C 的实现：跟上一道题类似，先翻转整个字符串，然后再分别翻转后 n 位，以及前面剩下的一部分字符。例如 “abcdefg” --> "gfedcba" --> "cdefgab"
 
       或者先分别翻转前后两部分子字符串，然后再翻转整个字符串。
 
 */


NSString *leftRotateString_ObjC(NSString *string, NSUInteger n) {
    if (string == nil) {
        return nil;
    }
    
    if (string.length == 0 || n >= string.length || n <= 0) {
        return string;
    }
    
    
    NSString *firstPart = [string substringToIndex:n];
    NSString *secondPart = [string substringFromIndex:n];
    
    return [secondPart stringByAppendingString:firstPart];
}

void leftRotateString_c(char * pStr, int n) {
    if (pStr == NULL) {
        return;
    }
    
    char* pStart = pStr;
    
    int length = 0;
    while (*pStart != '\0') {
        pStart++;
        length++;
    }
    
    if (length == 0 || n <= 0 || n >= length) {
        return;
    }
    
    ReverseString(pStr, pStr+(length-1)); //  “abcdefg” --> "gfedcba"
    ReverseString(pStr, pStr+(length-n-1));  //  "gfedcba" --> "cdefgba"
    ReverseString(pStr+(length-n), pStr+(length-1));  //  "cdefgba" --> "cdefgab"
    
}

int main(int argc, const char * argv[]) {
    
    NSString *result = leftRotateString_ObjC(@"abcdefg", 2);
    
    char s[] = "abcdefg";
    leftRotateString_c(s, 2);
    
    return 0;
}
