//
//  EfficientQueue.h
//  Queue
//
//  Created by ShannonChen on 2017/11/21.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EfficientQueue<ObjectType> : NSObject

@property (assign, nonatomic, readonly) NSUInteger count;
@property (assign, nonatomic, readonly) BOOL isEmpty;
@property (strong, nonatomic, readonly) ObjectType front;

- (ObjectType)dequeue;
- (void)enqueueObject:(ObjectType)object;

@end
