//
//  main.m
//  Queue
//
//  Created by ShannonChen on 2017/11/21.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Queue.h"
#import "EfficientQueue.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        Queue <NSString *> *queue = [[Queue alloc] init];
        [queue enqueueObject:@"Ada"];
        NSLog(@"%@", queue);
        
        [queue enqueueObject:@"Jim"];
        NSLog(@"%@", queue);
        
        NSLog(@"Count: %@, Front: %@", @(queue.count), queue.front);
        
        [queue dequeue];
        NSLog(@"%@", queue);
        
        [queue dequeue];
        NSLog(@"%@", queue);
        
        
        
        EfficientQueue <NSString *> *efficientQueue = [[EfficientQueue alloc] init];
        [efficientQueue enqueueObject:@"Ada"];
        NSLog(@"%@", efficientQueue);
        
        [efficientQueue enqueueObject:@"Jim"];
        NSLog(@"%@", efficientQueue);
        
        NSLog(@"Count: %@, Front: %@", @(efficientQueue.count), efficientQueue.front);
        
        [efficientQueue dequeue];
        NSLog(@"%@", efficientQueue);
        
        [efficientQueue dequeue];
        NSLog(@"%@", efficientQueue);
    }
    return 0;
}
