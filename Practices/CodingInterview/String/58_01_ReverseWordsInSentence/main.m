//
//  main.m
//  58_01_ReverseWordsInSentence
//
//  Created by ShannonChen on 2018/6/4.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "StringUtil.h"
/*
 
 题58（一）：翻转单词顺序
 题目：输入一个英文句子，翻转句子中单词的顺序，但单词内字符的顺序不变。
 为简单起见，标点符号和普通字母一样处理。例如输入字符串"I am a student. "，
 则输出"student. a am I"。
 
 */

/*
 
 
 分析：
 
 如果用 ObjC 来实现的话，可以直接将字符串转成数组，然后再调换数组重元素的顺序，最后再重新拼接成字符串。
 
 
 如果是用 C 来实现的话，首先将字符串中所有的字符逆序排列，然后再讲各个单词逆序：
 " .tneduts a ma I"
 " student. a am I"
 
 */

NSString *reverseWordsInSentence_ObjC(NSString *sentence) {
    if (sentence == nil) return nil;
    
    NSArray <NSString *> *wordsInArray = [sentence componentsSeparatedByString:@" "];
    
    NSArray <NSString *> *reversedWordsInArray = [[wordsInArray reverseObjectEnumerator] allObjects];
    NSString *reversedSentence = [reversedWordsInArray componentsJoinedByString:@" "];
    
    NSLog(@"[%@]", reversedSentence);
    
    return reversedSentence;

}

void reverseWordsInSentence_c(char* sentence) {
    if (sentence == NULL) {
        return;
    }
    
    // 翻转字符串
    char* pStart = sentence;
    char* pEnd = sentence;
    while (*pEnd != '\0') {
        pEnd++;       // O(n)
    }
    pEnd--;
    
    ReverseString(pStart, pEnd);
    
    
    // 反转各个单词
    /*
    char* pCurrent = pStart;
    while (*pCurrent != '\0') {
        if (*pCurrent == ' ') {
            pCurrent++;
            continue;
        }
        
        // 反转单个单词
        char* pWordStart = pCurrent;
        char* pWordEnd = pCurrent;
        
        while (*pWordEnd != ' ' && *pWordEnd != '\0') {
            pWordEnd++;
        }
        pWordEnd--;
        
        ReverseString(pWordStart, pWordEnd);
        
        pCurrent = pWordEnd + 1;
    }
     
     */
    
    pStart = pEnd = sentence; // 从头开始
    while (pStart != '\0') {
        if (*pStart == ' ') {  // 开头位置为空格
            pStart++;
            pEnd++;
        } else if (*pEnd == '\0' || *pEnd == ' ') { // 一个单词的结尾
            pEnd--;
            ReverseString(pStart, pEnd); // 翻转一个单词
            
            pEnd++;
            pStart = pEnd;
        } else {
            pEnd++;
        }
    }
    
    printf("[%s]\n", pStart);
    
}



int main(int argc, const char * argv[]) {
    reverseWordsInSentence_ObjC(@"I am an iOS  developer. ");
    
    char s[] = "I am an iOS  developer. ";
    reverseWordsInSentence_c(s);
    return 0;
}
