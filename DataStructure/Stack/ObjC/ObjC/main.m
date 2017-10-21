//
//  main.m
//  ObjC
//
//  Created by ShannonChen on 2017/9/24.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCStack.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 创建栈对象
        SCStack <NSString *> *stack = [[SCStack alloc] init];
        
        // push 一个新对象
        [stack push:@"Mike"];
        
        NSLog(@"Top: %@", stack.top);
        NSLog(@"Count: %lu", (unsigned long)stack.count);
        NSLog(@"Is Stack empty? %@", stack.isEmpty ? @"YES" : @"NO");
        
        // push 一个新对象
        [stack push:@"Lucy"];
        
        // for-in 快速枚举
        NSInteger i = 0;
        for (NSString *string in stack) {
            NSLog(@"%@: %@", @(i), string);
            i++;
        }
        
        // push 一个新对象
        [stack push:@"Shannon"];
        
        // block 枚举
        [stack enumerateObjectsUsingBlock:^(NSString * _Nonnull string, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@: %@", @(idx), string);
            
            if ([string isEqualToString:@"Lucy"]) {
                *stop = YES;
            }
        }];
        
        NSLog(@"%@", stack);
        
    }
    return 0;
}
