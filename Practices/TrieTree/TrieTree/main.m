//
//  main.m
//  TrieTree
//
//  Created by ShannonChen on 2018/6/13.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 相比 Set 和 Array，Trie 的优势：
 - 查找单词更高效
 - prefix 匹配
 
 
 Trie 的结构：
 
- Trie 也是一颗 Tree
 
 
 */


/*
 假如现在给你10万个长度不超过10的单词，对于每一个单词，我们要判断它出没出现过，如果出现了，求第一次出现在第几个位置。
 
 
 */




NSInteger findWordInList(NSString *target, NSArray <NSString *> *list) {
    
    // 方法1：从前往后依次遍历整个数组，直到找到该单词
    // 假设数组的长度为 n, 目标单词的长度为 m，复杂度就是 O(m*n)
    __block NSInteger result = -1;
    [list enumerateObjectsUsingBlock:^(NSString * _Nonnull string, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([string isEqualToString:target]) {
            result = idx;
        }
    }];
    
    return result;
}




int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *stringList = @[@"hard", @"good", @"result", @"target"];
        
        NSInteger index = findWordInList(@"target", stringList);
        
        
        
    }
    return 0;
}
