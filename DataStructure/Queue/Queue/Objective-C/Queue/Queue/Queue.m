//
//  Queue.m
//  Queue
//
//  Created by ShannonChen on 2017/11/21.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "Queue.h"

@interface Queue ()

@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation Queue

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isEmpty {
    return (self.count == 0);
}

- (NSUInteger)count {
    return self.array.count;
}

- (id)front {
    if (self.count == 0) {
        return nil;
    }
    
    return self.array.firstObject;
}

- (id)dequeue {
    if (self.array.count == 0) {
        return nil;
    }
    
    id objectToRemove = self.array.firstObject;
    [self.array removeObjectAtIndex:0];
    
    return objectToRemove;
}

- (void)enqueueObject:(id)object {
    [self.array addObject:object];
}

- (NSString *)description {
    
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"Queue: ["];
    for (id <NSObject> element in self.array) {
        if (element != self.array.firstObject) {
            [string appendString:@", "];
        }
        
        [string appendString:element.description];
    }
    
    [string appendString:@"]"];
    
    return string;
}

@end
