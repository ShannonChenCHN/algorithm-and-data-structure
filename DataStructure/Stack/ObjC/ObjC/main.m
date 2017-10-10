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
        
        NSLog(@"Hello, World!");
        
        SCStack <NSString *> *stack = [[SCStack alloc] init];
        [stack push:@"Mike"];
        
        NSLog(@"Top: %@", stack.top);
        NSLog(@"Count: %lu", (unsigned long)stack.count);
        NSLog(@"Is Stack empty? %@", stack.isEmpty ? @"YES" : @"NO");
        
        [stack push:@"Lucy"];
        
        for (NSString *string in stack) {
            NSLog(@"%@", string);
        }
        
    }
    return 0;
}
