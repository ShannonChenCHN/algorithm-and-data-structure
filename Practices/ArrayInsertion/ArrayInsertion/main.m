//
//  main.m
//  ArrayInsertion
//
//  Created by ShannonChen on 2018/1/26.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+SCInsertion.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableArray <NSString *> *array = @[@"Paul", @"Jenny", @"Lindsay", @"Michael"].mutableCopy;
//        [array sc_insertObjects:@[@"Shannon", @"George", @"Hannah"]
//                      atIndexes:@[@(0), @(2), @(2)]];
        
        
        [array sc_insertObjects:@[@"Shannon", @"George", @"Hannah"]
                      atIndexes:@[@(0), @(2), @(5)]];
        
        NSLog(@"%@", array);
        
    }
    return 0;
}
