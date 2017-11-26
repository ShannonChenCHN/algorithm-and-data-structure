//
//  EfficientQueue.m
//  Queue
//
//  Created by ShannonChen on 2017/11/21.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "EfficientQueue.h"

@interface EfficientQueue ()

@property (strong, nonatomic) NSMutableArray *array;
@property (assign, nonatomic) NSInteger headIndex;

@end

@implementation EfficientQueue

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
        _headIndex = 0;
    }
    return self;
}

- (BOOL)isEmpty {
    return (self.count == 0);
}

- (NSUInteger)count {
    return self.array.count - self.headIndex;
}

- (id)front {
    if (self.isEmpty) {
        return nil;
    }
    
    return self.array[self.headIndex];
}

- (id)dequeue {
    if (self.isEmpty) {
        return nil;
    }
    
    // 移除
    id objectToRemove = self.front;
    self.array[self.headIndex] = [NSNull null];
    self.headIndex++;
    
    // 定期清理空值
    double percentage = self.headIndex / (double)(self.array.count);
    if (percentage > 0.25 && self.count > 100) {
        [self.array removeObjectsInRange:NSMakeRange(0, self.headIndex)];
        self.headIndex = 0;
    }
    
    return objectToRemove;
}

- (void)enqueueObject:(id)object {
    [self.array addObject:object];
}

- (NSString *)description {
    
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"EfficientQueue: ["];
    
    for (id <NSObject> element in self.array) {
        if ([element isKindOfClass:[NSNull class]]) {
            continue;
        }
        
        if (element != self.front) {
            [string appendString:@", "];
        }
        
        [string appendString:element.description];
    }
    
    [string appendString:@"]"];
    
    return string;
}

@end
