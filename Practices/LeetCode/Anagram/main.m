//
//  main.m
//  Anagram
//
//  Created by ShannonChen on 2018/6/1.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 https://github.com/ShannonChenCHN/DataStructure-Algorithm-Notes/issues/4
 
 描述
 Given two strings s and t, write a function to determine if t is an anagram of s.
 For example,
 s = "anagram", t = "nagaram", return true. s = "rat", t = "car", return false.
 
 Note:
 You may assume the string contains only lowercase alphabets.
 
 */

#define ALPHABET_SIZE  26

BOOL isAnagram(NSString *s, NSString *t) {
    if (s.length != t.length) {
        return NO;
    }
    
    int map[ALPHABET_SIZE] = {}; // C 数组必须要初始化，才能保证所有元素初始值为 0
    for (int i = 0; i < s.length; i++) {
        int indexForS = [s characterAtIndex:i] - 'a';
        map[indexForS] = map[indexForS] + 1;
        
        int indexForT = [t characterAtIndex:i] - 'a';
        map[indexForT] = map[indexForT] - 1;
    }
    
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        if (map[i] != 0) {
            return NO;
        }
    }
    
    return YES;
}

void testWithStrings(NSString *s, NSString *t, BOOL expected) {
    if (isAnagram(s, t) == expected) {
        printf("Test Passed.\n");
    } else {
        printf("Test Failed.\n");
    }
}

void test1() {
    NSString *s = @"anagram";
    NSString *t = @"nagaram";
    
    testWithStrings(s, t, YES);
}

void test2() {
    NSString *s = @"rat";
    NSString *t = @"car";
    
    testWithStrings(s, t, NO);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test1();
        test2();
    }
    return 0;
}
